//
//  DataModel.swift
//  DbExample
//
//  Created by Christine Franks on 2/25/16.
//  Copyright © 2016 Christine Franks. All rights reserved.
//

import CoreData

class DataModel : NSObject {
    var managedObjectContext : NSManagedObjectContext
    var persistentStoreCoordinator : NSPersistentStoreCoordinator
    
    // initialize the database
    init (persistentStoreCoordinator : NSPersistentStoreCoordinator, managedObjectContext : NSManagedObjectContext) {
        self.persistentStoreCoordinator = persistentStoreCoordinator
        self.managedObjectContext = managedObjectContext
    }
    
    // create an employee and save it
    func insertEmployeeWithFirstName(firstName: String, lastName: String, location: String) {
        let employee =
            NSEntityDescription.insertNewObjectForEntityForName("Employee", inManagedObjectContext: managedObjectContext) as! Employee
        employee.firstName = firstName
        employee.lastName = lastName
        employee.location = location
        do {
            try self.managedObjectContext.save()
        } catch {
            // error handling
        }
    }
    
    // Get the employee(s) with a specific name
    func employeeWithName(name: String) -> [Employee] {
        let fetchRequest = NSFetchRequest(entityName: "Employee");
        fetchRequest.predicate = NSPredicate(format: "firstName == %@", name);
        
        do {
            let fetchedEmployees = try self.managedObjectContext.executeFetchRequest(fetchRequest) as! [Employee]
            for e in fetchedEmployees {
                NSLog(e.firstName! + " " + e.lastName! + " at " + e.location!)
            }
            return fetchedEmployees
        } catch {
            fatalError("Failed to fetch employees")
        }
        
        return []
    }
    
    // Get the number of employees
    func numberOfEmployeesInDatabase() -> Int {
        let fetchRequest = NSFetchRequest(entityName: "Employee");
        do {
            let fetchedEmployees = try self.managedObjectContext.executeFetchRequest(fetchRequest) as! [Employee]
            return fetchedEmployees.count
        } catch {
            fatalError("Failed to fetch employees")
        }
        return 0;
    }
}
