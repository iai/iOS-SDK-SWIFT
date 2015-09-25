//
//  Telefone.swift
//  
//
//  Created by Lucas Longo on 8/24/15.
//
//

import UIKit
import CoreData

class Telefone: NSManagedObject {

    @NSManaged var telefone: NSNumber
    @NSManaged var user: User
    
    class func createInManagedObjectContext(moc: NSManagedObjectContext, telefone: String, forUser: User) -> Telefone? {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Telefone", inManagedObjectContext: moc) as! Telefone

        if let telNum = telefone.toInt() {
            newItem.telefone = NSNumber(integer: telNum)
            newItem.user = forUser
            
            return newItem
        }
        
        return nil
    }
    
    class func getAllItemsInManagedObjectContext(moc: NSManagedObjectContext) -> [Telefone]? {
        
        let fetchRequest = NSFetchRequest(entityName: "Telefone")
        
        if let fetchResults = moc.executeFetchRequest(fetchRequest, error: nil) as? [Telefone] {
            return fetchResults
        }
        
        return nil
    }


}
