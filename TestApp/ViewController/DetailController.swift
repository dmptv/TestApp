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
import Photos

class DetailController: UIViewController {
    
    @IBOutlet weak var profilImageview: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var addPhotoButton: UIButton!
    
    //TODO: - inject
    var user: FriendWithCustomImageProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = user {
            if let identifier = GlobalData.sharedInstance.dataRefenciesDict[user.id] {
                GlobalData.sharedInstance.fetchAsset(for: identifier, completion: { (image) in
                    DispatchQueue.main.async { [weak self] in
                        self?.profilImageview.image = image
                    }
                })
                
            } else {
                profilImageview.sd_setImage(with: user.photo200Url, completed: nil)

            }
            usernameLabel.text = user.firstName + " " + user.lastName
        } else {
            usernameLabel.text = "Unknown"
        }
        
    }

    
    @IBAction func addPhoto(_ sender: UIButton) {
        //TODO: - inject
        let layout = UICollectionViewFlowLayout()
        let photoSelectorController = PhotoSelectorController(collectionViewLayout: layout)
        let navController = UINavigationController(rootViewController: photoSelectorController)
        photoSelectorController.idKey = user.id
        photoSelectorController.didTapNext = { [weak self] image in
            DispatchQueue.main.async {
               self?.profilImageview.image = image
            }
        }
        present(navController, animated: true, completion: nil)

    }
}





























