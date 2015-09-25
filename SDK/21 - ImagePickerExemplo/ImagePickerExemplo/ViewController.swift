//
//  ViewController.swift
//  ImagePickerExemplo
//
//  Created by Eduardo Lima on 6/3/14.
//  Copyright (c) 2014 personal. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.imagePicker.delegate = self
        self.imagePicker.allowsEditing = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func adicionarFotoPressionado(sender : AnyObject) {
        
        let alerta = UIAlertController(title: "Escolha a origem da imagem:", message: nil, preferredStyle: .ActionSheet)
        alerta.addAction(UIAlertAction(title: "Album", style: .Default, handler: { (action) -> Void in
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
        }))
        alerta.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { (action) -> Void in
            if UIImagePickerController.isSourceTypeAvailable(.Camera){
                self.imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
                self.presentViewController(self.imagePicker, animated: true, completion: nil)
            }
        }))
        alerta.addAction(UIAlertAction(title: "Cancelar", style: .Destructive, handler: nil))

        self.presentViewController(alerta, animated: true, completion: nil)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: NSDictionary!){
        
        let imageView = UIImageView(frame: CGRectMake(20, 20, 200, 200))
        imageView.center = self.view.center
        imageView.contentMode = .ScaleAspectFill
        imageView.image = info[UIImagePickerControllerEditedImage] as? UIImage
        self.view.addSubview(imageView)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

