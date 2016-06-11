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
        // If(GroceryField.text?.isEmpty || GroceryField.text = " ")
        let whitespaceSet = NSCharacterSet.whitespaceCharacterSet()
        if GroceryField.text!.stringByTrimmingCharactersInSet(whitespaceSet) != "" {
            // string contains non-whitespace characters
            list.append(GroceryField.text!)
            TextUpdate.text = ""
            GroceryField.text = ""
            for item in list {
                TextUpdate.text.appendContentsOf(item + "\r\n")
                
            }
            
        }
        else {
            GroceryField.placeholder = "Not valid.  Please enter a new value"
            GroceryField.text = ""
        }
    }
    
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Save" {
                let controller = segue.destinationViewController as! ViewController
                controller.list = self.list
            viewDidLoad()
                /*let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                 controller.detailItem = object
                 controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                 controller.navigationItem.leftItemsSupplementBackButton = true */
            }
        
    }
    
    
    @IBAction func SaveAction(sender: AnyObject) {
        
    }
    
    
    
    @IBAction func CancelAction(sender: AnyObject) {
    }
    
    @IBOutlet weak var SaveButton: UIBarButtonItem!
    
    
    
}