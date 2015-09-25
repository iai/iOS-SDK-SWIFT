//
//  UsuarioViewController.swift
//  BancoDeDados
//
//  Created by Lucas Longo on 8/23/15.
//  Copyright (c) 2015 iai. All rights reserved.
//

import UIKit

class UsuarioViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, InputTelEmailViewControllerDelegate, UITextFieldDelegate {

    var user : User?
    var usuario : String!
    var senha : String!
    var emails = NSMutableArray()
    var telefones = NSMutableArray()
    
    @IBOutlet weak var usuarioTextField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startUpInterface()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        updateInterface()
    }
    
    // MARK: - MyFunctions
    func startUpInterface() {

        let saveButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: self, action: "saveData")
        self.navigationItem.rightBarButtonItem = saveButton

        usuario = user?.usuario
        senha = user?.senha
        if let e = user?.emails {
            e.enumerateObjectsUsingBlock({ (umEmail: AnyObject!, stop: UnsafeMutablePointer<ObjCBool>) -> Void in

                if let email = umEmail as? Email {
                    self.emails.addObject(email.email)
                }
            })
        }
        if let t = user?.telefones {
            t.enumerateObjectsUsingBlock({ (umTelefone: AnyObject!, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
                if let telefone = umTelefone as? Telefone {
                    self.telefones.addObject("\(telefone.telefone)")
                }
            })
        }
        
    }
    
    func updateInterface() {
        
        if user != nil {
            self.title = "Editar Usuário"
        }
        else {
            self.title = "Novo Usuário"
        }
        
        usuarioTextField.text = usuario
        senhaTextField.text = senha

        tableView.reloadData()
        
    }

    func saveData() {
    
        self.view.endEditing(true)
        
            if user != nil {
                user?.update(usuario, senha: senha, emails: emails, telefones: telefones)
            }
            else {
                if let user = User.createItemInManagedObjectContext(managedObjectContext!, usuario: usuario, senha: senha, emails: emails, telefones: telefones) {
                    self.user = user
                }
            }
            
            user?.save()
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: UITableViewDataSource, UITableViewDelegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "Emails"
        case 1:
            return "Telefones"
        default:
            return ""
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
                return emails.count
        case 1:
                return telefones.count
        default:
                return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        
        switch indexPath.section {
        case 0:
            if let e = emails[indexPath.row] as? String {
                cell.textLabel?.text = e
            }
            break
        case 1:
            if let t = telefones[indexPath.row] as? String {
                cell.textLabel?.text = t
            }
            break
        default:
            cell.textLabel?.text = ""
            break
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.section {
        case 0:
            if let email = emails[indexPath.row] as? String {
                self.performSegueWithIdentifier("addEmail", sender: email)
            }
            break
        case 1:
            if let telefone = telefones[indexPath.row] as? String {
                self.performSegueWithIdentifier("addTelefone", sender: telefone)
            }
            break
        default:
            break
        }
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            switch indexPath.section {
            case 0:
                emails.removeObjectAtIndex(indexPath.row)
                break
            case 1:
                telefones.removeObjectAtIndex(indexPath.row)
                break
            default:
                break
            }
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }


    // MARK: InputTelEmailViewControllerDelegate
    func inputTelEmailViewControllerCreateNewItemWith(text: String, type: InputType) {
        
        switch type {
        case .Email:
            emails.addObject(text)
            break
        case .Telefone:
            telefones.addObject(text)
            break
        default:
            break
        }
        
        updateInterface()
    }
    
    func inputTelEmailViewControllerUpdateItemWith(text: String, type: InputType, index: Int) {
        
        switch type {
        case .Email:
            emails.replaceObjectAtIndex(index, withObject: text)
            break
        case .Telefone:
            telefones.replaceObjectAtIndex(index, withObject: text)
            break
        default:
            break
        }
        
        updateInterface()
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == usuarioTextField {
            senhaTextField.becomeFirstResponder()
        }
        else {
            textField.resignFirstResponder()
        }
        return true
    }

    func textFieldDidEndEditing(textField: UITextField) {
        usuario = usuarioTextField.text
        senha = senhaTextField.text
    }
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let vc = segue.destinationViewController as? InputTelEmailViewController, identifier = segue.identifier  {
            
            switch identifier {
            case "addEmail":
                vc.inputType = .Email
                if let email = sender as? String {
                    vc.initialText = email
                }
                break
            case "addTelefone":
                vc.inputType = .Telefone
                if let telefone = sender as? String {
                    vc.initialText = telefone
                }
                break
            default:
                break
            }
            
            vc.delegate = self
            vc.index = tableView.indexPathForSelectedRow()?.row
        }
    }
}
