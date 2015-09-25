//
//  AdicionarViewController.swift
//  AulaFinal01
//
//  Created by Eduardo Lima on 9/30/14.
//  Copyright (c) 2014 personal. All rights reserved.
//

import UIKit

class AdicionarViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var campoNome: UITextField!
    @IBOutlet weak var campoSobrenome: UITextField!
    @IBOutlet weak var campoTelefone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func confirmarPressionado(sender: AnyObject) {
        
        let contato = Contato(nome: self.campoNome.text, sobrenome: self.campoSobrenome.text, telefone: self.campoTelefone.text)
        
        GerenciadorArquivo.adicionarNovoContato(contato)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        switch textField{
            
            case self.campoNome:
                self.campoSobrenome.becomeFirstResponder()
            
            case self.campoSobrenome:
                self.campoTelefone.becomeFirstResponder()
            
            default:
                self.view.endEditing(true)
        }
        
        return true
    }
}
