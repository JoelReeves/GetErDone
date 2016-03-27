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
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItemStore.allItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // creating instance of UITableView cell with a default appearance
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "UITableViewCell")
        
        // set the text on the cell
        let item = toDoItemStore.allItems[indexPath.row]
        cell.textLabel?.text = item.name
        
        return cell
    }
}
