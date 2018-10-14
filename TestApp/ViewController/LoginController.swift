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
    
    private let vkPerm = [VK_PER_FRIENDS, VK_PER_PHOTOS]
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow

        let instance = VKSdk.initialize(withAppId: AppDelegate.VKAppId)
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
                DispatchQueue.main.async {
                    sender.isHidden = true
                }
            }
        })
        
    }
    
}

extension LoginController: VKSdkDelegate, VKSdkUIDelegate {
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print("vkSdk Access Authorization Finished")
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
