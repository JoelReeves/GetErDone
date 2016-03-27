//
//  ToDoListController.swift
//  GetErDone
//
//  Created by Joel Reeves on 3/25/16.
//  Copyright © 2016 Tonic Design. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    var toDoItemStore: ToDoItemStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var item: ToDoItem
        
        for index in 1...5 {
            item = toDoItemStore.createItem("Item \(index)")
        }
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
}
