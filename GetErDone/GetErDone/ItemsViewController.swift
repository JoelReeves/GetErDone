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
    
    var firebaseItem: FirebaseItem!
    let firebase = Firebase(url: "https://geterdone.firebaseio.com/")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firebaseItem.createItems()
        firebase.setValue(firebaseItem.firebaseDictionary)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return firebaseItem.allItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // getting a new or recycled cell
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
        
        // set the text on the cell
        cell.textLabel?.text = firebaseItem.getItemNameText(indexPath.row)
        
        return cell
    }
    
    @IBAction func addNewItem(sender: AnyObject) {
        //firebaseItem.createItem("Testing", isComplete: false)
        
        let itemText = firebaseItem.getItemNameText(firebaseItem.allItems.count - 1)
        
        if let index = firebaseItem.allItems.indexOf(itemText) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            
            firebase.setValue(firebaseItem.firebaseDictionary)
        }
    }
}
