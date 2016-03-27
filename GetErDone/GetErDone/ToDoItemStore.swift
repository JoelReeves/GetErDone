//
//  ToDoItemStore.swift
//  GetErDone
//
//  Created by Joel Reeves on 3/27/16.
//  Copyright © 2016 Tonic Design. All rights reserved.
//

import UIKit

class ToDoItemStore {
    
    var allItems = [ToDoItem]()
    
    func createItem(name: String) -> ToDoItem {
        let item = ToDoItem(itemName: name)
        allItems.append(item)
        return item
    }
}
