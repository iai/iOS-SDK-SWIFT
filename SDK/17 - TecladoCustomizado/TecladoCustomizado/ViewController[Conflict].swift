//
//  ViewController.swift
//  TecladoCustomizado
//
//  Created by Thiago Delmotte on 29/10/14.
//  Copyright (c) 2014 iai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    var datePicker: UIDatePicker!
    var toolBar: UIToolbar!
    var okBt: UIBarButtonItem!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Date Picker
        datePicker = UIDatePicker(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))
        
        textField.inputView = datePicker
        
        //Toolbar
        toolBar = UIToolbar(frame: CGRectMake(0, 0, self.view.bounds.size.width, 44))
        
        okBt = UIBarButtonItem(title: "OK", style: UIBarButtonItemStyle.Plain, target: self, action:"hideKeyboard")
        
        toolBar.items = [uibarbuttonitemfl,]okBt]
        
        textField.inputAccessoryView = toolBar
        
        
//        UIBarButtonItem *okBt = [[UIBarButtonItem alloc] initWithTitle:@"OK" style:UIBarButtonItemStylePlain target:target action:selector];
//        [okBt setTintColor:[UIColor colorWithRed:0.671 green:0.839 blue:0.941 alpha:1]];
//        
//        UIToolbar* numberToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
//        numberToolbar.barStyle = UIBarStyleBlackTranslucent;
//        numberToolbar.items = [NSArray arrayWithObjects:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], okBt, nil];
//        [numberToolbar sizeToFit];
//        
//        return numberToolbar;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hideKeyboard() {
        
        textField.resignFirstResponder()
        
    }

}

