//
//  ToDoListController.swift
//  GetErDone
//
//  Created by Joel Reeves on 3/25/16.
//  Copyright © 2016 Tonic Design. All rights reserved.
//

import UIKit
import Firebase

class ItemsViewController: UITableViewController {
    
    var toDoItem: ToDoItem!
    let firebase = Firebase(url: "https://geterdone.firebaseio.com/")
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItem.allItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // getting a new or recycled cell
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
        
        // set the text on the cell
        cell.textLabel?.text = toDoItem.getItemNameText(indexPath.row)
        
        return cell
    }
    
    @IBAction func addNewItem(sender: AnyObject) {
        toDoItem.createItem("Testing", isComplete: false)
        let itemText = toDoItem.getItemNameText(toDoItem.allItems.count - 1)
        
        if let index = toDoItem.allItems.indexOf(itemText) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            
            firebase.setValue(toDoItem.firebaseDictionary)
        }
    }
}
