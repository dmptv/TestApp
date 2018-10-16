//
//  Friend.swift
//  TestApp
//
//  Created by 123 on 14.10.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit

protocol FriendWithCustomImageProtocol {
    var customImage: UIImage? { get set }
    var id: Int { get set }
    var firstName: String { get set }
    var lastName: String { get set }
    var photo100: String { get set }
    var photo200: String { get set }
    
    var photoUrl: URL { get }
    var photo200Url: URL { get }
}

extension FriendWithCustomImageProtocol {
    var customImage: UIImage? {
        get {
            return customImage
        }
        set (newImage) {
            customImage = newImage
        }
    }
}

struct Friend: FriendWithCustomImageProtocol {
    var id: Int
    var firstName: String
    var lastName: String
    var photo100: String
    var photo200: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo100 = "photo_100"
        case photo200 = "photo_200_orig"
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
        photo200 = try values.decode(String.self, forKey: .photo200)
    }
}

extension Friend {
    var photoUrl: URL {
        return imageURL()
    }
    
    var photo200Url: URL {
        return image200URL()
    }
  
    private func imageURL() -> URL {
        let stringPath = Bundle.main.path(forResource: "dummy", ofType: "png")
        return URL(string: self.photo100) ?? URL(fileURLWithPath: stringPath!)
    }
    
    private func image200URL() -> URL {
        let stringPath = Bundle.main.path(forResource: "dummy", ofType: "png")
        return URL(string: self.photo200) ?? URL(fileURLWithPath: stringPath!)
    }
}
