//
//  ViewController.swift
//  Background2
//
//  Created by Lucas Longo on 8/21/15.
//  Copyright (c) 2015 iai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "fetchDate", userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func fetchDate() {
        if let url = NSURL(string: "http://iai.art.br/escola/backgroundFetch.php") {
            if let dateString = NSString(contentsOfURL: url, encoding: NSUTF8StringEncoding, error: nil) {
                println("\(dateString)")
            }
        }
    }


}

