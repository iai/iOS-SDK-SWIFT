//
//  UsuarioViewController.swift
//  BancoDeDados
//
//  Created by Lucas Longo on 8/26/15.
//  Copyright (c) 2015 iai. All rights reserved.
//

import UIKit

class UsuarioViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var usuario : Usuario?
    
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var sobreNomeTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var telefoneButton: UIButton!
    
    @IBAction func inserirValor(sender: AnyObject) {
        
        if nomeTextField.text == "" || sobreNomeTextField.text == "" {
            UIAlertView(title: "Oooops", message: "Preencha o nome e sobrenome do usuário primeiro", delegate: nil, cancelButtonTitle: "OK").show()
            return
        }
        
        var alertTitle = ""
        var alertMessage = ""
        var keyBoardType = UIKeyboardType.EmailAddress
        var textFieldText = ""
        var email : Email?
        var telefone : Telefone?
        var clickedButton : UIButton?
        
        if let button = sender as? UIButton {
            
            clickedButton = button
            
            if button == emailButton {
                alertTitle = "Novo Email"
                alertMessage = "Digite o email "
                keyBoardType = .EmailAddress
            }
            else if button == telefoneButton {
                alertTitle = "Novo Telefone"
                alertMessage = "Digite o telefone"
                keyBoardType = .NumberPad
           }
        }
        else if let e = sender as? Email {
            alertTitle = "Editar Email"
            alertMessage = "Edite o email"
            keyBoardType = .EmailAddress
            textFieldText = e.email
            email = e
        }
        else if let t = sender as? Telefone {
            alertTitle = "Novo Telefone"
            alertMessage = "Edite o telefone"
            keyBoardType = .NumberPad
            textFieldText = "\(t.telefone)"
            telefone = t
        }
        
        var alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField!) -> Void in
            textField.keyboardType = keyBoardType
            textField.text = textFieldText
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction!) -> Void in
            
            if let textField = alert.textFields?[0] as? UITextField {
                if let e = email {
                    e.email = textField.text
                }
                else if let t = telefone {
                    if let tel = textField.text.toInt() {
                        t.telefone = Int64(tel)
                    }
                }
                else if clickedButton == self.emailButton {
                    let email = Email(email: textField.text, user: self.usuario!)
                    self.usuario!.emails?.addObject(email)
                }
                else if clickedButton == self.telefoneButton {
                    if let tel = textField.text.toInt() {
                        let telefone = Telefone(telefone: Int64(tel), user: self.usuario!)
                        self.usuario!.telefones?.addObject(telefone)
                    }
                 }
                
                self.view.endEditing(true)
                self.tableView.reloadData()
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func updateInterface() {
        
        if usuario == nil {
            self.title = "Novo"
        }
        else {
            self.title = "Editar"
            nomeTextField.text = usuario?.nome
            sobreNomeTextField.text = usuario?.sobreNome
        }
        
        tableView.reloadData()
    }
    
    // MARK: UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count = 0
        
        switch section {
        case 0:
            if let c = usuario?.emails?.count {
                count = c
            }
            break
        case 1:
            if let c = usuario?.telefones?.count {
                count = c
            }
            break
        default:
            break
        }
        
        return count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        
        switch indexPath.section {
        case 0:
            if let email = usuario?.emails?[indexPath.row] as? Email {
                cell.textLabel?.text = email.email
            }
            break
        case 1:
            if let telefone = usuario?.telefones?[indexPath.row] as? Telefone {
                cell.textLabel?.text = "\(telefone.telefone)"
            }
            break
        default:
            break
        }
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.section {
        case 0:
            if let email = usuario?.emails?[indexPath.row] as? Email {
                inserirValor(email)
            }
            break
        case 1:
            if let telefone = usuario?.telefones?[indexPath.row] as? Telefone {
                inserirValor(telefone)
            }
            break
        default:
            break
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var titulo = ""
        switch section {
        case 0:
            titulo = "Emails"
            break
        case 1:
            titulo = "Telefones"
            break
        default:
            break
        }
        return titulo
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            switch indexPath.section {
            case 0:
                if let emails = usuario?.emails {
                    if let email = emails[indexPath.row] as? Email {
                        MeuSQL.deleteEmail(email)
                        emails.removeObjectAtIndex(indexPath.row)
                    }
                }
                break
            case 1:
                if let telefones = usuario?.telefones {
                    if let telefone = telefones[indexPath.row] as? Telefone {
                        MeuSQL.deleteTelefone(telefone)
                        telefones.removeObjectAtIndex(indexPath.row)
                    }
                }
                break
            default:
                break
            }
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    func save() {
        
        if nomeTextField.text == "" || sobreNomeTextField.text == "" {
            return
        }
        
        if let u = usuario {
            
            u.nome = nomeTextField.text
            u.sobreNome = sobreNomeTextField.text
            
            if u.id == -1 {
                MeuSQL.createUser(u)
            }
            else {
                MeuSQL.updateUser(u)
            }
            
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    // MARK: View Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateInterface()
        
        if usuario == nil {
            usuario = Usuario()
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        save()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
