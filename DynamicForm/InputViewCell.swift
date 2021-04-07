//
//  InputViewCell.swift
//  DynamicForm
//
//  Created by Macintosh on 06/04/21.
//

import UIKit

protocol InputViewCellDelegate: class {
    func editingChanged(_ textField: IDefaultTextField)
    func textFieldDidEndEditing(_ textField: IDefaultTextField)
    func textFieldShouldReturn(_ textField: IDefaultTextField) -> Bool
    func textFieldShouldBeginEditing(_ textField: IDefaultTextField) -> Bool
}

class InputViewCell: UITableViewCell {
    var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.layoutMargins = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var inputTextField: IDefaultTextField = {
        let textField = DefaultTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(cancel(_:)))
    
    weak var delegate: InputViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        let views = verticalStackView.arrangedSubviews
        views.forEach { (view) in
            view.removeFromSuperview()
        }
        contentView.addSubview(verticalStackView)
        verticalStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        verticalStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(inputTextField)
        inputTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        selectionStyle = .none
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.setItems([spaceButton,doneButton], animated: false)
        inputTextField.inputAccessoryView = toolbar
        inputTextField.delegate = self
    }
    
    @objc
    private func cancel(_ sender: UIButton) {
        let _ = delegate?.textFieldShouldReturn(inputTextField)
    }
    
    @objc
    private func editingChanged(_ sender: UITextField) {
        guard let textField = sender as? DefaultTextField else { return }
        inputTextField.validate()
        delegate?.editingChanged(textField)
    }

    func config(with model: InputDataModel, indexPath: IndexPath) {
        titleLabel.text = model.placeholder
        inputTextField.tag = indexPath.row
        inputTextField.isEnabled = model.enabled
        inputTextField.isRequired = model.isRequired
        inputTextField.placeholder = model.placeholder
        inputTextField.text = model.key
        inputTextField.regex = model.type.regex
        inputTextField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        inputTextField.showRightView(isValid: true)
        inputTextField.autocorrectionType = .no
        switch model.type {
        case .number, .nik, .npwp, .currency:
            inputTextField.keyboardType = .numberPad
        case .email:
            inputTextField.keyboardType = .emailAddress
        case .phone:
            inputTextField.keyboardType = .phonePad
        default:
            inputTextField.keyboardType = .default
        }
        inputTextField.inputView = nil
    }
}

extension InputViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let textField = textField as? DefaultTextField else { return true }
        return delegate?.textFieldShouldReturn(textField) ?? true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        guard let textField = textField as? DefaultTextField else { return true }
        return delegate?.textFieldShouldBeginEditing(textField) ?? true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let textField = textField as? DefaultTextField else { return }
        delegate?.textFieldDidEndEditing(textField)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textField = textField as? DefaultTextField else { return true }
        if string.count > 0 {
            textField.value += string
        } else {
            textField.value = String(textField.value.dropLast())
        }
        return true
    }
}

class CurrencyInputViewCell: InputViewCell {
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textField = textField as? DefaultTextField else { return true }
        if string.count > 0 {
            textField.value += string
            textField.text = textField.value.toCurrency()
        } else {
            textField.value = String(textField.value.dropLast())
            if textField.value.count > 0 {
                textField.text = textField.value.toCurrency()
            } else {
                textField.text = "Rp 0"
            }
        }
        if let maximum = textField.maximum {
            let isValid = textField.value.toDouble() <= maximum
            textField.showRightView(isValid: isValid)
        } else {
            textField.showRightView(isValid: true)
        }
        textField.sendActions(for: .editingChanged)
        return false
    }
}
