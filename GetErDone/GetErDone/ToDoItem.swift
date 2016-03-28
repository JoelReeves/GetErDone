//
//  ToDoItem.swift
//  GetErDone
//
//  Created by Joel Reeves on 3/28/16.
//  Copyright © 2016 Tonic Design. All rights reserved.
//

import UIKit
import CryptoSwift

class ToDoItem: NSObject {
    var hashCode: String
    var name: String
    var isComplete: Bool
    
    struct Static {
        static var counter = 0
    }
    
    init(name: String, isComplete: Bool) {
        self.hashCode = "AndroidItem\(Static.counter)".md5()
        self.name = name
        self.isComplete = isComplete
        
        Static.counter += 1
        
        super.init()
    }
    
    convenience init(itemName: String) {
        self.init(name: itemName, isComplete: false)
    }
}
