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
    
    var items = [ToDoItem]()
    let firebase = Firebase(url: "https://geterdone.firebaseio.com/")
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        refreshFirebaseData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // getting a new or recycled cell
        let cell = tableView.dequeueReusableCellWithIdentifier("ToDoItemCell", forIndexPath: indexPath) as! ToDoItemCell
        
        let toDoItem = items[indexPath.row]
        cell.textLabel?.text = toDoItem.name
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let toDoItem = items[indexPath.row]
            
            let hashCode = toDoItem.hashCode
            let itemToDelete = firebase.childByAppendingPath(hashCode)
            
            itemToDelete.removeValue()
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)!
        let toDoItem = items[indexPath.row]
        let toDoItemComplete = !toDoItem.complete
        
        if !toDoItemComplete {
            cell.accessoryType = UITableViewCellAccessoryType.None
            cell.textLabel?.textColor = UIColor.blackColor()
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            cell.textLabel?.textColor = UIColor.grayColor()
        }
        
        let toDoItemPath = firebase.childByAppendingPath(toDoItem.hashCode)
        toDoItemPath.updateChildValues(["complete": toDoItemComplete])
    }
    
    @IBAction func addNewItem(sender: UIBarButtonItem) {
        let ac = UIAlertController(title: "Add ToDoItem?", message: "", preferredStyle: .Alert)
        
        let addAction = UIAlertAction(title: "Add", style: .Default, handler: {
            alert -> Void in
            
            // only adding items if the text isn't empty
            if let newText = ac.textFields![0].text where !newText.isEmpty {
                let toDoItem = ToDoItem(name: newText)
                let toDoItemRef = self.firebase.childByAppendingPath(toDoItem.hashCode)
                toDoItemRef.setValue(toDoItem.dictionary)
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        ac.addTextFieldWithConfigurationHandler { (textField : UITextField!) -> Void in
            textField.placeholder = "Item name"
        }
        
        ac.addAction(addAction)
        ac.addAction(cancelAction)
        
        self.presentViewController(ac, animated: true, completion: nil)
    }
    
    func refreshFirebaseData() {
        firebase.observeEventType(.Value, withBlock: { snapshot in
            
            var snapshotItems = [ToDoItem]()
            
            for items in snapshot.children {
                let item = items as! FDataSnapshot
                
                let hashCode = item.key
                let name = item.value["name"] as! String
                let complete = item.value["complete"] as! Bool
                
                let toDoItem = ToDoItem(name: name, complete: complete, hashCode: hashCode)
                snapshotItems.append(toDoItem)
            }
            
            self.items = snapshotItems
            self.tableView.reloadData()
            
        })
    }
}
