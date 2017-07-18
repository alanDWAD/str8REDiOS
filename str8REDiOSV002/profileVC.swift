//
//  profileVC.swift
//  str8REDiOSV002
//
//  Created by Alan Tingey on 16/07/2017.
//  Copyright © 2017 Alan Tingey. All rights reserved.
//

import UIKit

class profileVC: UIViewController,UIWebViewDelegate {

    @IBOutlet weak var profileWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileWebView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let defaults : UserDefaults = UserDefaults.standard
        
        let str8REDURL = URL(string: "https://str8red.com/profileiOS")
        let str8REDURLRequest = URLRequest(url: str8REDURL!)
            profileWebView.loadRequest(str8REDURLRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
