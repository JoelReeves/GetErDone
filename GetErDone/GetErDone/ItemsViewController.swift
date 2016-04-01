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
    let firebase = Firebase(url: "https://geterdone.firebaseio.com/")
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        loadDataFromFirebase()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItemStore.allItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // getting a new or recycled cell
        let cell = tableView.dequeueReusableCellWithIdentifier("ToDoItemCell", forIndexPath: indexPath) as! ToDoItemCell
        
        let firebaseDictionary = toDoItemStore.allItems[indexPath.row]
        
        // looping through the dictionary's values to find the "name" key
        // setting the text of the cell as that name
        for (_, value) in firebaseDictionary {
            if let name = value["name"] as? String {
                cell.nameLabel.text = name
            }
        }
        
        cell.onButtonClicked = {
            cell.completeButton.selected = !cell.completeButton.selected
            //TODO - also update the item on Firebase
            
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
        }
    }
    
    @IBAction func addNewItem(sender: UIBarButtonItem) {
        let ac = UIAlertController(title: "Add ToDoItem?", message: "", preferredStyle: .Alert)
        
        let addAction = UIAlertAction(title: "Add", style: .Default, handler: {
            alert -> Void in
            
            // only adding items if the text isn't empty
            if let newText = ac.textFields![0].text where !newText.isEmpty {
                // creating a new item and adding it to the store
                let newItem = self.toDoItemStore.createItem(newText)
                
                // adding the data to Firebase
                let child = self.firebase.childByAppendingPath(newItem.hashCode)
                child.setValue(self.toDoItemStore.valuesDictionary)
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
    
    func loadDataFromFirebase() {
        firebase.observeEventType(.Value, withBlock: { snapshot in
            
            var tempItems = [NSDictionary]()
            var tempDictionary = [String: NSDictionary]()
        
            for items in snapshot.children {
                let child = items as! FDataSnapshot
                let key = child.key
                let values = child.value as! NSDictionary
                
                tempDictionary[key] = values
                tempItems.append(tempDictionary)

            }
            
            if !tempItems.isEmpty {
                self.toDoItemStore.allItems = tempItems
                self.tableView.reloadData()
            }
        })
    }
}
