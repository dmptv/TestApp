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
import YangMingShan


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
        self.yms_presentAlbumPhotoView(with: self)
    }
 
    
}


extension DetailController: YMSPhotoPickerViewControllerDelegate {
    
    func photoPickerViewControllerDidReceivePhotoAlbumAccessDenied(_ picker: YMSPhotoPickerViewController!) {
        let alertController = UIAlertController.init(title: "Allow photo album access?", message: "Need your permission to access photo albumbs", preferredStyle: .alert)
        let dismissAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        let settingsAction = UIAlertAction.init(title: "Settings", style: .default) { (action) in
            UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: { bool in })
        }
        alertController.addAction(dismissAction)
        alertController.addAction(settingsAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func photoPickerViewControllerDidReceiveCameraAccessDenied(_ picker: YMSPhotoPickerViewController!) {
        let alertController = UIAlertController.init(title: "Allow camera album access?", message: "Need your permission to take a photo", preferredStyle: .alert)
        let dismissAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        let settingsAction = UIAlertAction.init(title: "Settings", style: .default) { (action) in
            UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: { bool in })
        }
        alertController.addAction(dismissAction)
        alertController.addAction(settingsAction)
     
        picker.present(alertController, animated: true, completion: nil)
    }
    
    func photoPickerViewController(_ picker: YMSPhotoPickerViewController!, didFinishPicking image: UIImage!) {
        picker.dismiss(animated: true) {
            DispatchQueue.main.async {
                self.profilImageview.image = image
            }
        }
    }

    
}



























