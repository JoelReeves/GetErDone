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
    
        toDoItem.createItem("Take over the world!!", isComplete: false)
        toDoItem.createItem("MVP with Adrienne", isComplete: false)
        
        firebase.setValue(toDoItem.firebaseDictionary)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItem.allItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // getting a new or recycled cell
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
        
        // set the text on the cell
        let item = toDoItem.allItems[indexPath.row]
        
        if let name = item["name"] as? String {
            cell.textLabel?.text = name
        } else {
            cell.textLabel?.text = "unknown"
        }
        
        return cell
    }
}
