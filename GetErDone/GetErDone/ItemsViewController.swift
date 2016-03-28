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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem()
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
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // removing item from the item store and firebase
            let item = toDoItemStore.allItems[indexPath.row]
            
            toDoItemStore.removeItem(item)
            
            deleteItemFromFirebase("Item \(indexPath.row + 1)")
            
            // deleting that row from the table
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    @IBAction func addNewItem(sender: UIBarButtonItem) {
        let ac = UIAlertController(title: "Add ToDoItem?", message: "", preferredStyle: .Alert)
        
        let addAction = UIAlertAction(title: "Add", style: UIAlertActionStyle.Default, handler: {
            alert -> Void in
            
            // only adding items if the text isn't empty
            if let newText = ac.textFields![0].text where !newText.isEmpty {
                // creating a new item and adding it to the store
                let newItem = self.toDoItemStore.createItem(newText)
                
                self.addItemToFirebase(newItem)
                
                // figure out where that item is in the array
                if let index = self.toDoItemStore.allItems.indexOf(newItem) {
                    let indexPath = NSIndexPath(forRow: index, inSection: 0)
                
                    // insert this row into the table
                    self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                }
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
        
        ac.addTextFieldWithConfigurationHandler { (textField : UITextField!) -> Void in
            textField.placeholder = "Item name"
        }
        
        ac.addAction(addAction)
        ac.addAction(cancelAction)
        
        self.presentViewController(ac, animated: true, completion: nil)
    }
    
    func addItemToFirebase(item: ToDoItem) {
        firebaseItem.createItem(item.name, isComplete: item.isComplete)
        updateFirebase()
    }
    
    func deleteItemFromFirebase(key: String) {
        firebaseItem.removeItem(key)
        updateFirebase()
    }
    
    func updateFirebase() {
        firebase.setValue(firebaseItem.firebaseDictionary)
    }
}
