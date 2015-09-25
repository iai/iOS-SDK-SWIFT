//
//  ViewController.swift
//  BancoDeDados
//
//  Created by Lucas Longo on 8/23/15.
//  Copyright (c) 2015 iai. All rights reserved.
//

import UIKit
import CoreData

let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

class ViewController: UITableViewController, UISearchBarDelegate, UISearchControllerDelegate {
    
    var usuariosArray = [User]()
    var usuariosEncontradosArray = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        getAllItems()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        updateInterface()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateInterface() {
        if let array = User.getAllItemsInManagedObjectContext(managedObjectContext!) {
            usuariosArray = array
            self.tableView.reloadData()
        }
    }
    
    func getAllItems() {
        if let array = User.getAllItemsInManagedObjectContext(managedObjectContext!) {
            usuariosArray = array
        }
    }
    
    // MARK: UITableViewDataSource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case self.tableView:
            return usuariosArray.count
        default:
            return usuariosEncontradosArray.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell!
        
        if let c = tableView.dequeueReusableCellWithIdentifier("Cell") as? UITableViewCell {
            cell = c
        }
        else {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "Cell")
        }
        
        var user : User!
        
        switch tableView {
        case self.tableView:
            user = usuariosArray[indexPath.row]
            break
        default:
            user = usuariosEncontradosArray[indexPath.row]
            break
        }
        
        cell.textLabel?.text = user.usuario
        
        var text = ""
        text = "\(user.emails.count) "
        text += user.emails.count == 1 ? "email" : "emails"
        text += " \(user.telefones.count) "
        text += user.telefones.count == 1 ? "telefone" : "telefones"
        
        cell.detailTextLabel?.text =  text
        
        return cell!
        
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        switch tableView {
        case self.tableView:
            return true
        default:
            return false
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            let usuario = usuariosArray[indexPath.row]
            managedObjectContext!.deleteObject(usuario)
            usuariosArray.removeAtIndex(indexPath.row)
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var user : User!
        
        switch tableView {
        case self.tableView:
            user = usuariosArray[indexPath.row]
            break
        default:
            user = usuariosEncontradosArray[indexPath.row]
            break
        }
        
        performSegueWithIdentifier("showUser", sender: user)
    }
    
    // MARK: UISearchBarDelegate
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if let array = User.filterResultsInManagedObjectContext(managedObjectContext!, searchString: searchText) {
            usuariosEncontradosArray = array
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if let array = User.filterResultsInManagedObjectContext(managedObjectContext!, searchString: searchBar.text) {
            usuariosEncontradosArray = array
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier!  {
        case "showUser":
            if let vc = segue.destinationViewController as? UsuarioViewController {
                vc.user = sender as? User
            }
            break
        default:
            break
        }
    }
    
}

