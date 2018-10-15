//
//  ResponseMessages.swift
//  TestApp
//
//  Created by 123 on 15.10.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import Foundation

struct ResponseMessages: Codable {
    var response: Friends?
}

struct Friends: Codable {
    var count: Int?
    var items: [Friend?]
}
