//
//  Kbah.swift
//  GroceryLists
//
//  Created by student on 6/7/16.
//  Copyright © 2016 student. All rights reserved.
//

import Foundation
import Firebase


struct MyItemEntry {
    
    //let key: String!
    let name: String!
    let item: String!
    
    
    init(name: String, item: String, key: String = "") {
        //self.key = key
        self.name = name
        self.item = item
    }
    
    
    init(snapshot: FIRDataSnapshot) {

        
        
        //key = snapshot.key
        name = snapshot.value!["name"] as! String
        item = snapshot.value!["item"] as! String
    }
    
    
    init(snapshot: Dictionary<String,AnyObject>) {
        
        
        //key = snapshot.key
        name = snapshot["name"] as! String
        item = snapshot["item"] as! String
    }
    
    
    func toAnyObject() -> AnyObject {
        return [
            "name": name,
            "item": item,
        ]
    }
    
    
}