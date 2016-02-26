//
//  ViewController.swift
//  DbExample
//
//  Created by Christine Franks on 2/25/16.
//  Copyright © 2016 Christine Franks. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var dataModel : DataModel?
    var numberOfEntries : UITextView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialize the data model
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        dataModel = DataModel(persistentStoreCoordinator: appDelegate.persistentStoreCoordinator, managedObjectContext: appDelegate.managedObjectContext)
        
        // create an enter button
        let enterButton = UIButton(type: UIButtonType.System) as UIButton
        enterButton.frame = CGRectMake(self.view.frame.width / 2 - 100, 100, 200, 50)
        enterButton.setTitle("Create A New Employee", forState: UIControlState.Normal)
        enterButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        enterButton.backgroundColor = UIColor.blueColor()
        enterButton.addTarget(self, action: "insertEmployeeIntoDatabase:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(enterButton)
        
        // display number of entities in db
        numberOfEntries = UITextView() as UITextView
        numberOfEntries?.frame = CGRectMake(self.view.frame.width / 2 - 150, 200, 300, 50)
        numberOfEntries?.textAlignment = NSTextAlignment.Center
        numberOfEntries?.textColor = UIColor.blueColor()
        numberOfEntries?.font = UIFont.systemFontOfSize(20)
        self.view.addSubview(numberOfEntries!)
        updateNumberOfEntries()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // add an employee into db
    func insertEmployeeIntoDatabase(sender: UIButton!) {
        dataModel?.insertEmployeeWithFirstName("A", lastName: "B", location: "C");
        updateNumberOfEntries()
    }
    
    // count employees in db and update counter text
    func updateNumberOfEntries() {
        if (numberOfEntries != nil) {
            let num = dataModel?.numberOfEmployeesInDatabase()
            numberOfEntries!.text = "\(num!)"
        }
    }
    
}

