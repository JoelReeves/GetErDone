//
//  ToDoItem.swift
//  GetErDone
//
//  Created by Joel Reeves on 3/27/16.
//  Copyright © 2016 Tonic Design. All rights reserved.
//

import UIKit

class ToDoItem {
    
    var allItemsArray = [NSDictionary]()
    var allItemsDictionary = [String: NSDictionary]()
    
    func createItem(name: String) -> [String: NSDictionary] {
        struct Static {
            static var counter = 0
        }
        
        Static.counter += 1
        
        let item = ["name": name, "isComplete": false]
        
        allItemsArray.append(item)
        allItemsDictionary["Item \(Static.counter)"] = item
        
        return allItemsDictionary
    }
}
