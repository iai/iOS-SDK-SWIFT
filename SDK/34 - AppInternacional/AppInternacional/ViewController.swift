//
//  ViewController.swift
//  AppInternacional
//
//  Created by Lucas Longo on 9/1/15.
//  Copyright (c) 2015 iai. All rights reserved.
//

import UIKit

var langDict : NSDictionary!

class ViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    
    @IBAction func mudarIdioma(sender: UISegmentedControl) {
        
        if let path = NSBundle.mainBundle().pathForResource("Traducoes", ofType: "plist") {
            
            if let dict = NSDictionary(contentsOfFile: path) {
                
                switch sender.selectedSegmentIndex {
                case 0: // Espanhol
                    langDict =  dict["es"] as! NSDictionary
                    break
                case 1: // Portugues
                    langDict =  dict["pt"] as! NSDictionary
                    
                    break
                case 2: // Ingles
                    langDict =  dict["en"] as! NSDictionary
                    break
                default:
                    langDict =  dict["en"] as! NSDictionary
                    break
                }
                
                if let string = langDict["welcome"] as? String {
                    statusLabel.text = string
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        statusLabel.text = NSLocalizedString("welcomePhrase", comment: "usado somente no inicio do app")
        
        println(NSLocalizedString("welcomePhrase1", comment: "usado somente no inicio do app"))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

