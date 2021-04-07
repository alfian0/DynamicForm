//
//  DropDownViewCell.swift
//  DynamicForm
//
//  Created by Macintosh on 06/04/21.
//

import UIKit

class DropDownViewCell: InputViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        inputTextField = DropdownTextField()
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        inputTextField.showRightView(isValid: true)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class NationalityInputViewCell: DropDownViewCell {
    override func config(with model: InputDataModel, indexPath: IndexPath) {
        super.config(with: model, indexPath: indexPath)
        
        inputTextField.inputView = GenericPickerView<NationalityType>(items: NationalityType.allCases, titleForRow: { (item) -> String? in
            return item.value
        }, selectionHandler: { [weak self] (item) in
            self?.inputTextField.text = item.value
            self?.inputTextField.value = item.value
            self?.inputTextField.sendActions(for: .editingChanged)
        })
    }
}
