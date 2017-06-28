//
//  AppDelegate.swift
//  str8REDiOS
//
//  Copyright © 2017 Be The Rules. All rights reserved.
//  
//

import UIKit
import UserNotifications

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        if #available(iOS 10, *) {
            UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
            application.registerForRemoteNotifications()
            //print("TEST12")
        }
        else {
            application.registerForRemoteNotifications(matching: [.badge, .sound, .alert])
        }
        
        //sleep(1)
        
        let defaults : UserDefaults = UserDefaults.standard
        defaults.set(false, forKey: "loginbutton")
        
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
            defaults.set(signinvars?[0], forKey: "loggedIn")
            defaults.set(signinvars?[1], forKey: "str8redpickteamreminder")
            defaults.set(signinvars?[2], forKey: "str8redresults")
        }
        
        task.resume()
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    internal var deviceTokenToPass: String?
    
    // Called when APNs has assigned the device a unique token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Convert token to string
        
       self.deviceTokenToPass = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        
        // Print it to console
        // print("APNs device token:"+deviceTokenToPass!)
        // Persist it in your backend in case it's new
    }
    
    // Called when APNs failed to register the device for push notifications
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // Print the error to console (you should alert the user that registration failed)
        print("APNs registration failed: \(error)")
    }
    
    // Push notification received
    func application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable : Any]) {
        // Print notification payload data
        print("Push notification received: \(data)")
    }


}


