//
//  ViewController.swift
//  Calendario
//
//  Created by Thiago Delmotte on 29/10/14.
//  Copyright (c) 2014 iai. All rights reserved.
//

import UIKit
import EventKit
import EventKitUI

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, EKEventEditViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var tableview:UITableView!
    @IBOutlet weak var initialDate: UITextField!
    @IBOutlet weak var finalDate: UITextField!
    
    var date0: NSDate!
    var date1: NSDate!
    var eventsFound: [EKEvent]!
    var eventStore: EKEventStore!
    var format: NSDateFormatter = NSDateFormatter()
    var datePicker: UIDatePicker!
    var toolBar: UIToolbar!
    var okBt: UIBarButtonItem!


    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        format.dateFormat = "dd/MM/yyyy - HH:mm"
        
        eventsFound = [EKEvent]()
        
        eventStore = EKEventStore()
        eventStore.requestAccessToEntityType(EKEntityTypeEvent, completion: { (granted, error) -> Void in
            if granted{
                println("usuário autorizou")
            }
            else{
                println("sem acesso ao calendario")
            }
        })
        
        //Date Picker
        datePicker = UIDatePicker(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))
        
        initialDate.inputView = datePicker
        finalDate.inputView = datePicker
        
        //Toolbar
        toolBar = UIToolbar(frame: CGRectMake(0, 0, self.view.bounds.size.width, 44))
        
        okBt = UIBarButtonItem(title: "OK", style: UIBarButtonItemStyle.Plain, target: self, action:"hideKeyboard")
        
        var flexSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        
        toolBar.items = [flexSpace, okBt]
        
        initialDate.inputAccessoryView = toolBar
        finalDate.inputAccessoryView = toolBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addEvent() {
        
        let addEventVC: EKEventEditViewController = EKEventEditViewController()
        addEventVC.editViewDelegate = self
        addEventVC.eventStore = eventStore
        
        self.presentViewController(addEventVC, animated: true, completion: nil)
        
    }
    
    @IBAction func findEvent() {
        
        if (date0 != nil && date1 != nil) {
            eventsFound = [EKEvent]()
            var predicate = eventStore.predicateForEventsWithStartDate(date0, endDate: date1, calendars: nil)
            eventsFound = eventStore.eventsMatchingPredicate(predicate) as [EKEvent]
            tableview.reloadData()
        }
    }
    
    func hideKeyboard() {

        initialDate.resignFirstResponder()
        finalDate.resignFirstResponder()
    }
    
    //MARK: - DELEGATES -
    //MARK: UITableView
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsFound.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("myCell") as UITableViewCell
        
        var event: EKEvent = eventsFound[indexPath.row]
        
        cell.textLabel.text = event.title
        cell.detailTextLabel?.text = format.stringFromDate(event.startDate)
        
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true;
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            
            var deleteEvent: EKEvent = eventsFound[indexPath.row]
            eventStore.removeEvent(deleteEvent, span: EKSpanThisEvent, commit: true, error: nil)
            eventsFound.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
        }
    }
    
    //MARK: EKEvent
    
    func eventEditViewController(controller: EKEventEditViewController!, didCompleteWithAction action: EKEventEditViewAction) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    //MARK: UITextField
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        if (textField == initialDate) {
            
            date0 = self.datePicker.date
            initialDate.text = format.stringFromDate(date0)
            
        } else {
            
            date1 = self.datePicker.date
            finalDate.text = format.stringFromDate(date1)
            
        }
        
    }
    
}

