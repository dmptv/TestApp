//
//  NetworkManager.swift
//  TestApp
//
//  Created by 123 on 14.10.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import Foundation
import VK_ios_sdk

class Service {

    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
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
    
    func getData(completion: @escaping (Friend?) -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            var user: Friend?
 
            self.requestUser?.execute(resultBlock: { (response) in
                
                let stringJson = response?.responseString.data(using: .utf8)
                
                let decoder = JSONDecoder()
                do {
                    let users = try decoder.decode(Users.self, from: stringJson!)
                    user = users.response[0]
                    completion(user)
                }
                catch {
                    print("error decode: \(error)")
                }
                
            }, errorBlock: { (error) in
                print(error.debugDescription)
            })
        }
    }
    
    func getFriends(completion: @escaping ([Friend?]) -> ()) {
        
        requestFriends?.execute(resultBlock: { (response) in
            
            let stringJson = response?.responseString.data(using: .utf8)
            
            let decoder = JSONDecoder()
            do {
                let responseMessage = try decoder.decode(ResponseMessages.self, from: stringJson!)
                if let itemsResponse = responseMessage.response {
                    completion(itemsResponse.items)
                }
            }
            catch {
                print("error decode: \(error)")
            }
            
        }, errorBlock: { (error) in
            print(error.debugDescription)
        })
    }
    
}



























