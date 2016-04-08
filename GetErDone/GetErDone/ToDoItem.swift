//
//  ToDoItem.swift
//  GetErDone
//
//  Created by Joel Reeves on 3/28/16.
//  Copyright © 2016 Tonic Design. All rights reserved.
//

import UIKit
import CryptoSwift

struct ToDoItem {
    var hashCode: String
    var name: String
    var complete: Bool
    var dictionary: NSDictionary
    
    init(name: String, complete: Bool, hashCode: String) {
        self.name = name
        self.complete = complete
        self.hashCode = hashCode
        self.dictionary = ["name": name, "complete": complete]
    }
    
    init(name: String) {
        self.name = name
        self.complete = false
        self.hashCode = ("\(NSDate().timeIntervalSince1970)" + self.name + String(self.complete)).md5()
        self.dictionary = ["name": name, "complete": complete]

    }
}
