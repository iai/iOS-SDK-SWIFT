

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!

    	var datePicker: UIDatePicker!
    var toolBar: UIToolbar!
    var okBt: UIBarButtonItem!

    @IBOutlet weak var tf1: UITextField!
    @IBOutlet weak var tf2: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Date Picker
        datePicker = UIDatePicker(frame: CGRect(x: 0.0, y: 0.0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        
//        textField.inputView = datePicker
        
        //Toolbar
        toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: self.view.bounds.size.width, height: 44))

        var cancelBt = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action:"hideKeyboard")

        okBt = UIBarButtonItem(title: "OK", style: UIBarButtonItemStyle.Plain, target: self, action:"hideKeyboard")
        
        var flexSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        
        toolBar.items = [cancelBt, flexSpace, okBt]
        
        textField.inputAccessoryView = toolBar
        tf1.inputAccessoryView = toolBar
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hideKeyboard() {
        
//        textField.resignFirstResponder()
        
        self.view.endEditing(true)
        
        let formatador = NSDateFormatter()
        formatador.dateFormat = "dd/MM/yyyy - hh:mm a"
        textField.text = formatador.stringFromDate(datePicker.date)
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField == tf1 {
            tf2.becomeFirstResponder()
        }
        if textField == tf2 {
            textField.resignFirstResponder()
        }
        
        return true
    }

}

