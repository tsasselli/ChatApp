//
//  MessageController.swift
//  ChatApp
//
//  Created by Travis Sasselli on 8/16/16.
//  Copyright © 2016 TravisSasselli. All rights reserved.
//

import Foundation
import CloudKit

public let MessageControllerDidRefreshNotification = "MessagesControllerDidRefreshNotification"

class MessageController {
    
    private let messageKey = "message"
    
    static let sharedController = MessageController()
    private let cloudKitManager = CloudKitManager()
    
    init() {
        fetchNewRecords()
    }
    
    private(set) var message: [Message] = [] {
        didSet {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let nc = NSNotificationCenter.defaultCenter()
                nc.postNotificationName(MessageControllerDidRefreshNotification, object: self)
            })
        }
    }
    
    func createMessage(message: Message, completion: (NSError?) -> Void) {
        
        let record = message.cloudKitRecord
        
        cloudKitManager.saveRecord(record) { (record, error) in
            
            defer { completion(error) }
            
            if let error = error {
                print("Error saving \(message) to CloudKit \(error.localizedDescription)")
                return
            }
            self.message.insert(message, atIndex: 0)
            print("Entry successfully appended to array0")
        }
    }
    
    func fetchNewRecords(completion: ((NSError?) -> Void)? = nil) {
        
        let predicate = NSPredicate(value: true)
        
        cloudKitManager.fetchRecordsWithType(Message.typeKey, predicate: predicate, recordFetchedBlock: { (_) in
            
            }) { (records, error) in
                if let error = error {
                    print("Error: Unable to fetch error. \(error.localizedDescription)")
                    return
                }
                guard let records = records else { return }
                
                self.message = records.flatMap { Message(record: $0) }
        }
    }
    
}
