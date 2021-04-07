//
//  DefaultTextField.swift
//  DynamicForm
//
//  Created by Macintosh on 06/04/21.
//

import UIKit

protocol IDefaultTextField where Self: UITextField {
    var button: UIButton { get set }
    var chevron: UIImageView { get set }
    var isRequired: Bool { get set }
    var regex: String { get set }
    var value: String { get set }
    var maximum: Double? { get set }
    
    func showRightView(isValid: Bool)
    func validate()
}

extension IDefaultTextField {
    func validate() {
        let isValid = isRequired ? (text?.regex(with: regex) ?? true) : true
        showRightView(isValid: isValid)
    }
}

class DefaultTextField: UITextField, IDefaultTextField {
    var button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
        button.setImage(UIImage(named: "danger"), for: .normal)
        button.tintColor = .systemRed
        button.addTarget(self, action: #selector(onTapInfo(_:)), for: .touchUpInside)
        return button
    }()
    var chevron: UIImageView = {
        let chevron = UIImageView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
        chevron.image = UIImage(named: "ic_chevron_down")?.withRenderingMode(.alwaysTemplate)
        return chevron
    }()
    var isRequired: Bool = true
    var regex: String = "^.{1,}$"
    var value: String = ""
    var maximum: Double? = nil
    
    @objc
    private func onTapInfo(_ sender: UIButton) {
        resignFirstResponder()
    }
    
    func showRightView(isValid: Bool) {
        rightView = isValid ? nil : button
        rightViewMode = isValid ? .never : .always
    }
}

class DropdownTextField: DefaultTextField {
    override func showRightView(isValid: Bool) {
        rightView = isValid ? chevron : button
        rightViewMode = .always
    }
}
