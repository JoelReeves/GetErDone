//
//  ToDoItem.swift
//  GetErDone
//
//  Created by Joel Reeves on 3/27/16.
//  Copyright © 2016 Tonic Design. All rights reserved.
//

import UIKit

class ToDoItem: NSObject {
    var name: String
    var isComplete: Bool
    
    init(name: String, isComplete: Bool) {
        self.name = name
        self.isComplete = isComplete
        
        super.init()
    }
    
    convenience init(itemName: String) {
        self.init(name: itemName, isComplete: false)
    }
}
