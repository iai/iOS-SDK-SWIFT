//
//  ViewController.swift
//  ParseXML
//
//  Created by Lucas Longo on 8/18/15.
//  Copyright (c) 2015 iai. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NSXMLParserDelegate, UITableViewDataSource {
    
    var catalogArray = NSMutableArray()
    var cdDict = NSMutableDictionary()
    var valueString = String()
    
    @IBOutlet weak var cdTableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pegarDados()
    }
    
    func pegarDados() {
        if let dataURL = NSURL(string: "http://iai.art.br/escola/cdcatalog.xml") {
            
            spinner.startAnimating()
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), { () -> Void in
            
                if let parser = NSXMLParser(contentsOfURL: dataURL) {
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        
                        parser.delegate = self
                        parser.parse()
                        
                    })
                }
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: NSXMLParserDelegate
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        
        switch elementName {
        case "CATALOG":
            println("Iniciando o parse")
            break
            case "CD":
            cdDict = NSMutableDictionary()
            break
        default:
            valueString = String()
            break
            
        }
    }
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
        
        if let s = string {
            valueString += s
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        switch elementName {
        case "CATALOG":
            println(catalogArray.description)
            cdTableView.reloadData()
            break
        case "CD":
            let cd = CD(dict: cdDict)
            catalogArray.addObject(cd)
            break
        default:
            cdDict[elementName] = valueString
            break
        }
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catalogArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cdCell") as! CdTableViewCell
        
        let cd = catalogArray[indexPath.row] as! CD
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

class CD {
    
    var artist: String, company: String, country: String, price: String, title: String, year: String
    
    init(dict: NSDictionary){
        
        self.artist = dict["ARTIST"] as! String
        self.company = dict["COMPANY"] as! String
        self.country = dict["COUNTRY"] as! String
        self.price = dict["PRICE"] as! String
        self.title = dict["TITLE"] as! String
        self.year = dict["YEAR"] as! String
        
    }
}

