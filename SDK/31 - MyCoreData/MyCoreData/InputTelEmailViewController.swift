//
//  InputTelEmailViewController.swift
//  BancoDeDados
//
//  Created by Lucas Longo on 8/23/15.
//  Copyright (c) 2015 iai. All rights reserved.
//

import UIKit

enum InputType {
    case Telefone
    case Email
}

protocol InputTelEmailViewControllerDelegate {
    func inputTelEmailViewControllerCreateNewItemWith(text: String, type: InputType)
    func inputTelEmailViewControllerUpdateItemWith(text: String, type: InputType, index: Int)
}

class InputTelEmailViewController: UIViewController, UITextFieldDelegate {

    var inputType = InputType.Email
    var initialText : String?
    var index : Int?
    var delegate : InputTelEmailViewControllerDelegate?

    @IBOutlet weak var dataTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateInterface()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateInterface() {
        
        dataTextField.becomeFirstResponder()
        
        switch inputType {
        case .Telefone:
            self.title = "Telefone"
            dataTextField.keyboardType = UIKeyboardType.NumberPad
            break
        case .Email:
            self.title = "Email"
            break
        default:
            break
        }

        let saveButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: self, action: "saveData")
        self.navigationItem.rightBarButtonItem = saveButton

        if let t = initialText {
            dataTextField.text = t
        }

    }

    func saveData() {
        
        if let text = initialText, index = index {
            delegate?.inputTelEmailViewControllerUpdateItemWith(dataTextField.text, type: inputType, index: index)
        }
        else {
            delegate?.inputTelEmailViewControllerCreateNewItemWith(dataTextField.text, type: inputType)
        }

        self.navigationController?.popViewControllerAnimated(true)
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        saveData()
        return true
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
