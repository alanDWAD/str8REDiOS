//
//  SecondViewController.swift
//  str8REDiOSV002
//
//  Created by Alan Tingey on 09/12/2016.
//  Copyright © 2017 Alan Tingey. All rights reserved.
//  Powered by kOS still
//

import UIKit
import Foundation

class SecondViewController: UIViewController,UIWebViewDelegate {
    

    var navTitle:String!
    var teamSelectNotif = false
    var resultsNotif = false
    
    func toggleUpdate(toggle: String, setting: Int) -> String {
        var request = URLRequest(url: URL(string: "https://str8red.com/toggles/")!)
        request.httpMethod = "POST"
        let postString = toggle + "=" + String(setting)
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
        }
        task.resume()
        let settings = "Setting Updated"
        return settings
    }
    
    @IBAction func `switch`(_ sender: UISwitch) {
        
        if sender.isOn == true {
            switch sender.tag {
            case 1:
                teamSelectNotif = true
                print(toggleUpdate(toggle: "str8redpickteamreminder", setting: 1))
            case 3:
                resultsNotif = true
                print(toggleUpdate(toggle: "str8redresults", setting: 1))
            default:
                break
                

                
            }}
            else if sender.isOn == false {
                switch sender.tag {
                case 1:
                    teamSelectNotif = false
                    print(toggleUpdate(toggle: "str8redpickteamreminder", setting: 0))
                case 3:
                    resultsNotif = false
                    print(toggleUpdate(toggle: "str8redresults", setting: 0))
                default:
                    break
            }}
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.teamSelectNotif = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
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
            print("responseString = \(String(describing: responseString))")
            
            let signinvars = responseString?.components(separatedBy: " ")
            let loggedin = signinvars?[0]
            let str8redpickteamreminder: Int = Int((signinvars?[1])!)!
            let str8redresults: Int = Int((signinvars?[2])!)!
            
            if loggedin == "True" {
                print(loggedin! + String(str8redpickteamreminder) + String(str8redresults))
            }
                
            else{
                print("not logged in")
            }
            
        }
        task.resume()
        
    }
    
}
