//
//  GenericPickerView.swift
//  DynamicForm
//
//  Created by Macintosh on 06/04/21.
//

import UIKit

class GenericPickerView<T>: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    var items: [T] = [] {
        didSet {
            reloadAllComponents()
        }
    }
    private var titleForRow: ((T) -> String?)?
    private var selectionHandler: ((T) -> Void)?
    
    init(items: [T], titleForRow: ((T) -> String?)?, selectionHandler: ((T) -> Void)?) {
        super.init(frame: .zero)
        self.items = items
        self.titleForRow = titleForRow
        self.selectionHandler = selectionHandler
        self.delegate = self
        self.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return titleForRow?(items[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectionHandler?(items[row])
    }
}
