//
//  ViewController.swift
//  BancoDeDados
//
//  Created by Lucas Longo on 8/24/15.
//  Copyright (c) 2015 iai. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var usuariosArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        MeuSQL.initializeDB()
        MeuSQL.criarTabelas()
        MeuSQL.inserirDados()
        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        usuariosArray = MeuSQL.getAllUsers()
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usuariosArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        
        if let user = usuariosArray[indexPath.row] as? Usuario {
            cell.textLabel?.text = user.nome
            cell.detailTextLabel?.text = user.sobreNome
        }
        return cell
    }

    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            if let usuario = usuariosArray[indexPath.row] as? Usuario {
                MeuSQL.deleteUser(usuario)
                usuariosArray.removeObjectAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? UsuarioViewController {
            if let row = tableView.indexPathForSelectedRow()?.row {
                if let usuario = usuariosArray[row] as? Usuario {
                    vc.usuario = usuario
                }
            }
        }
    }
}

