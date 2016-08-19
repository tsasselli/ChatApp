//
//  Message.swift
//  ChatApp
//
//  Created by Travis Sasselli on 8/16/16.
//  Copyright © 2016 TravisSasselli. All rights reserved.
//

import Foundation
import CloudKit

class Message {
    
    static let typeKey = "Message"
    static let textKey = "text"
    static let senderKey = "sender"
    static let timestampKey = "timestamp"
    static let threadKey = "thread"
    static let userKey = "User"
    
    var text: String
    var timeStamp: NSDate
//    var sender: CKReference
//    var thread: CKReference
//    var user: [User]
    
    init(text: String /*sender: CKReference, thread: CKReference*/, timeStamp: NSDate = NSDate()) {
        self.text = text
        self.timeStamp = timeStamp
//        self.sender = sender
//        self.thread = thread
//        self.user = user
    }

    var cloudKitRecordID: CKRecordID?
    var recordType: String { return Message.typeKey }

    convenience required init?(record: CKRecord) {
         guard let timeStamp = record.creationDate,
            let text = record[Message.textKey] as? String else { return nil } 
//            let sender = record[Message.senderKey] as? CKReference,
//            let thread = record[Message.threadKey] as? CKReference,
//            let user = record [Message.userKey] as? [User]         }
        
        self.init(text: text /* sender: sender, thread: thread*/, timeStamp: timeStamp)
       cloudKitRecordID = record.recordID
        
    }
    
    var cloudKitRecord: CKRecord {
        let record = CKRecord(recordType: Message.typeKey)
        record[Message.textKey] = text
//        record[Message.senderKey] = sender
//        record[Message.threadKey] = thread
        record[Message.timestampKey] = timeStamp
        
        return record
    }
    
}
