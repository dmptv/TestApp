//
//  Users.swift
//  TestApp
//
//  Created by 123 on 15.10.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import Foundation

struct Users: Codable {
    var response: [Friend?]
    
    private static var _current: Friend?
    static var current: Friend {
        
        get {
            if _current != nil {
                return _current!
            }
            
            /*
             let token = UserDefaults.standard.string(forKey: App.Key.userToken)
             let login = UserDefaults.standard.string(forKey: App.Key.userLogin) ?? ""
             let employeeCode = UserDefaults.standard.string(forKey: App.Key.userEmployeeCode) ?? ""
             
             var roles = [Role]()
             if let strRoles = UserDefaults.standard.object(forKey: App.Key.userRoles) as? [String] {
             roles = strRoles.compactMap { Role(rawValue: $0) }
             }
             
             _current = User(token: token, login: login, employeeCode: employeeCode, roles: roles)
             
             if let profileData = UserDefaults.standard.data(forKey: App.Key.userProfile),
             let profile = try? PropertyListDecoder().decode(UserProfile.self, from: profileData) {
             _current?.profile = profile
             _current?.updated.accept(profile)
             }
             */
            
            return _current!
        }
        
        set(newValue) {
            _current = newValue
        }
    
    }
}
