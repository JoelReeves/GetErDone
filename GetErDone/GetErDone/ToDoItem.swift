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
    var name: String
    var complete: Bool
    var hashCode: String
    var creationTime: Double
    var dictionary: NSDictionary
    
    init(name: String, complete: Bool, hashCode: String) {
        self.creationTime = NSDate().timeIntervalSince1970
        self.name = name
        self.complete = complete
        self.hashCode = hashCode
        self.dictionary = ["name": name, "complete": complete, "creationTime": creationTime]
    }
    
    init(name: String) {
        self.creationTime = NSDate().timeIntervalSince1970
        self.name = name
        self.complete = false
        self.hashCode = (String(self.creationTime) + self.name + String(self.complete)).md5()
        self.dictionary = ["name": name, "complete": complete, "creationTime": creationTime]
    }
}
