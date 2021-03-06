//
//  ToDoItemCell.swift
//  GetErDone
//
//  Created by Joel Reeves on 3/29/16.
//  Copyright © 2016 Tonic Design. All rights reserved.
//

import UIKit

class ToDoItemCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var editButton: UIButton!
    
    var onButtonClicked : (() -> Void)? = nil
    
    @IBAction func editButtonPressed(sender: UIButton) {
        if let onButtonClicked = self.onButtonClicked {
            onButtonClicked()
        }
    }
}
