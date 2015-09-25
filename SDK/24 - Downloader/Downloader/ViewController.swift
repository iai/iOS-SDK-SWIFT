//
//  ViewController.swift
//  Downloader
//
//  Created by Lucas Longo on 8/20/15.
//  Copyright (c) 2015 iai. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NSURLConnectionDataDelegate {

    var receivedData : NSMutableData!
    var expectedLength : Int64!
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var downloadedImageView: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    let urlString =  "http://davelarsonstudio.com/wordpress-DLStudio/wp-content/uploads/2013/02/Big-Bend-Fort-Davis-61.jpg"

    @IBAction func iniciarDownload(sender: AnyObject) {
        
        getImageWithURLString(urlString)
        
//        if let url = NSURL(string: "http://davelarsonstudio.com/wordpress-DLStudio/wp-content/uploads/2013/02/Big-Bend-Fort-Davis-61.jpg") {
//            let request = NSURLRequest(URL: url)
//            NSURLConnection(request: request, delegate: self, startImmediately: true)
//            spinner.startAnimating()
//        }
    }
    
    func getImageWithURLString(urlString: String)  {
        
        let imageName = urlString.lastPathComponent
        let path = NSHomeDirectory().stringByAppendingString("/Documents/\(imageName)")
        
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let image = UIImage(contentsOfFile: path) {
                downloadedImageView.image = image
            }
        }
        else {
            if let url = NSURL(string: urlString) {
                let request = NSURLRequest(URL: url)
                NSURLConnection(request: request, delegate: self, startImmediately: true)
                spinner.startAnimating()
            }
        }
    }
    
    // MARK: NSURLConnectionDataDelegate
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        statusLabel.text = "Erro ao criar a conexão \(error.description)"
        spinner.stopAnimating()
    }

    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {

        receivedData = NSMutableData()
        expectedLength = response.expectedContentLength
        let size = NSString(format: "%.2f", CGFloat(expectedLength)/1000000)
        statusLabel.text = "Tamanho estimado \(size)Mb"
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        
        receivedData?.appendData(data)
        let progress = Float(receivedData.length) / Float(expectedLength)
        progressView.progress = progress
        let progressPercentage = NSString(format: "%.2f %%", progress * 100)
        let progressSize = NSString(format: "%.2f/%.2f Mb", CGFloat(receivedData.length)/1000000, CGFloat(expectedLength)/1000000)
        statusLabel.text = NSString(format: "%@ (%@)", progressSize, progressPercentage) as String
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        if let image = UIImage(data: receivedData) {
            downloadedImageView.image = image
        }
        spinner.stopAnimating()
        progressView.setProgress(0, animated: true)

        if let url = connection.originalRequest.URL?.absoluteString {
            statusLabel.text = url
            
            let imageName = url.lastPathComponent
            let path = NSHomeDirectory().stringByAppendingString("/Documents/\(imageName)")
            receivedData.writeToFile(path, atomically: true)
        }
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}



