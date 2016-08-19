//
//  UserController.swift
//  ChatApp
//
//  Created by Travis Sasselli on 8/16/16.
//  Copyright © 2016 TravisSasselli. All rights reserved.
//

import Foundation
import CloudKit

public let UserControllerDidRefreshNotification = "UserControllerDidRefreshNotification"

class UserController {
    
    var currentUserReference: CKReference?
    static let sharedController = UserController()
    private let cloudKitManager = CloudKitManager()
    
    private(set) var loggedInUser: User? {
        didSet {
            print(loggedInUser?.firstName)
        }
    }
    
    private(set) var user: [User] = [] {
        didSet {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let nc = NSNotificationCenter.defaultCenter()
                nc.postNotificationName(UserControllerDidRefreshNotification, object: self)
            })
        }
    }
    
    func lookForCurrentUser() {
        cloudKitManager.fetchLoggedInUserRecord { (record, error) in
            if let error = error {
                NSLog("Error finding logged in user: \(error)")
                return
            }
            guard let record = record else { return }
           let userRecordID = record.recordID
            self.currentUserReference = CKReference(recordID: userRecordID, action: .None)
            
            self.cloudKitManager.fetchUsernameFromRecordID(record.recordID) { (givenName, familyName) in
                
                guard let firstName = givenName,
                    let lastName = familyName,
                    reference = self.currentUserReference else {
                        return
                }
                
                let userRecord = CKRecord(recordType:  User.typeKey)
                userRecord.setValue(firstName, forKey: User.firstNameKey)
                userRecord.setValue(lastName, forKey: User.lastNameKey)
                userRecord.setValue(reference, forKey: User.referenceKey)
                
                self.cloudKitManager.saveRecord(userRecord, completion: { (_, error) in
                    if let error = error {
                        print("Error finding user's name: \(error)")
                        return
                        
                    }
                    
                })
                
                if let error = error {
                    NSLog("Error finding logged in user's name: \(error)")
                    return
                }
                let user = User(firstName: givenName, lastName: familyName, record: record)
                self.loggedInUser = user
            }
            
        }
    }
    
    
        func fetchCurrentLoggedInUsers () {
    
            let predicate = NSPredicate(value: true)
    
            cloudKitManager.fetchRecordsWithType(<#T##type: String##String#>, predicate: predicate, recordFetchedBlock: <#T##((record: CKRecord) -> Void)?##((record: CKRecord) -> Void)?##(record: CKRecord) -> Void#>, completion: <#T##((records: [CKRecord]?, error: NSError?) -> Void)?##((records: [CKRecord]?, error: NSError?) -> Void)?##(records: [CKRecord]?, error: NSError?) -> Void#>)
                
                
    
            }
    
        }
        
    
    
    
}