//
//  SmarteModel.swift
//  Smarte
//
//  Created by Rakesh on 19/10/15.
//  Copyright (c) 2015 sinergia. All rights reserved.
//

import Foundation

import CoreData

@objc(SmarteModel)

class SmarteModel: NSManagedObject {
    
    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var emailId: String
    @NSManaged var password: String
    @NSManaged var phoneNo: String
    
    
}
