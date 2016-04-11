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
    var creationDate: Double
    
    init(name: String, complete: Bool, hashCode: String) {
        self.creationDate = NSDate().timeIntervalSince1970
        self.name = name
        self.complete = complete
        self.hashCode = hashCode
    }
    
    init(name: String) {
        self.creationDate = NSDate().timeIntervalSince1970
        self.name = name
        self.complete = false
        self.hashCode = (String(self.creationDate) + self.name + String(self.complete)).md5()
    }
    
    func dateToString() -> String {
        let date = NSDate(timeIntervalSince1970: creationDate)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy h:mm:ss a"
        
        return dateFormatter.stringFromDate(date)
    }
}
