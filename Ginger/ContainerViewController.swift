//
//  ContainerViewController.swift
//  Ginger
//
//  Created by Sabrina Ren on 2018-08-29.
//  Copyright © 2018 Sabrina Ren. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController, UITextViewDelegate{
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet var addItemView: UIView!
    @IBOutlet weak var userInput: UITextField!
    
    var todoTableViewController:ToDoTableViewController! // reference to TableViewController
    
    var effect:UIVisualEffect!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        addButton.layer.cornerRadius = addButton.frame.size.width / 2
        addButton.layer.shadowOpacity = 0.1
        addButton.layer.shadowRadius = 8
        addButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        self.view.backgroundColor = Colours.Grey
        
        addItemView.layer.shadowColor = Colours.darkGrey.cgColor
        addItemView.layer.shadowOpacity = 0.3
        addItemView.layer.shadowRadius = 15
        addItemView.layer.shadowOffset = CGSize(width: 5, height: 5)
        
    }
    
    // initialize todoTableViewController; embed segue -> navigation controller -> table view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GingerVC" {
            todoTableViewController = (segue.destination as! UINavigationController).childViewControllers.first as! ToDoTableViewController
        }
    }
    
    func animateIn() {
        self.view.addSubview(addItemView)
        addItemView.center = self.view.center
        
        addItemView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        addItemView.alpha = 0
        
        UIView.animate(withDuration: 0.2) {
            self.addItemView.alpha = 1
            self.addItemView.transform = CGAffineTransform.identity
        }
    }
    
    func animateOut() {
        UIView.animate(withDuration: 0.2, animations: {
            self.addItemView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.addItemView.alpha = 0
            
        }) { (success:Bool) in
            self.addItemView.removeFromSuperview()
        }
    }
    
    @IBAction func addNewTodoItem(_ sender: Any) {
        userInput.becomeFirstResponder() // activates text field
        animateIn()
    }
    
    @IBAction func addAndDismissPopup(_ sender: Any) {
        
        guard let title = String?(userInput.text!)
            else { return }
        let newTodo = ToDoItem(title: title, completed: false, createdAt: Date(), itemIdentifier: UUID())
        todoTableViewController.addTodoItem(newTodo)
        
        animateOut()
        userInput.resignFirstResponder() // resets text field
    }
    
    // return key on user keypad triggers add button in popup
    @IBAction func textFieldPrimaryActionTriggered(_ sender: Any) {
        addAndDismissPopup(sender)
    }
    
    @IBAction func closePopup(_ sender: Any) {
        animateOut()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
