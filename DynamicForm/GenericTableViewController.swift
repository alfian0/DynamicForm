//
//  GenericTableViewController.swift
//  DynamicForm
//
//  Created by Macintosh on 06/04/21.
//

import UIKit

class GenericTableViewController<T, Cell: UITableViewCell>: UITableViewController {
    private var items: [T]
    private var configure: (Cell, T) -> Void
    private var selectHandler: (T) -> Void
    
    init(items: [T], configure: @escaping (Cell, T) -> Void, selectHandler: @escaping (T) -> Void) {
        self.items = items
        self.configure = configure
        self.selectHandler = selectHandler
        super.init(style: .plain)
        self.tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Silahkan Pilih"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didSlectCancel(_:)))
    }
    
    @objc
    private func didSlectCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        let item = items[indexPath.row]
        configure(cell, item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        dismiss(animated: true) { [weak self] in
            self?.selectHandler(item)
        }
    }
}
