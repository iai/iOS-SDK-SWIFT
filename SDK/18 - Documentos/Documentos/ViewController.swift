//
//  ViewController.swift
//  Documentos
//
//  Created by Thiago Delmotte on 24/10/14.
//  Copyright (c) 2014 iai. All rights reserved.
//

import UIKit
import QuickLook

class ViewController: UIViewController {
    
    let quickLookController = QLPreviewController()
    var docs = [NSURL]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadDocuments()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDocuments() {
        
        if let path = NSBundle.mainBundle().pathForResource("exemplo", ofType: "pdf"){
            let url = NSURL.fileURLWithPath(path)!
            docs.append(url);
        }
        
        if let path = NSBundle.mainBundle().pathForResource("exemplo", ofType: "pptx"){
            let url = NSURL.fileURLWithPath(path)!
            docs.append(url);
        }

        if let path = NSBundle.mainBundle().pathForResource("exemplo", ofType: "docx"){
            let url = NSURL.fileURLWithPath(path)!
            docs.append(url);
        }
        
        if let path = NSBundle.mainBundle().pathForResource("exemplo", ofType: "xlsx"){
            let url = NSURL.fileURLWithPath(path)!
            docs.append(url);
        }
        
        if let path = NSBundle.mainBundle().pathForResource("exemplo", ofType: "numbers"){
            let url = NSURL.fileURLWithPath(path)!
            docs.append(url);
        }
        
        quickLookController.dataSource = self
        
    }
    
    @IBAction func abrirPreviewPressionado(sender: UIButton) {
        
        if let path = NSBundle.mainBundle().pathForResource("exemplo", ofType: "pdf"){
            
            let url = NSURL.fileURLWithPath(path)!
            
            let docController = UIDocumentInteractionController(URL: url)
            
            docController.delegate = self
            
            docController.presentPreviewAnimated(true)
            
        }
        
    }
    
    @IBAction func abrirVariosDocsPressionado(sender: UIButton) {
        
        self.presentViewController(quickLookController, animated: true, completion: nil)
        
    }
    
}

extension ViewController: UIDocumentInteractionControllerDelegate {

    func documentInteractionControllerViewControllerForPreview(controller: UIDocumentInteractionController) -> UIViewController {
        
        return self
        
    }

    
}

extension ViewController: QLPreviewControllerDataSource {
    
    func previewController(controller: QLPreviewController!, previewItemAtIndex index: Int) -> QLPreviewItem! {
        
        return docs[index]
        
    }

    func numberOfPreviewItemsInPreviewController(controller: QLPreviewController!) -> Int {
        
        return docs.count
        
    }
    
}