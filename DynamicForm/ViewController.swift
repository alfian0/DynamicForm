//
//  ViewController.swift
//  DynamicForm
//
//  Created by Macintosh on 06/04/21.
//

import UIKit

class ViewController: UITableViewController {
        
    private var items: [InputDataModel] = []
    
    init(items: [InputDataModel]) {
        self.items = items
        super.init(style: .plain)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(InputViewCell.self, forCellReuseIdentifier: "InputViewCell")
        tableView.register(NationalityInputViewCell.self, forCellReuseIdentifier: "NationalityInputViewCell")
        tableView.register(CurrencyInputViewCell.self, forCellReuseIdentifier: "CurrencyInputViewCell")
        tableView.register(DropDownViewCell.self, forCellReuseIdentifier: "DropDownViewCell")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch items[indexPath.row].type {
        case .nationality:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NationalityInputViewCell", for: indexPath) as? NationalityInputViewCell else {
                fatalError()
            }
            cell.config(with: items[indexPath.row], indexPath: indexPath)
            cell.delegate = self
            return cell
        case .currency:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyInputViewCell", for: indexPath) as? CurrencyInputViewCell else {
                fatalError()
            }
            cell.config(with: items[indexPath.row], indexPath: indexPath)
            cell.delegate = self
            return cell
        case .province, .municipality, .district, .subDistrict:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownViewCell", for: indexPath) as? DropDownViewCell else {
                fatalError()
            }
            cell.config(with: items[indexPath.row], indexPath: indexPath)
            cell.delegate = self
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "InputViewCell", for: indexPath) as? InputViewCell else {
                fatalError()
            }
            cell.config(with: items[indexPath.row], indexPath: indexPath)
            cell.delegate = self
            return cell
        }
    }
    
    func results() -> [InputDataModel] {
        getAllTextFields(fromView: view).forEach { (textField) in
            (textField as? DefaultTextField)?.validate()
        }
        return items
    }
}

extension ViewController: InputViewCellDelegate {
    func editingChanged(_ textField: IDefaultTextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: IDefaultTextField) {
        items[textField.tag].key = textField.text
        items[textField.tag].value = textField.value
    }
    
    func textFieldShouldReturn(_ textField: IDefaultTextField) -> Bool {
        let textFields = getAllTextFields(fromView: view)
        if let nextTextField = textFields.filter({ $0.tag == textField.tag+1 }).first {
            switch items[textField.tag+1].type {
            case .province, .municipality, .district, .subDistrict:
                textField.resignFirstResponder()
            default:
                nextTextField.becomeFirstResponder()
            }
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: IDefaultTextField) -> Bool {
        switch items[textField.tag].type {
        case .province:
            let viewController = GenericTableViewController<String, UITableViewCell>(items: ["1", "2"]) { (cell, item) in
                cell.textLabel?.text = item
            } selectHandler: { [weak self] (item) in
                guard let `self` = self else { return }
                let nextTextField = self.getAllTextFields(fromView: self.view).filter({ $0.tag == textField.tag+1 }).first
                nextTextField?.isEnabled = true
                textField.text = item
                textField.value = item
                self.textFieldDidEndEditing(textField)
            }
            present(UINavigationController(rootViewController: viewController), animated: true, completion: nil)
            return false
        case .municipality:
            let viewController = GenericTableViewController<String, UITableViewCell>(items: ["3", "4"]) { (cell, item) in
                cell.textLabel?.text = item
            } selectHandler: { [weak self] (item) in
                guard let `self` = self else { return }
                let nextTextField = self.getAllTextFields(fromView: self.view).filter({ $0.tag == textField.tag+1 }).first
                nextTextField?.isEnabled = true
                textField.text = item
                textField.value = item
                self.textFieldDidEndEditing(textField)
            }
            present(UINavigationController(rootViewController: viewController), animated: true, completion: nil)
            return false
        case .district:
            let viewController = GenericTableViewController<String, UITableViewCell>(items: ["5", "6"]) { (cell, item) in
                cell.textLabel?.text = item
            } selectHandler: { [weak self] (item) in
                guard let `self` = self else { return }
                let nextTextField = self.getAllTextFields(fromView: self.view).filter({ $0.tag == textField.tag+1 }).first
                nextTextField?.isEnabled = true
                textField.text = item
                textField.value = item
                self.textFieldDidEndEditing(textField)
            }
            present(UINavigationController(rootViewController: viewController), animated: true, completion: nil)
            return false
        case .subDistrict:
            let viewController = GenericTableViewController<String, UITableViewCell>(items: ["7", "8"]) { (cell, item) in
                cell.textLabel?.text = item
            } selectHandler: { [weak self] (item) in
                guard let `self` = self else { return }
                let nextTextField = self.getAllTextFields(fromView: self.view).filter({ $0.tag == textField.tag+1 }).first
                nextTextField?.isEnabled = true
                textField.text = item
                textField.value = item
                self.textFieldDidEndEditing(textField)
            }
            present(UINavigationController(rootViewController: viewController), animated: true, completion: nil)
            return false
        default:
            return true
        }
    }
}
