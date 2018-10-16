//
//  AppDelegate.swift
//  TestApp
//
//  Created by 123 on 12.10.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit
import UserNotifications
import VK_ios_sdk

protocol DataManagerProtocol {
    var defaults: UserDefaults! { get }
}

extension DataManagerProtocol {
    var defaults: UserDefaults! {
        return (UIApplication.shared.delegate as? AppDelegate)?.defaults
    }

}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
        
    lazy var defaults = UserDefaults.standard
    var userIsLoggedIn: Bool?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
   
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        customizeAppearance()
        
        let loginStoryboard = UIStoryboard.storyboard(.login)
        let loginController: LoginController = loginStoryboard.instantiateViewController()
        
        let mainStoryboard = UIStoryboard.storyboard(.main)
        let mainController: MainController = mainStoryboard.instantiateViewController()
        let mainNavController = UINavigationController(rootViewController: mainController)
        
        userIsLoggedIn = defaults.bool(forKey: "UserIsLoggedIn")
        
        if userIsLoggedIn == true {
            window?.rootViewController = mainNavController
        } else {
            window?.rootViewController = loginController
        }

        return true
    }
    
    // MARK - App Theme Customization
    
    private func customizeAppearance() {
        window?.tintColor = UIColor.black
        UISearchBar.appearance().barTintColor = UIColor.black
        UINavigationBar.appearance().barTintColor = UIColor.black
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : UIColor.white]
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let ret: Bool = VKSdk.processOpen(url, fromApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String)
        print(ret)
        
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert)
    }

    func applicationWillResignActive(_ application: UIApplication) {
       
    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {
      
    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {
      
    }


}

