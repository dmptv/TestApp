//
//  Friend.swift
//  TestApp
//
//  Created by 123 on 14.10.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import Foundation

//{\"response\" :
//                 [
//                  {\"id\":20375184,\"first_name\":\"Anastasia\",\"last_name\":\"Bryzgalova\",\"photo_100\":\"https:\\/\\/pp.userapi.com\\/c836331\\/v836331184\\/30f6e\\/v_goYsE30fo.jpg?ava=1\"}
//                 ]
//}

//struct ResponseUsers: Codable {
//    var response: Users?
//}

struct Users: Codable {
    var response: [Friend?]
}

struct ResponseMessages: Codable {
    var response: Friends?
}

struct Friends: Codable {
    var count: Int?
    var items: [Friend?]
}

struct Friend {
    var id: Int
    var firstName: String
    var lastName: String
    var photo100: String
   
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo100 = "photo_100"
    }
}

extension Friend: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(photo100, forKey: .photo100)
    }
}

extension Friend: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        lastName = try values.decode(String.self, forKey: .lastName)
        firstName = try values.decode(String.self, forKey: .firstName)
        photo100 = try values.decode(String.self, forKey: .photo100)
    }
}
