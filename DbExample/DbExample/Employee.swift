//
//  Employee.swift
//  DbExample
//
//  Created by Christine Franks on 2/25/16.
//  Copyright © 2016 Christine Franks. All rights reserved.
//

import CoreData

class Employee : NSManagedObject {
    @NSManaged var firstName: String?
    @NSManaged var lastName: String?
    @NSManaged var location: String?
}
