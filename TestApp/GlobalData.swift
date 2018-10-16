//
//  GlobalData.swift
//  TestApp
//
//  Created by 123 on 16.10.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit

class GlobalData {
    static let sharedInstance = GlobalData()
    private init() {}
    
    var dataRefenciesDict = [Int: String]()
}
