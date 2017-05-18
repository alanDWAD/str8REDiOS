//
//  SecondViewController.swift
//  str8REDiOSV002
//
//  Created by Alan Tingey on 09/12/2016.
//  Copyright © 2017 Alan Tingey. All rights reserved.
//  Powered by kOS
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.reload()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        let str8REDURL = URL(string: "https://str8red.com/leaderboard/")
        let str8REDURLRequest = URLRequest(url: str8REDURL!)
        webView.loadRequest(str8REDURLRequest)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Do we need this duplicate code? My assumption would be that the viewDidLoad func would suffice - GH
        
        let str8REDURL = URL(string: "https://str8red.com/leaderboard/")
        let str8REDURLRequest = URLRequest(url: str8REDURL!)
        webView.loadRequest(str8REDURLRequest)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

