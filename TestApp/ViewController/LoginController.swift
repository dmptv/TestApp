//
//  ViewController.swift
//  TestApp
//
//  Created by 123 on 12.10.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit
import VK_ios_sdk

class LoginController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    
    private let vkPerm = [VK_PER_FRIENDS, VK_PER_PHOTOS]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let instance = VKSdk.initialize(withAppId: App.String.VKAppId)
        instance?.register(self)
        instance?.uiDelegate = self
    }
    
    @IBAction func Login(_ sender: UIButton) {
        VKSdk.wakeUpSession(vkPerm, complete: { (state, error) in
            if (state ==  VKAuthorizationState.authorized) {
                print("wakeUpSession")
                
                self.defaults.set(true, forKey: "UserIsLoggedIn")
                
                let mainStoryboard = UIStoryboard.storyboard(.main)
                let mainController: MainController = mainStoryboard.instantiateViewController()
                let mainNavController = UINavigationController(rootViewController: mainController)

                self.present(mainNavController, animated: true, completion: nil)

            } else {
                VKSdk.authorize(self.vkPerm, with: .disableSafariController)
            }
        })
        
    }
    
}

extension LoginController: VKSdkDelegate, VKSdkUIDelegate {
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print("vkSdk Access Authorization Finished")
        if result.token != nil {
            loginButton.setTitle("Enter", for: .normal)
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        print("vkSdk User Authorization Failed")
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print("vkSdk Should Present")
        self.present(controller, animated: true, completion: nil)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print("vkSdk Need Captcha Enter", captchaError)
    }
    
    func vkSdkReceivedNewToken(newToken: VKAccessToken) {
        print("--> vkSdk Received New Token", newToken)
    }

}
