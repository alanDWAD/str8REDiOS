//
//  SecondViewController.swift
//  str8REDiOSV002
//
//  Created by Alan Tingey on 09/12/2016.
//  Copyright © 2017 Alan Tingey. All rights reserved.
//  Powered by kOS still
//

import UIKit

class SecondViewController: UIViewController,UIWebViewDelegate {
    
    var navTitle:String!
    var teamSelectNotif = false
    var kickoffNotif = false
    var resultsNotif = false
    var kOSNews = false
    
    @IBAction func `switch`(_ sender: UISwitch) {
        
        if sender.isOn == true {
            switch sender.tag {
            case 1:
                teamSelectNotif = true
            case 2:
                kickoffNotif = true
            case 3:
                resultsNotif = true
            case 4:
                kOSNews = true
            default:
                break
            }}
            else if sender.isOn == false {
                switch sender.tag {
                case 1:
                    teamSelectNotif = false
                case 2:
                    kickoffNotif = false
                case 3:
                    resultsNotif = false
                case 4:
                    kOSNews = false
                default:
                    break
            }}
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        var request = URLRequest(url: URL(string: "https://str8red.com/iostoggles/")!)
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
            print("responseString = \(String(describing: responseString))")
            
            if responseString == "True" {
                print("logged in")
            }
                
            else{
                print("not logged in")
            }
            
        }
        task.resume()
        
    }
    
}
