//
//  SettingsVC.swift
//  str8REDiOSV002
//
//  Copyright © 2017 Be The Rules. All rights reserved.
//  
//

import UIKit
import Foundation

class SettingsVC: UIViewController,UIWebViewDelegate {

// Class Variables
    var navTitle:String!
    var teamSelectNotif = false
    var resultsNotif = false
    
// UI Outlets
    @IBOutlet weak var teamsSelectedSwitch: UISwitch!
    @IBOutlet weak var resultsSwitch: UISwitch!
    @IBOutlet weak var teamsSelectedLabel: UILabel!
    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var settingsText: UILabel!

    

// Class Functions
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
    
 // UI Actions
    @IBAction func `switch`(_ sender: UISwitch) {
        
        let defaults = UserDefaults.standard
        
        if sender.isOn == true {
            switch sender.tag {
            case 1:
                teamSelectNotif = true
                defaults.set("True", forKey: "str8redpickteamreminder")
                print(toggleUpdate(toggle: "str8redpickteamreminder", setting: 1))
            case 2:
                resultsNotif = true
                defaults.set("True", forKey: "str8redresults")
                print(toggleUpdate(toggle: "str8redresults", setting: 1))
            default:
                break
            }
        }
            else if sender.isOn == false {
                switch sender.tag {
                case 1:
                    teamSelectNotif = false
                    defaults.set("False", forKey: "str8redpickteamreminder")
                    print(toggleUpdate(toggle: "str8redpickteamreminder", setting: 0))
                case 2:
                    resultsNotif = false
                    defaults.set("False", forKey: "str8redresults")
                    print(toggleUpdate(toggle: "str8redresults", setting: 0))
                default:
                    break
                }
            }
        }
    
// Superclass Function Overides

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
//        print(defaults.string(forKey: "loggedIn"))
//        print(defaults.string(forKey: "str8redpickteamreminder"))
//        print(defaults.string(forKey: "str8redresults"))
        
        if defaults.string(forKey: "loggedIn") == "True" {
            self.settingsText.text = "Allow Notifications for:"
            self.teamsSelectedSwitch.isHidden = false
            self.teamsSelectedLabel.isHidden = false
            self.resultsSwitch.isHidden = false
            self.resultsLabel.isHidden = false
            //print(loggedIn! + String(str8redpickteamreminder!) + String(str8redresults!))
        }
            
        else {
            self.settingsText.text = "Please sign in to change settings."
            self.teamsSelectedSwitch.isHidden = true
            self.teamsSelectedLabel.isHidden = true
            self.resultsSwitch.isHidden = true
            self.resultsLabel.isHidden = true
            print("not logged in")
        }
        
        if defaults.string(forKey: "str8redpickteamreminder") == "True" {
            self.teamsSelectedSwitch.isOn = true
        }
        else {
            self.teamsSelectedSwitch.isOn = false
        }
        if defaults.string(forKey: "str8redresults") == "True" {
            self.resultsSwitch.isOn = true
        }
        else {
            self.resultsSwitch.isOn = false
        }
        
        
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
    
    let defaults = UserDefaults.standard
//    print(defaults.string(forKey: "loggedIn"))
//    print(defaults.string(forKey: "str8redpickteamreminder"))
//    print(defaults.string(forKey: "str8redresults"))
    
    if defaults.string(forKey: "loggedIn") == "True" {
    self.settingsText.text = "Allow Notifications for:"
    self.teamsSelectedSwitch.isHidden = false
    self.teamsSelectedLabel.isHidden = false
    self.resultsSwitch.isHidden = false
    self.resultsLabel.isHidden = false
    //print(loggedIn! + String(str8redpickteamreminder!) + String(str8redresults!))
    }
    
    else {
    self.settingsText.text = "Please sign in to change settings."
    self.teamsSelectedSwitch.isHidden = true
    self.teamsSelectedLabel.isHidden = true
    self.resultsSwitch.isHidden = true
    self.resultsLabel.isHidden = true
    print("not logged in")
    }
    
    if defaults.string(forKey: "str8redpickteamreminder") == "True" {
    self.teamsSelectedSwitch.isOn = true
    }
    else {
    self.teamsSelectedSwitch.isOn = false
    }
    if defaults.string(forKey: "str8redresults") == "True" {
    self.resultsSwitch.isOn = true
    }
    else {
    self.resultsSwitch.isOn = false
    }
    
    

    }
}

