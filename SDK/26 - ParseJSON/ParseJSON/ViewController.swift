//
//  ViewController.swift
//  ParseJSON
//
//  Created by Lucas Longo on 8/18/15.
//  Copyright (c) 2015 iai. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    var catalog = NSMutableArray()
    var cdDict = NSMutableDictionary()
    var valueString = String()
    
    @IBOutlet weak var cdTableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pegarDados()
    }
    
    func pegarDados() {
        if let dataURL = NSURL(string: "http://iai.art.br/escola/cdcatalog.json") {
            spinner.startAnimating()
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), { () -> Void in
                if let data = NSData(contentsOfURL: dataURL) {
                    if let jsonDict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary {
                        if let array = jsonDict["CATALOG"] as? NSArray {
                            for dict in array {
                                if let cdDict = dict as? NSDictionary {
                                    let cd = CD(dict: cdDict)
                                    self.catalog.addObject(cd)
                                }
                            }
                        }
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.cdTableView.reloadData()
                        })
                    }
                }
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catalog.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cdCell") as! CdTableViewCell
        
        let cd = catalog[indexPath.row] as! CD
        cell.updateInterfaceWith(cd)
        
        return cell
        
    }
    
}

class CdTableViewCell : UITableViewCell {
    
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func updateInterfaceWith(cd: CD) {
        artistLabel.text = cd.artist
        titleLabel.text = cd.title
        companyLabel.text = cd.company
        countryLabel.text = cd.country
        yearLabel.text = cd.year
        priceLabel.text = "$ \(cd.price)"
    }
}

class CD : NSObject {
    
    var artist: String
    var company: String
    var country: String
    var price: String
    var title: String
    var year: String
    
    init(dict: NSDictionary){
        
        self.artist = dict["ARTIST"] as! String
        self.company = dict["COMPANY"] as! String
        self.country = dict["COUNTRY"] as! String
        self.price = dict["PRICE"] as! String
        self.title = dict["TITLE"] as! String
        self.year = dict["YEAR"] as! String
        
    }
    
    override var description : String {
        return "\(title) by \(artist)"
    }
}

