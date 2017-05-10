//
//  Third       ViewController.swift
//  str8REDiOSV002
//
//  Created by Alan Tingey on 09/12/2016.
//  Copyright © 2016 Alan Tingey. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        webView.reload()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let str8REDURL = URL(string: "https://str8red.com/")
        let str8REDURLRequest = URLRequest(url: str8REDURL!)
        webView.loadRequest(str8REDURLRequest)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let str8REDURL = URL(string: "https://str8red.com/")
        let str8REDURLRequest = URLRequest(url: str8REDURL!)
        webView.loadRequest(str8REDURLRequest)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

