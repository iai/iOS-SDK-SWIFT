//
//  ViewController.swift
//  Aula101
//
//  Created by Eduardo Lima on 9/12/14.
//  Copyright (c) 2014 personal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("ViewController carregada.")
        
        let novaLabel = UILabel()
        novaLabel.frame = CGRect(x: 20, y: 80, width: 100, height: 50)
        novaLabel.text = "Olá, mundo!"
        
        self.view.addSubview(novaLabel)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        println("ViewController vai aparecer.")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    
        println("ViewController apareceu.")
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        println("ViewController vai desaparecer.")
    }

    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        println("ViewController desapareceu.")
    }
}

