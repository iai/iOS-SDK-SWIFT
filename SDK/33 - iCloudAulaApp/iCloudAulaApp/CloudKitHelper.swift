//
//  CloudKitHelper.swift
//  iCloudAulaApp
//
//  Created by Lucas Longo on 9/1/15.
//  Copyright (c) 2015 iai. All rights reserved.
//

import UIKit
import CloudKit

class CloudKitHelper {

    var container : CKContainer!
    var privateDatabase : CKDatabase!
    
    init() {
        container = CKContainer.defaultContainer()
        privateDatabase = container.privateCloudDatabase
    }
    
    func saveNote(noteTitle: String, noteText: String, imageURL: NSURL, completionBlock: (success: Bool) -> Void) {
        
        // RecordID as timestamp
        let timestampAsString = String(format: "%f", NSDate.timeIntervalSinceReferenceDate())
        let timestampParts = timestampAsString.componentsSeparatedByString(".")
        let recordID = CKRecordID(recordName: timestampParts[0])
        
        // Create record with recordID created above
        let noteRecord = CKRecord(recordType: "Notes", recordID: recordID)
        
        // Set text values
        noteRecord.setObject(noteTitle, forKey: "noteTitle")
        noteRecord.setObject(noteText, forKey: "noteText")
        
        // Set date
        noteRecord.setObject(NSDate(), forKey: "noteEditedDate")
        
        // Set Image
        let imageAsset = CKAsset(fileURL: imageURL)
        noteRecord.setObject(imageAsset, forKey: "noteImage")
        
        // Save record
        privateDatabase.saveRecord(noteRecord, completionHandler: { (record, error) -> Void in

            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                if (error != nil) {
                    completionBlock(success: false)
                }
                else {
                    completionBlock(success: true)
                }
            })
        })
    }
    
    func getNotes(completionBlock: (Array<CKRecord>) -> Void) {
        
        var arrNotes : Array<CKRecord> = []
                
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Notes", predicate: predicate)
        
        privateDatabase.performQuery(query, inZoneWithID: nil) { (results, error) -> Void in
            if error != nil {
                println(error)
            }
            else {
                
                for r in results {
                    if let result = r as? CKRecord {
                        arrNotes.append(result)
                    }
                }
                
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    completionBlock(arrNotes)
                })
            }
        }
    }
    
    func deleteNote(note: CKRecord, completionBlock: (success: Bool) -> ()) {
        
        privateDatabase.deleteRecordWithID(note.recordID, completionHandler: { (recordId: CKRecordID!, error: NSError!) -> Void in
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                if (error != nil) {
                    completionBlock(success: false)
                }
                else {
                    completionBlock(success: true)
                }
            })
        })
    }
}
