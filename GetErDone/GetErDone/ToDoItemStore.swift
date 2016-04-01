//
//  ToDoItemStore.swift
//  GetErDone
//
//  Created by Joel Reeves on 3/28/16.
//  Copyright © 2016 Tonic Design. All rights reserved.
//

import UIKit

class ToDoItemStore {
    
    var allItems = [NSDictionary]()
    var valuesDictionary = [:]
    
    func createItem(name: String) -> ToDoItem {
        let item = ToDoItem(itemName: name)
        
        valuesDictionary = ["name": item.name, "complete": item.complete]       
        allItems.append(valuesDictionary)

        return item
    }
}
