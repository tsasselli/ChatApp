//
//  Thread.swift
//  ChatApp
//
//  Created by Travis Sasselli on 8/16/16.
//  Copyright © 2016 TravisSasselli. All rights reserved.
//

import Foundation
import CloudKit

class Thread {
    
    
    static let threadKey = "thread"
    static let typeKey = "Thread"
    
    
    var thread: String
    
    init( thread: String) {
        self.thread = thread
    }
    var recordType: String { return Thread.typeKey }
    var cloudKitRecordID: CKRecordID?

    
    convenience required init?(record: CKRecord){
        guard let threads = record[Thread.threadKey] as? String,
            let thread = record[Thread.typeKey] as? String else{ return nil }
        
        self.init(thread: thread)
        cloudKitRecordID = record.recordID

    }
    
    var cloudKitRecord: CKRecord {
        let record = CKRecord(recordType: Thread.typeKey)
        record[Thread.threadKey] = thread
        return record
    }
}