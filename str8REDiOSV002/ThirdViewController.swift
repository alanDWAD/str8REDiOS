//
//  ThirdViewController.swift
//  str8REDiOSV002
//
//  Created by Alan Tingey on 09/12/2016.
//  Copyright © 2017 Alan Tingey. All rights reserved.
//  Powered by kOS still
//

import UIKit

class ThirdViewController: UIViewController,UIWebViewDelegate {
    
    
    @IBOutlet weak var webView: UIWebView!
    
    var navTitle:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.delegate = self
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        let str8REDURL = URL(string: "https://str8red.com/")
        let str8REDURLRequest = URLRequest(url: str8REDURL!)
        self.webView.loadRequest(str8REDURLRequest)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Do we need this duplicate code? My assumption would be that the viewDidLoad func would suffice - GH
        
        let str8REDURL = URL(string: "https://str8red.com/")
        let str8REDURLRequest = URLRequest(url: str8REDURL!)
        webView.loadRequest(str8REDURLRequest)
        
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        let loggedIn = self.webView.stringByEvaluatingJavaScript(from: "loggedIn");
        
        let alertController = UIAlertController(title: "iOScreator", message:
            loggedIn, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}


