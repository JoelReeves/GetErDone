//
//  ToDoItem.swift
//  GetErDone
//
//  Created by Joel Reeves on 3/27/16.
//  Copyright © 2016 Tonic Design. All rights reserved.
//

import UIKit

class FirebaseItem {
    
    var allItems = [String]()
    var itemsDictionary = [NSDictionary]()
    var firebaseDictionary = [String: NSDictionary]()
    
    func createItems() {
        createItem("Take over the world!!!", isComplete: false)
        createItem("MVP with Adrienne", isComplete: false)
        createItem("Kill myself b/c of the HATE", isComplete: false)
    }
    
    func createItem(name: String, isComplete: Bool) -> [String: NSDictionary] {
        struct Static {
            static var counter = 0
        }
        
        Static.counter += 1
        
        let item = ["name": name, "isComplete": isComplete]
        
        itemsDictionary.append(item)
        
        let nameString = getItemNameText(itemsDictionary.count - 1)
        allItems.append(nameString)
        
        firebaseDictionary["Item \(Static.counter)"] = item
        
        return firebaseDictionary
    }
    
    func getItemNameText(index: Int) -> String {
        let item = itemsDictionary[index]
        
        if let name = item["name"] as? String {
            return name
        } else {
            return "unknown"
        }
    }
}
