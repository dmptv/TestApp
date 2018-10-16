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
    
    @IBAction func takePhoto(_ sender: UIButton) {
        let vc = UIImagePickerController()
        
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
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

extension DetailController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            print("No image found")
            return
        }
    
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(DetailController.image(_:didFinishSavingWithError:contextInfo:)), nil)
        
        DispatchQueue.main.async { [weak self] in
            self?.profilImageview.image = image
        }
        
    }
    
    fileprivate func assetsFetchOptions() -> PHFetchOptions {
        let fetchOptions = PHFetchOptions()
        fetchOptions.fetchLimit = 1
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchOptions.sortDescriptors = [sortDescriptor]
        return fetchOptions
    }
    
    @objc
    func image(_ image: UIImage, didFinishSavingWithError error: NSError?,
               contextInfo: UnsafeRawPointer) {

        let allPhotos = PHAsset.fetchAssets(with: .image, options: assetsFetchOptions())
        let asset = allPhotos[0]
        
        let imageManager = PHImageManager.default()
        let targetSize = CGSize(width: 600, height: 600)
        imageManager.requestImage(for: asset,
                                  targetSize: targetSize,
                                  contentMode: .default,
                                  options: nil,
                                  resultHandler:
            { [weak self] (image, info) in
                guard let strSelf = self else { return }
                
                GlobalData.sharedInstance.dataRefenciesDict[strSelf.user.id] = asset.localIdentifier
        })
        
    }
    
  
}




























