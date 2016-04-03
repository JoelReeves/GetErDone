//
//  ToDoItemStore.swift
//  GetErDone
//
//  Created by Joel Reeves on 3/28/16.
//  Copyright © 2016 Tonic Design. All rights reserved.
//

import UIKit

class ToDoItemStore {
    
    var allItems = [[String: NSDictionary]]()
    var newItem = [String: NSDictionary]()
    
    func createItem(name: String) {
        let toDoItem = ToDoItem(itemName: name)
        
        let stringKey = toDoItem.hashCode
        let dictionary = toDoItem.dictionary
        
        newItem[stringKey] = dictionary
        allItems.append(newItem)
    }
    
    func deleteItem(index: Int, key: String) {
        
    }
}
