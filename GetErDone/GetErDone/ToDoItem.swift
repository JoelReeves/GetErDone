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
    var complete: Bool
    
    init(name: String, complete: Bool) {
        self.name = name
        self.complete = complete
        self.hashCode = ("\(NSDate().timeIntervalSince1970)" + self.name + String(self.complete)).md5()
        
        super.init()
    }
    
    convenience init(itemName: String) {
        self.init(name: itemName, complete: false)
    }
}
