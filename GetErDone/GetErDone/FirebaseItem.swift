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
    
    func createItem(name: String, isComplete: Bool) -> [String: NSDictionary] {
        struct Static {
            static var counter = 0
        }
        
        Static.counter += 1
        
        let item = ["name": name, "isComplete": isComplete]
        
        firebaseDictionary["Item \(Static.counter)"] = item
        
        return firebaseDictionary
    }
}
