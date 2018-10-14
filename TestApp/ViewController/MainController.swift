//
//  MainController.swift
//  TestApp
//
//  Created by 123 on 12.10.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit
import VK_ios_sdk


class MainController: UIViewController {
    
    typealias JSONDictionary = [String: Any]
    
    let defaults = UserDefaults.standard
    
    var requestFriends = VKRequest.init(method: "friends.get", parameters: [
        VK_API_USER_ID : App.Int.userId,
        VK_API_COUNT : 50,
        VK_API_ACCESS_TOKEN: App.String.acccethToken])

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(logOut))
        
        let instance = VKSdk.initialize(withAppId: AppDelegate.VKAppId)
        instance?.register(self)
        instance?.uiDelegate = self
        
        requestFriends?.execute(resultBlock: { (response) in
            
            print("friends", response?.responseString)
            
        }, errorBlock: { (Error) in
            print(Error.debugDescription)
        })

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

    }
    
    @objc func logOut() {
        print("logged out")
        
        defaults.set(false, forKey: "UserIsLoggedIn")
        
        let loginStoryboard = UIStoryboard.storyboard(.login)
        let loginController: LoginController = loginStoryboard.instantiateViewController()
        
        present(loginController, animated: true, completion: nil)
    }

}

extension MainController: VKSdkDelegate, VKSdkUIDelegate {
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print("vkSdkShould Present")
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print("vkSdkAccessAuthorization Finished")
    }
    
    func vkSdkUserAuthorizationFailed() {
        print("vkSdkUserAuthorization Failed")
    }
    
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print("captcha Error", captchaError)
    }
    
    
}
