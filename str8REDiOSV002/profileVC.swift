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

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        profileWebView.delegate = self
        
        let defaults = UserDefaults.standard

        if defaults.string(forKey: "loggedIn") == "True" {
            self.profileLbl.isHidden = true
            self.str8REDimg.isHidden = true
            self.profileWebView.isHidden = false

        }
        else {
            self.profileLbl.isHidden = false
            self.str8REDimg.isHidden = false
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
            self.profileWebView.isHidden = false
            
        }
        else {
            self.profileLbl.isHidden = false
            self.str8REDimg.isHidden = false
            self.profileWebView.isHidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
