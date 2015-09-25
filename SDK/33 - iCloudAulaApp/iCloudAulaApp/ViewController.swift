//
//  ViewController.swift
//  iCloudAulaApp
//
//  Created by Lucas Longo on 9/1/15.
//  Copyright (c) 2015 iai. All rights reserved.
//

import UIKit
import CloudKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var arrNotes: Array<CKRecord> = []

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let cloudKit = CloudKitHelper()
        spinner.startAnimating()
        cloudKit.getNotes { (array: Array<CKRecord>) -> Void in
            self.spinner.stopAnimating()
            self.arrNotes = array
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UITableViewDataSource, UITableViewDelegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrNotes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        
        let note = arrNotes[indexPath.row]
        if let title = note.valueForKey("noteTitle") as? String {
            cell.textLabel?.text = title
        }
        if let date = note.valueForKey("noteEditedDate") as? NSDate {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "MMMM dd, yyyy, hh:mm"
            cell.detailTextLabel?.text = formatter.stringFromDate(date)
        }
        if let image = note.valueForKey("noteImage") as? CKAsset {
            if let path = image.fileURL.path {
                cell.imageView?.image = UIImage(contentsOfFile: path)
                cell.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let note = arrNotes[indexPath.row]
        performSegueWithIdentifier("showNote", sender: note)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let note = arrNotes[indexPath.row]
            CloudKitHelper().deleteNote(note, completionBlock: { (success) -> () in
                println("delete complete")
            })
            arrNotes.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let note = sender as? CKRecord {
            if let vc = segue.destinationViewController as? NoteViewController {
                vc.note = note
            }
        }
    }
}

