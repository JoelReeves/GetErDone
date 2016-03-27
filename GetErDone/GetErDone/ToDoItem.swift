//
//  ToDoItem.swift
//  GetErDone
//
//  Created by Joel Reeves on 3/27/16.
//  Copyright © 2016 Tonic Design. All rights reserved.
//

import UIKit

class ToDoItem {
    
    var allItems = [NSDictionary]()
    var firebaseDictionary = [String: NSDictionary]()
    
    func createItem(name: String, isComplete: Bool) -> [String: NSDictionary] {
        struct Static {
            static var counter = 0
        }
        
        Static.counter += 1
        
        let item = ["name": name, "isComplete": isComplete]
        
        allItems.append(item)
        firebaseDictionary["Item \(Static.counter)"] = item
        
        return firebaseDictionary
    }
}
