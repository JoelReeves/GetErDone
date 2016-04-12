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
    let hashCode: String
    let creationDate = NSDate().timeIntervalSince1970
    
    var creationDateString: String {
        let date = NSDate(timeIntervalSince1970: creationDate)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "M/dd/yyyy h:mm:ss a"
        
        return dateFormatter.stringFromDate(date)
    }
    
    init(name: String, complete: Bool, hashCode: String) {
        self.name = name
        self.complete = complete
        self.hashCode = hashCode
    }
    
    init(name: String) {
        self.name = name
        self.complete = false
        self.hashCode = (String(self.creationDate) + self.name + String(self.complete)).md5()
    }
}