//
//  ViewController.swift
//  ToDoList
//
//  Created by ahmed.essam on 10/28/18.
//  Copyright © 2018 ahmed.essam. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = ["find my girl","marry here","go to alex"]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeItemArray()
    }

    func initializeItemArray(){
        if let items = defaults.array(forKey: "itemsArray") as? [String]{
            itemArray = items
        }
    }
    //MARK: create table view Datasource methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell",for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        if(tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark){
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

    //MARK: Add items
    
    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add ToDo", message: "add your new ToDo", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default, handler: { (action) in
            self.itemArray.append(textField.text!)
            self.defaults.set(self.itemArray,forKey: "itemsArray")
            self.updateTableViewItems()
        })
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new item"
            textField = alertTextField
        }
    
        present(alert,animated: true,completion: nil)
    }
    
    
    func updateTableViewItems(){
        tableView.reloadData()
    }
}

