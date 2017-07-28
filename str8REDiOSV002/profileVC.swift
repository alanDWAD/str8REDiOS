//
//  profileVC.swift
//  str8REDiOSV002
//
//  Created by Alan Tingey on 16/07/2017.
//  Copyright © 2017 Alan Tingey. All rights reserved.
//

import UIKit

class profileVC: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var profileWebView: UIWebView!
    @IBOutlet weak var profileLbl: UILabel!
    @IBOutlet weak var str8REDimg: UIImageView!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var backgroundImg: UIImageView!
    
    @IBAction func back(_ sender: Any) {
        profileWebView.goBack()
    }
    
    @IBAction func forward(_ sender: Any) {
        profileWebView.goForward()
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        profileWebView.delegate = self
        
        let defaults = UserDefaults.standard

        if defaults.string(forKey: "loggedIn") == "True" {
            self.profileLbl.isHidden = true
            self.str8REDimg.isHidden = true
            self.backgroundImg.isHidden = true
            self.profileWebView.isHidden = false

        }
        else {
            self.profileLbl.isHidden = false
            self.str8REDimg.isHidden = false
            self.backgroundImg.isHidden = false
            self.profileWebView.isHidden = true
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let defaults : UserDefaults = UserDefaults.standard
        
        let str8REDURL = URL(string: "https://str8red.com/profileiOS")
        
        let str8REDURLRequest = URLRequest(url: str8REDURL!)
        
        profileWebView.loadRequest(str8REDURLRequest)
        
        if defaults.string(forKey: "loggedIn") == "True" {
            self.profileLbl.isHidden = true
            self.str8REDimg.isHidden = true
            self.backgroundImg.isHidden = true
            self.profileWebView.isHidden = false
            
        }
        else {
            self.profileLbl.isHidden = false
            self.str8REDimg.isHidden = false
            self.backgroundImg.isHidden = false
            self.profileWebView.isHidden = true
        }
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        if profileWebView.request?.url?.absoluteString == "https://str8red.com/welcomeiOS/" {
            let defaults : UserDefaults = UserDefaults.standard
            var request = URLRequest(url: URL(string: "https://str8red.com/loggedincheck/")!)
            request.httpMethod = "GET"
            let postString = ""
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
                print("now logged in responseString = \(String(describing: responseString))")
                let signinvars = responseString?.components(separatedBy: " ")
                defaults.set(signinvars?[0], forKey: "loggedIn")
                defaults.set(signinvars?[1], forKey: "str8redpickteamreminder")
                defaults.set(signinvars?[2], forKey: "str8redresults")
            }
            task.resume()
            self.profileWebView.isHidden = true
            self.backgroundImg.isHidden = false
            self.profileLbl.isHidden = false
            self.str8REDimg.isHidden = false
            
            print("Alan is Gay")
        
        }
        
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
