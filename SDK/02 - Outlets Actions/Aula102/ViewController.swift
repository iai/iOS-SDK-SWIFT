//
//  ViewController.swift
//  Aula102
//
//  Created by Eduardo Lima on 9/14/14.
//  Copyright (c) 2014 personal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var contador = 0
    
    @IBOutlet weak var label: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.label.backgroundColor = UIColor.yellowColor()
    }
    
    @IBAction func botaoPressionado(sender: UIButton) {
        self.label.text = "Pressionou \(++contador) vezes"
    }
}

