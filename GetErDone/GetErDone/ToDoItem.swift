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
    
    init(name: String, isComplete: Bool) {
        self.name = name
        self.isComplete = isComplete
        self.hashCode = ("\(NSDate().timeIntervalSince1970)" + name + String(isComplete)).md5()
        
        super.init()
    }
    
    convenience init(itemName: String) {
        self.init(name: itemName, isComplete: false)
    }
}
