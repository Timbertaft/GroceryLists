//
//  TypingView.swift
//  GroceryLists
//
//  Created by student on 6/9/16.
//  Copyright © 2016 student. All rights reserved.
//

import Foundation
import UIKit
class TypingView : UIViewController {
    var list = [String]()
    @IBOutlet weak var MoreButton: UIButton!
    
    @IBOutlet weak var GroceryField: UITextField!
    
    @IBOutlet weak var TextUpdate: UITextView!
    
    
    
    @IBOutlet weak var CancelButton: UIBarButtonItem!
    
    
    @IBAction func AddMoreAction(sender: AnyObject) {
        list.append(GroceryField.text!)
        TextUpdate.text = ""
        GroceryField.text = ""
        for item in list {
        TextUpdate.text.appendContentsOf(item + "\r\n")
        
        }
    }
    
    
    
    @IBAction func SaveAction(sender: AnyObject) {
    }
    
    
    
    @IBAction func CancelAction(sender: AnyObject) {
    }
    
    @IBOutlet weak var SaveButton: UIBarButtonItem!
    
    
    
}