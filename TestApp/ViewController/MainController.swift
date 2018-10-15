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
    
    @IBOutlet weak var tableView: UITableView!
    
    var requestUser = VKRequest.init(method: App.Methods.usersGet,
                                     parameters: [
        VK_API_FIELDS: App.String.fields,
        VK_API_USER_IDS: App.Int.userId,
        VK_API_ACCESS_TOKEN: App.String.acccethToken])
    
    var requestFriends = VKRequest.init(method: App.Methods.friendsGet,
                                        parameters: [
        VK_API_USER_ID : App.Int.userId,
        VK_API_COUNT : App.Int.countPerPage,
        VK_API_FIELDS: App.String.fields,
        VK_API_ACCESS_TOKEN: App.String.acccethToken])

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(logOut))
        
        let instance = VKSdk.initialize(withAppId: App.String.VKAppId)
        instance?.register(self)
        instance?.uiDelegate = self

        requestUser?.execute(resultBlock: { (response) in
                        
            let stringJson = response?.responseString.data(using: .utf8)
            
            let decoder = JSONDecoder()
            do {
                let product = try decoder.decode(Users.self, from: stringJson!)
                print(product)
            }
            catch {
                print("error decode: \(error)")
            }
            
        }, errorBlock: { (error) in
            print(error.debugDescription)
        })
     
        requestFriends?.execute(resultBlock: { (response) in
            
            let stringJson = response?.responseString.data(using: .utf8)
            
            let decoder = JSONDecoder()
            do {
                let product = try decoder.decode(ResponseMessages.self, from: stringJson!)
                print(product)
            }
            catch {
                print("error decode: \(error)")
            }
            
        }, errorBlock: { (error) in
            print(error.debugDescription)
        })

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

    }
    
    @objc func logOut() {
        print("logged out")
        
        defaults.set(false, forKey: "UserIsLoggedIn")
        
        VKSdk.forceLogout()
        
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

extension MainController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
    
}
