//
//  ToDoTableViewController.swift
//  Ginger
//
//  Created by Sabrina Ren on 2018-08-27.
//  Copyright © 2018 Sabrina Ren. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    
    var todoItems:[ToDoItem]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) // transparent nav bar
        
        self.view.backgroundColor = Colours.Grey
    }
    
    func loadData() {
        todoItems = [ToDoItem]() // initialize array
        todoItems = DataManager.loadAll(ToDoItem.self).sorted(by: { // sort elements returned by DataManager by date
            $0.createdAt < $1.createdAt // compare first element to second element
        })
        tableView.reloadData()
    }
    
    func addTodoItem(_ newTodoItem: ToDoItem) {
        newTodoItem.saveItem()
        self.todoItems.append(newTodoItem)
        let indexPath = IndexPath(row: self.tableView.numberOfRows(inSection: 0), section: 0)
        self.tableView.insertRows(at: [indexPath], with: .fade)
    }

    func completeTodoItem(_ indexPath: IndexPath) {
        var todoItem = todoItems[indexPath.row]
        todoItem.markAsCompleted()
        todoItems[indexPath.row] = todoItem
        if let cell = tableView.cellForRow(at: indexPath) as? ToDoTableViewCell {
            cell.todoLabel.attributedText = strikeThroughText(todoItem.title)
        }
    }
    
    func strikeThroughText (_ text:String) -> NSAttributedString {
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: text)
        attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))

        return attributeString
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ToDoTableViewCell
        
        let todoItem = todoItems[indexPath.row]
        
        cell.todoLabel.text = todoItem.title
        
        if todoItem.completed {
            cell.todoLabel.attributedText = strikeThroughText(todoItem.title)
        }
        
        // disable table cell highlight
        let backgroundView = UIView()
        backgroundView.backgroundColor = Colours.Grey
        cell.selectedBackgroundView = backgroundView 

        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete") { (action:UITableViewRowAction, indexPath:IndexPath) in
            self.todoItems[indexPath.row].deleteItem() // delete item
            self.todoItems.remove(at: indexPath.row) // remove item from tableview
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = Colours.darkGrey
        
        return [deleteAction]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        completeTodoItem(indexPath)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

/*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destIndexPath: IndexPath) {
        
        let todo = todoItems[sourceIndexPath.row]
        todoItems.remove(at: sourceIndexPath.row)
        todoItems.insert(todo, at: destIndexPath.row)

    }
 
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    */
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
