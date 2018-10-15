//
//  DetailController.swift
//  TestApp
//
//  Created by 123 on 15.10.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit
import VK_ios_sdk
import SDWebImage

class DetailController: UIViewController {
    
    //TODO: - inject
    var user: Friend! {
        didSet {
            print(user.firstName)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

}
