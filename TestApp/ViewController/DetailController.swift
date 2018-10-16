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
    
    @IBOutlet weak var profilImageview: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var addPhotoButton: UIButton!
    
    //TODO: - inject
    var user: Friend!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = user {
            profilImageview.sd_setImage(with: user.photo200Url, completed: nil)
            usernameLabel.text = user.firstName + " " + user.lastName
        } else {
            usernameLabel.text = "Unknown"
        }
        
    }

    @IBAction func addPhoto(_ sender: UIButton) {
        
    }
    
}
