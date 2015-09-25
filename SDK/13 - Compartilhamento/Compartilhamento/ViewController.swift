//
//  ViewController.swift
//  Compartilhamento
//
//  Created by Thiago Delmotte on 22/10/14.
//  Copyright (c) 2014 iai. All rights reserved.
//

import UIKit
import Social
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {

    @IBOutlet var message: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.message.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func shareFacebook() {
        
        if (SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook)) {
            
            let fb: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            
            fb.setInitialText(message.text)
            
            self.presentViewController(fb, animated: true, completion: nil)
            
        } else {
            
            let alert = UIAlertController(title: "Ops!", message: "Para que você possa compartilhar no Facebook é necessário que o tenha instalado primeiro!", preferredStyle: .Alert)

            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler:nil))

            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
    }
    
    @IBAction func shareTwitter() {
        
        if (SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter)) {
            
            let twt: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            
            twt.setInitialText(message.text)
            
            self.presentViewController(twt, animated: true, completion: nil)
            
        } else {

            let alert = UIAlertController(title: "Ops!", message: "Para que você possa compartilhar no Twitter é necessário que o tenha instalado primeiro!", preferredStyle: .Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler:nil))

            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
    }
    
    @IBAction func sendSMS() {
        
        let messageVC: MFMessageComposeViewController = MFMessageComposeViewController()
        
        if (MFMessageComposeViewController.canSendText()) {
            
            messageVC.body = message.text
            messageVC.messageComposeDelegate = self
            
            self.presentViewController(messageVC, animated: true, completion: nil)
            
        }
        
    }
    
    @IBAction func sendEmail() {
        
        let emailVC: MFMailComposeViewController = MFMailComposeViewController()
        
        if (MFMailComposeViewController.canSendMail()) {
            
            emailVC.setMessageBody(message.text, isHTML: false)
            emailVC.mailComposeDelegate = self
            
            self.presentViewController(emailVC, animated: true, completion: nil)
            
        }
        
    }
    
    @IBAction func share(sender: UIButton) {
        
        let actionMenu = UIActivityViewController(activityItems: [message.text], applicationActivities: nil);
        
        actionMenu.setValue("Titulo do email", forKey: "subject");
        actionMenu.popoverPresentationController?.sourceView = view
        actionMenu.popoverPresentationController?.sourceRect = sender.frame
        
        self.presentViewController(actionMenu, animated: true, completion: nil);
        
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
        
        switch (result.value) {
            
            case MessageComposeResultCancelled.value:
                NSLog("SMS Cancelado")
                break;
                
            case MessageComposeResultFailed.value:
                NSLog("SMS Falhou o Envio")
                break;
            
            case MessageComposeResultSent.value:
                NSLog("SMS Evniado com Sucesso!")
                break;
                
            default:
                break;
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        
        switch (result.value) {
            
        case MessageComposeResultCancelled.value:
            NSLog("Email Cancelado")
            break;
            
        case MessageComposeResultFailed.value:
            NSLog("Email Falhou o Envio")
            break;
            
        case MessageComposeResultSent.value:
            NSLog("Email Evniado com Sucesso!")
            break;
            
        default:
            break;
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
}

extension ViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
}

