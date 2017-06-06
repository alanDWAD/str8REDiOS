//
//  str8REDVC.swift
//  str8REDiOSV002
//
//  Copyright © 2017 Be The Rules. All rights reserved.
//  Powered by kOS
//

import UIKit

class str8REDVC: UIViewController,UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    
    var navTitle:String!  // What does this do? no other references to it in class?
    
    @IBAction func goBack(_ sender: Any) {
        webView.goBack()
    }
    @IBAction func goForward(_ sender: Any) {
        webView.goForward()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
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

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let deviceToken = appDelegate.deviceTokenToPass
        
        if webView.request?.url?.absoluteString == "https://str8red.com/welcome/" && deviceToken != nil {
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
        
        
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}


