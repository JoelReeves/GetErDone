//
//  ToDoItemStore.swift
//  GetErDone
//
//  Created by Joel Reeves on 3/28/16.
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
    
    func removeItem(item: ToDoItem) {
        if let index = allItems.indexOf(item) {
            allItems.removeAtIndex(index)
        }
    }
    
    func moveItemAtIndex(fromIndex: Int, toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        // get reference to object being moved
        let movedItem = allItems[fromIndex]
        
        // remove item from array
        allItems.removeAtIndex(fromIndex)
        
        // insert item in array at new location
        allItems.insert(movedItem, atIndex: toIndex)
    }
}
