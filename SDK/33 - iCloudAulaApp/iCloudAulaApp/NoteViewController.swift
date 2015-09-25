//
//  NoteViewController.swift
//  iCloudAulaApp
//
//  Created by Lucas Longo on 9/1/15.
//  Copyright (c) 2015 iai. All rights reserved.
//

import UIKit
import CloudKit

class NoteViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    var note : CKRecord?
    
    @IBOutlet weak var noteTitleTextField: UITextField!
    @IBOutlet weak var noteTextTextView: UITextView!
    @IBOutlet weak var noteImageImageView: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBAction func addPhoto(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            imagePicker.allowsEditing = false
            presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        noteImageImageView.image = image
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateInterface()
        
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: self, action: "save")
        self.navigationItem.rightBarButtonItem = button
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateInterface() {
        
        if let title = note?.valueForKey("noteTitle") as? String {
            noteTitleTextField.text = title
        }
        if let date = note?.valueForKey("noteEditedDate") as? NSDate {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "MMMM dd, yyyy, hh:mm"
            noteTextTextView.text = formatter.stringFromDate(date)
        }
        if let image = note?.valueForKey("noteImage") as? CKAsset {
            if let path = image.fileURL.path {
                noteImageImageView.image = UIImage(contentsOfFile: path)
            }
        }
    }
    
    func save() {
        spinner.startAnimating()
        self.view.endEditing(true)
        
        if let imageUrl = saveImageLocally() {
            CloudKitHelper().saveNote(noteTitleTextField.text, noteText: noteTextTextView.text, imageURL: imageUrl) { (success) -> Void in
                self.spinner.stopAnimating()
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
    }
    
    func saveImageLocally() -> NSURL? {
        
        if let image = noteImageImageView.image {
            if let imageData = UIImageJPEGRepresentation(image, 0.8) {
                let path = NSHomeDirectory().stringByAppendingPathComponent("Documents/tmpImage.png")
                if let imageURL = NSURL(fileURLWithPath: path) {
                    imageData.writeToURL(imageURL, atomically: true)
                    return imageURL
                }
            }
        }
        
        return nil
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
