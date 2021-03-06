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
    
    var items: [ToDoItem]!
    let firebase = Firebase(url: "https://geterdone.firebaseio.com/")
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        syncFirebaseData()
    }
    
    // MARK: UITableView delegate methods
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // getting a new or recycled cell
        let cell = tableView.dequeueReusableCellWithIdentifier("ToDoItemCell", forIndexPath: indexPath) as! ToDoItemCell
        
        let toDoItem = items[indexPath.row]
        cell.nameLabel?.text = toDoItem.name
        
        toggleCompleteState(cell, complete: toDoItem.complete)
        
        cell.onButtonClicked = {
            let ac = UIAlertController(title: "Edit name?", message: "", preferredStyle: .Alert)
            
            let doneAction = UIAlertAction(title: "Done", style: .Default, handler: {
                alert -> Void in
                
                // only saving text if the textfield isn't empty
                if let newText = ac.textFields![0].text where !newText.isEmpty {
                    cell.nameLabel.text = newText
                    
                    let toDoItemPath = self.firebase.childByAppendingPath(toDoItem.hashCode)
                    toDoItemPath.updateChildValues(["name": newText])
                }
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            
            ac.addTextFieldWithConfigurationHandler { (textField : UITextField!) -> Void in
                textField.placeholder = "New ToDoItem name"
            }
            
            ac.addAction(doneAction)
            ac.addAction(cancelAction)
            
            self.presentViewController(ac, animated: true, completion: nil)
        }
        
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
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)! as! ToDoItemCell
        let toDoItem = items[indexPath.row]
        let toDoItemComplete = !toDoItem.complete
        
        toggleCompleteState(cell, complete: toDoItemComplete)
        
        let toDoItemPath = firebase.childByAppendingPath(toDoItem.hashCode)
        toDoItemPath.updateChildValues(["complete": toDoItemComplete])
    }
    
    func toggleCompleteState(cell: ToDoItemCell, complete: Bool) {
        if let text = cell.nameLabel.text {
            if !complete {
                
                let attributes = [
                    NSForegroundColorAttributeName: UIColor.blackColor(),
                    NSStrikethroughStyleAttributeName: NSNumber(integer: NSUnderlineStyle.StyleNone.rawValue)
                ]
                
                cell.nameLabel?.attributedText = NSAttributedString(string: text, attributes: attributes)
            } else {
                
                let attributes = [
                    NSForegroundColorAttributeName: UIColor.redColor(),
                    NSStrikethroughStyleAttributeName: NSNumber(integer: NSUnderlineStyle.StyleThick.rawValue)
                ]
                
                cell.nameLabel?.attributedText = NSAttributedString(string: text, attributes: attributes)
            }
        }
    }
    
    // MARK: Add new ToDoItem
    
    @IBAction func addNewItem(sender: UIBarButtonItem) {
        let ac = UIAlertController(title: "Add ToDoItem?", message: "", preferredStyle: .Alert)
        
        let addAction = UIAlertAction(title: "Add", style: .Default, handler: {
            alert -> Void in
            
            // only adding items if the text isn't empty
            if let newText = ac.textFields![0].text where !newText.isEmpty {
                let toDoItem = ToDoItem(name: newText)
                
                let toDoItemPath = self.firebase.childByAppendingPath(toDoItem.hashCode)
                let toDoItemDictionary = ["name": toDoItem.name, "complete": toDoItem.complete, "creationDate": toDoItem.creationDateString]
                toDoItemPath.setValue(toDoItemDictionary)
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
    
    // MARK: Update Firebase data
    
    func syncFirebaseData() {
        
        // sorts the data in the table by the creation date
        firebase.queryOrderedByChild("creationDate").observeEventType(.Value, withBlock: { snapshot in
            
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
