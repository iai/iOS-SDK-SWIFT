//
//  Email.swift
//  
//
//  Created by Lucas Longo on 8/24/15.
//
//

import UIKit
import CoreData

class Email: NSManagedObject {

    @NSManaged var email: String
    @NSManaged var user: User

    
    class func createInManagedObjectContext(moc: NSManagedObjectContext, email: String, forUser: User) -> Email? {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Email", inManagedObjectContext: moc) as! Email
        
            newItem.email = email
        
        newItem.user = forUser
        
        return newItem
    }
    
    class func getAllItemsInManagedObjectContext(moc: NSManagedObjectContext) -> [Email]? {
        
        let fetchRequest = NSFetchRequest(entityName: "Email")
        
        if let fetchResults = moc.executeFetchRequest(fetchRequest, error: nil) as? [Email] {
            return fetchResults
        }
        
        return nil
    }

}
