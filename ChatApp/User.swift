//
//  User.swift
//  ChatApp
//
//  Created by Travis Sasselli on 8/16/16.
//  Copyright © 2016 TravisSasselli. All rights reserved.
//

import Foundation
import CloudKit

class User {
    
    static let typeKey = "User"
    static let firstNameKey = "firstName"
    static let lastNameKey = "lastName"
    static let referenceKey = "reference"
    
    var firstName: String?
    var lastName: String?
    
    init?(firstName: String?, lastName: String?, record: CKRecord){
        self.firstName = firstName
        self.lastName = lastName
        self.cloudKitRecordID = record.recordID
    }
    
    var cloudKitRecordID: CKRecordID?
    var recordType: String { return Message.typeKey }
    
    var cloudKitRecord: CKRecord {
        let record = CKRecord(recordType: User.typeKey)
        if let firstName = firstName { record[User.firstNameKey] = firstName }
        if let lastName = lastName { record[User.lastNameKey] = lastName }
        return record
    }

}
