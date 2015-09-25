//
//  ViewController.swift
//  Background
//
//  Created by Lucas Longo on 8/21/15.
//  Copyright (c) 2015 iai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Chamanda função que esta neste ViewController
        fetchDateBy("ViewController", completion: { () -> Void in
            println("Done in View Controller")
        }) { () -> Void in
            println("ERRO in View Controller")
        }
        
        // Chamanda função que esta no AppDelegate
        if let delegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            
            delegate.fetchDateBy("ViewController", completion: { () -> Void in
                println("Executei fetch do AppDelegate")
            }, downloadFailed: { () -> Void in
                println("ERRO no fetch do AppDelegate")
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func fetchDateBy(name: String, completion: () -> Void, downloadFailed: () -> Void) {
        if let url = NSURL(string: "http://iai.art.br/escola/backgroundFetch.php") {
            if let dateString = NSString(contentsOfURL: url, encoding: NSUTF8StringEncoding, error: nil) {
                println("\(name) \(dateString)")
                completion()
            }
            else {
                downloadFailed()
            }
        }
        else {
            downloadFailed()
        }
    }
}

