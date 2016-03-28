//
//  ToDoItem.swift
//  GetErDone
//
//  Created by Joel Reeves on 3/27/16.
//  Copyright © 2016 Tonic Design. All rights reserved.
//

import UIKit

class FirebaseItem {

    var firebaseDictionary = [String: NSDictionary]()
       
    func createItem(hashCode: String, name: String, isComplete: Bool) -> [String: NSDictionary] {
        
        let item = ["name": name, "isComplete": isComplete]
        
        firebaseDictionary[hashCode] = item

        return firebaseDictionary
    }
    
    func removeItem(key: String) {
        firebaseDictionary[key] = nil
    }
}
