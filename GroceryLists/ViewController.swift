//
//  ViewController.swift
//  GroceryLists
//
//  Created by student on 6/7/16.
//  Copyright © 2016 student. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UITableViewController {
    
    var list = [String]()
    var objects = [String]()
    
    var ref : FIRDatabaseReference?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.navigationItem.rightBarButtonItem =
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        insertNewObject(_:self)
        /*let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(insertNewObject(_:)))
         
        self.navigationItem.rightBarButtonItem = addButton
        /*if let split = self.splitViewController {
            let controllers = split.viewControllersS
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        self.ref = FIRDatabase.database().reference()*/*/
        self.ref = FIRDatabase.database().reference()
    }
    
    //    override func viewWillAppear(animated: Bool) {
    //        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
    //        super.viewWillAppear(animated)
    //    }
    
    override func viewWillAppear(animated: Bool) {
        //self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
        
        objects.appendContentsOf(list)
           self.ref!.child("my-entries").observeEventType(.Value, withBlock: { snapshot in
            var newEntries = [String]()
            
            if let postDict = snapshot.value as? [String : AnyObject] {
                for (key,val) in postDict.enumerate() {
                    print("key = \(key) and val = \(val.1)")
                    let str = val.1
                    newEntries.append(str as! String)
                }
                self.objects = newEntries
                self.objects.sortInPlace({ $0.compare($1) == NSComparisonResult.OrderedDescending })
                self.tableView.reloadData()
            }
        })
    }
    




    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    func insertNewObject(sender: AnyObject) {
    //        objects.insert(NSDate(), atIndex: 0)
    //        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
    //        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    //    }
    
    func insertNewObject(sender: AnyObject) {
        //let entry = MyItemEntry(name: "iPhone", item: String)
        self.ref = FIRDatabase.database().reference()
        for entry in list {
            objects.insert(entry, atIndex: 0)
            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
            self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            self.ref?.child("my-entries").child(entry).setValue(entry)
            /*let childRef = self.ref?.child("my-entries")
            let idontknow = childRef!.child(entry)
            idontknow.setValue(entry)*/
        }
        

    }
    
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PlusButtonSegue" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row]
                /*let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true */
            }
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        
        let object = objects[indexPath.row]
        cell.textLabel!.text = object
      //  cell.detailTextLabel!.text = object.name
        return cell
        
        
    }
    
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        self.ref = FIRDatabase.database().reference()
        if editingStyle == .Delete {
            let entry = self.objects[indexPath.row]
            self.ref?.child("my-entries").child(entry).removeValue()
        }
}
}