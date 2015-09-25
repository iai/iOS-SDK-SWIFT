//
//  ViewController.swift
//  LoginWebService
//
//  Created by Lucas Longo on 6/12/15.
//  Copyright (c) 2015 iai. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginAction(sender: AnyObject) {
        
        var request = NSMutableURLRequest(URL: NSURL(string: "http://iai.art.br/escola/login.php")!)
        request.HTTPMethod = "POST"
        
        var user = userTextField.text
        var pwd = pwdTextField.text
        
        // OBS: user = 'iai' e senha = 'aluno' para dar certo
        let loginString = "user=\(user)&pwd=\(pwd)"

        if let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding) {
            request.HTTPBody = loginData
            println("HTTPBody: \(NSString(data: loginData, encoding: NSUTF8StringEncoding))")
        }
        
        
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var session = NSURLSession.sharedSession()
        
        var task = session.dataTaskWithRequest(request, completionHandler: { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            
            var json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSDictionary
            
            println("JSON \(json)")

            if let dataDict = json["data"] as? NSDictionary {
                if let result = json["result"] as? String {
                    if result == "ok" {
                        for (key, value) in dataDict {
                            println("\(key) : \(value)")
                        }
                    }
                }
            }
            
            if let error = json["error"] as? String {
                println("ERROR \(error)")
            }
        })
        
        task.resume()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch textField {
        case userTextField:
            pwdTextField.becomeFirstResponder()
            break
        case pwdTextField:
            loginAction(self)
            break
        default:
            break
        }
        
        return true
    }
}











