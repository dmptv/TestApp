//
//  Constants.swift
//  TestApp
//
//  Created by 123 on 14.10.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import Foundation


struct App {
    
    // MARK: - Strings
    
    struct String {
        private static let devBaseUrl = "https://api.vk.com/method/"
        private static let prodBaseUrl = "https://api.vk.com/method/"
        
        static var baseUrl: Swift.String {
            return Environment.current == .production ? prodBaseUrl : devBaseUrl
        }
        
        static var apiBaseUrl: Swift.String {
            return baseUrl 
        }
        
        static let acccethToken = "8945af0b8945af0b8945af0b3589232ab5889458945af0bd285dbe0506e95fcd2c1e94e"
        
        static let fields = "first_name, last_name, uid, photo_100"
        
        static let VKAppId = "6718910"

    }
    
    // MARK: - Integers
    
    struct Int {
        static let userId = 20375184
        static let countPerPage = 50

    }
    
    // MARK: - Environment
    
    enum Environment {
        case development
        case production
        
        static var current: Environment {
            return .development
        }
    }
    
    // MARK: - Methods
    
    struct Methods {
        static let friendsGet = "friends.get"
        static let usersGet = "users.get"
    }
   
    
}
