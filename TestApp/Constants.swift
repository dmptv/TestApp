//
//  Constants.swift
//  TestApp
//
//  Created by 123 on 14.10.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import Foundation


//"https://api.vk.com/method/friends.get?user_id=26955116&order=name&count=100&v=5.52"

// https://api.vk.com/method/users.get?user_id=210700286&v=5.52

struct App {
    
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
    }
    
    struct Int {
        static let userId = 26955116
    }
    
    // MARK: - Environment
    
    enum Environment {
        case development
        case production
        
        static var current: Environment {
            return .development // .production
        }
    }
    
}
