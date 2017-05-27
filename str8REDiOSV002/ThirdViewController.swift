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
    
    @IBAction func goBack(_ sender: Any) {
        webView.goBack()
    }
    @IBAction func goForward(_ sender: Any) {
        webView.goForward()
    }
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
    
    func postToUrl(url: String, data: Data, completion:(@escaping (Data?, URLResponse?, Error?) -> Void)) {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        

    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        if webView.request?.url?.absoluteString == "https://str8red.com/welcome/" {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let deviceToken = appDelegate.deviceTokenToPass
        
            var request = URLRequest(url: URL(string: "https://str8red.com/updateAPNS/")!)
            request.httpMethod = "POST"
            let postString = "devicetoken="+deviceToken!
            request.httpBody = postString.data(using: .utf8)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(String(describing: error))")
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                }
                
                let responseString = String(data: data, encoding: .utf8)
                print("responseString = \(String(describing: responseString))")
            }
            task.resume()
            
        }
        
        
        
        
        // Store
        // defaults.set(349, forKey: "username")

        // self.webView.stringByEvaluatingJavaScript(from: "userID")
        
        // let alertController = UIAlertController(title: "iOScreator", message:
        //    defaults.string(forKey: "username"), preferredStyle: UIAlertControllerStyle.alert)
        // alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        
        // self.present(alertController, animated: true, completion: nil)
        
        // self.webView.stringByEvaluatingJavaScript(from: "myFunction")
        
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}


