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
    
    var toDoItemStore: ToDoItemStore!
    var firebaseItem: FirebaseItem!
    let firebase = Firebase(url: "https://geterdone.firebaseio.com/")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItemStore.allItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // getting a new or recycled cell
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
        
        // set the text on the cell
        let item = toDoItemStore.allItems[indexPath.row]
        cell.textLabel?.text = item.name
        
        return cell
    }
    
    @IBAction func addNewItem(sender: UIBarButtonItem) {
        // creating a new item and adding it to the store
        let newItem = toDoItemStore.createItem("Batman v Superman")
        
        addItemToFirebase(newItem)
        
        // figure out where that item is in the array
        if let index = toDoItemStore.allItems.indexOf(newItem) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            
            // insert this row into the table
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    func addItemToFirebase(item: ToDoItem) {
        firebaseItem.createItem(item.name, isComplete: item.isComplete)
        firebase.setValue(firebaseItem.firebaseDictionary)
    }
}
