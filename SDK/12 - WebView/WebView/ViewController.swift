
import UIKit
import WebKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var bgView: UIView!
    @IBOutlet var urlField: UITextField!
    @IBOutlet var progress: UIProgressView!
    var webview: WKWebView
    
    required init(coder aDecoder: NSCoder) {
        
        self.webview = WKWebView(frame: CGRectZero)
        
        super.init(coder: aDecoder)
        
        self.webview.navigationDelegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        bgView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 30)
        
        view.insertSubview(webview, belowSubview: progress)
        
        //Constraints
        self.webview.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        let widthConstraint = NSLayoutConstraint(item: webview, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1, constant: 0)
        
        view.addConstraint(widthConstraint)
        
        let heightConstraint = NSLayoutConstraint(item: webview, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 1, constant: 0)
        
        view.addConstraint(heightConstraint)
        
        //Progress View - KVO
        webview.addObserver(self, forKeyPath: "loading", options: .New, context: nil)
        webview.addObserver(self, forKeyPath: "estimatedProgress", options: .New, context: nil)
        
        progress.setProgress(0.0, animated: false)
    }
    
    func loadURL(textField: UITextField!) {
        
        if textField.text.rangeOfString("http://") == nil{
            textField.text = "http://" + textField.text
        }
        
        if let url = NSURL(string:textField.text){
            let request = NSURLRequest(URL:url)
            webview.loadRequest(request)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        
        urlField.resignFirstResponder()
        navigationItem.rightBarButtonItem = nil
        bgView.frame = CGRect(x:0, y: 0, width:view.frame.width, height: 30)
        
        loadURL(textField)
        
        return false
    }
    
    func textFieldDidBeginEditing(textField: UITextField!) {
        
        let cancelBt = UIBarButtonItem(title: "Cancelar", style:.Plain, target: self, action: "cancel")
        navigationItem.rightBarButtonItem = cancelBt
    }
    
    func cancel() {
        urlField.resignFirstResponder()
        navigationItem.rightBarButtonItem = nil
        bgView.frame = CGRect(x:0, y: 0, width:view.frame.width, height: 30)
    }
    
    
    @IBAction func goBack(sender: UIBarButtonItem) {
            webview.goBack()
    }
    
    @IBAction func goForward(sender: UIBarButtonItem) {
            webview.goForward()
    }
    
    @IBAction func stopReload(sender: UIBarButtonItem) {
            webview.stopLoading()
    }
    
    @IBAction func reload(sender: UIBarButtonItem) {
            webview.reload()
    }

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        bgView.frame = CGRect(x:0, y: 0, width: size.width, height: 30)
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {

        if (keyPath == "loading") {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = webview.loading

        } else if (keyPath == "estimatedProgress") {

            progress.hidden = webview.estimatedProgress == 1
            progress.setProgress(Float(webview.estimatedProgress), animated: true)
        }
    }
}

extension ViewController: WKNavigationDelegate{
    
    func webView(webView: WKWebView!, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError!) {
        
        let alert = UIAlertController(title: "Ops!", message: error.localizedDescription, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func webView(webView: WKWebView!, didFinishNavigation navigation: WKNavigation!) {
        
        progress.setProgress(0.0, animated: false)
        urlField.text = webview.URL?.absoluteString
    }
}



