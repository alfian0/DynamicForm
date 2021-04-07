//
//  ContainerController.swift
//  DynamicForm
//
//  Created by Macintosh on 06/04/21.
//

import UIKit

class ContainerController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var submitButton: UIButton!
    
    let viewController = ViewController(items: [
        InputDataModel(key: nil, value: nil, enabled: true, type: .nationality, isRequired: true, placeholder: "Nationality"),
        InputDataModel(key: nil, value: nil, enabled: true, type: .number, isRequired: true, placeholder: "Number"),
        InputDataModel(key: nil, value: nil, enabled: true, type: .npwp, isRequired: true, placeholder: "NPWP"),
        InputDataModel(key: nil, value: nil, enabled: true, type: .email, isRequired: true, placeholder: "Email"),
        InputDataModel(key: nil, value: nil, enabled: true, type: .phone, isRequired: true, placeholder: "Phone"),
        InputDataModel(key: nil, value: nil, enabled: true, type: .currency, isRequired: true, placeholder: "Currency"),
        InputDataModel(key: nil, value: nil, enabled: true, type: .province, isRequired: true, placeholder: "Provinsi"),
        InputDataModel(key: nil, value: nil, enabled: false, type: .municipality, isRequired: true, placeholder: "Kabupaten"),
        InputDataModel(key: nil, value: nil, enabled: false, type: .district, isRequired: true, placeholder: "Kecamatan"),
        InputDataModel(key: nil, value: nil, enabled: false, type: .subDistrict, isRequired: true, placeholder: "Kelurahan")
    ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(viewController)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(viewController.view)
        viewController.didMove(toParent: self)
        viewController.view.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        viewController.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        viewController.view.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        viewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        
        submitButton.addTarget(self, action: #selector(onTapSubmitButton(_:)), for: .touchUpInside)
    }
    
    @objc
    private func onTapSubmitButton(_ sender: UIButton) {
        let results = viewController.results().map({ $0.value }).compactMap({ $0 })
        let alert = UIAlertController(title: "Info", message: results.joined(separator: "\n"), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Oke", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
