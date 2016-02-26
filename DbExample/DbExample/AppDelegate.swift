//
//  AppDelegate.swift
//  DbExample
//
//  Created by Christine Franks on 2/25/16.
//  Copyright © 2016 Christine Franks. All rights reserved.
//

import UIKit
import CoreData

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // This creates a non-storyboard base view
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        if let window = window {
            window.backgroundColor = UIColor.whiteColor()
            window.rootViewController = ViewController()
            window.makeKeyAndVisible()
        }
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // CoreData

    lazy var managedObjectModel: NSManagedObjectModel = {
        // Create an entity description for Employee, based on the class <ProjectName>.<ClassName>
        let description = NSEntityDescription()
        description.name = "Employee"
        description.managedObjectClassName = "DbExample.Employee"
        
        // Create the three attributes defined by Employee: firstName, lastName, and location
        let attrLocation = NSAttributeDescription()
        attrLocation.name = "location"
        attrLocation.attributeType = NSAttributeType.StringAttributeType;
        
        let attrFirstName = NSAttributeDescription()
        attrFirstName.name = "firstName"
        attrFirstName.attributeType = NSAttributeType.StringAttributeType;
        
        let attrLastName = NSAttributeDescription()
        attrLastName.name = "lastName"
        attrLastName.attributeType = NSAttributeType.StringAttributeType;
        
        // This works because NSAttributeDescription is a subclass of NSPropertyDescription
        description.properties = [attrFirstName, attrLastName, attrLocation]
        
        // Create the model and set the entity description(s)
        var model = NSManagedObjectModel()
        model.entities = [description]
        
        return model
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // Create the coordinator
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel:self.managedObjectModel)
        
        // Create a local persistent store
        let urlList = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask);
        let url = urlList[urlList.count-1].URLByAppendingPathComponent("SingleViewCoreData.db")
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            NSLog("Unresolved error initalizing ")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // create the managed object context
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

}

