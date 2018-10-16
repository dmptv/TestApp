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
        
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            addPhotoButton.setTitle("Select Photo", for: .normal)
        }
        
        if let user = user {
            profilImageview.sd_setImage(with: user.photo200Url, completed: nil)
            usernameLabel.text = user.firstName + " " + user.lastName
        } else {
            usernameLabel.text = "Unknown"
        }
        
    }

    @IBAction func addPhoto(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
            picker.modalPresentationStyle = .fullScreen
        }
        
        present(picker, animated: true)
    }
    
}

extension DetailController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            print("Info did not have the required UIImage for the Original Image")
            dismiss(animated: true)
            return
        }
        
        profilImageview.image = image
        
        //        takePictureButton.isHidden = true
        //        progressView.progress = 0.0
        //        progressView.isHidden = false
        //        activityIndicatorView.startAnimating()
        
        //        viewModel?.upload(image: image, progressCompletion:
        //            { [weak self]  percent in
        //
        //                self?.progressView.setProgress(percent, animated: true)
        //
        //            }, completion:
        //            { [weak self] tags, colors in
        //
        //                self?.takePictureButton.isHidden = false
        //                self?.progressView.isHidden = true
        //                self?.activityIndicatorView.stopAnimating()
        //
        //                // TODO: - bind data back
        //                self?.viewModel?.setTags(tags)
        //                self?.viewModel?.setColors(colors)
        //
        //                self?.performSegue(withIdentifier: "ShowResults", sender: self)
        //        })
        
        dismiss(animated: true)
    }

}




























