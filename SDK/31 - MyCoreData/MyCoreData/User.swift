//
//  User.swift
//  
//
//  Created by Lucas Longo on 8/24/15.
//
//

import UIKit
import CoreData


class User: NSManagedObject {

    @NSManaged var usuario: String
    @NSManaged var senha: String
    @NSManaged var emails: NSSet
    @NSManaged var telefones: NSSet

    
    class func createItemInManagedObjectContext(moc: NSManagedObjectContext, usuario: String, senha: String, emails: NSMutableArray, telefones: NSMutableArray) -> User? {
        
        if let newItem = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: moc) as? User {
            newItem.usuario = usuario
            newItem.senha = senha
            
            var telefonesSet = NSMutableSet()
            for telefone in telefones {
                if let telString = telefone as? String {
                    if let t = Telefone.createInManagedObjectContext(moc, telefone: telString, forUser: newItem) {
                        telefonesSet.addObject(t)
                    }
                }
            }
            newItem.telefones = telefonesSet
            
            var emailsSet = NSMutableSet()
            for email in emails {
                if let emailString = email as? String {
                    if let e = Email.createInManagedObjectContext(moc, email: emailString, forUser: newItem) {
                        emailsSet.addObject(e)
                    }
                }
            }
            newItem.emails = emailsSet
            
            return newItem
        }
        
        return nil
        
    }
    
    func update(usuario: String, senha: String, emails: NSMutableArray, telefones: NSMutableArray) -> Bool {
        

            self.usuario = usuario
            self.senha = senha
        
            var telefonesSet = NSMutableSet()
            for telefone in telefones {
                if let telString = telefone as? String {
                    if let t = Telefone.createInManagedObjectContext(self.managedObjectContext!, telefone: telString, forUser: self) {
                        telefonesSet.addObject(t)
                    }
                }
            }
            self.telefones = telefonesSet
        
            var emailsSet = NSMutableSet()
            for email in emails {
                if let emailString = email as? String {
                    if let e = Email.createInManagedObjectContext(self.managedObjectContext!, email: emailString, forUser: self) {
                        emailsSet.addObject(e)
                    }
                }
            }
            self.emails = emailsSet
        
            save()
        
        return true
        
    }

    
    class func getAllItemsInManagedObjectContext(moc: NSManagedObjectContext) -> [User]? {
        
        let fetchRequest = NSFetchRequest(entityName: "User")
        let sortDescriptor = NSSortDescriptor(key: "usuario", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let fetchResults = moc.executeFetchRequest(fetchRequest, error: nil) as? [User] {
            return fetchResults
        }
        
        return nil
    }
    
    class func filterResultsInManagedObjectContext(moc: NSManagedObjectContext, searchString: String) -> [User]? {
        
        let fetchRequest = NSFetchRequest(entityName: "User")
        
        let userPredicate = NSPredicate(format: "usuario contains %@", searchString)
        let emailPredicate = NSPredicate(format: "ANY emails.email contains %@", searchString)
        let telPredicate = NSPredicate(format: "ANY telefones.telefone contains %@", searchString)
        
        let predicate = NSCompoundPredicate(type: NSCompoundPredicateType.OrPredicateType, subpredicates: [userPredicate, emailPredicate, telPredicate])
        
        fetchRequest.predicate = predicate
        
        if let fetchResults = moc.executeFetchRequest(fetchRequest, error: nil) as? [User] {
            return fetchResults
        }
        
        return nil
    }
    

    func save() {
        var error : NSError?
        if(self.managedObjectContext!.save(&error) ) {
            if error != nil {
                println(error?.localizedDescription)
            }
        }
    }
    
}
