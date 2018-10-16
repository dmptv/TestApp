//
//  GlobalData.swift
//  TestApp
//
//  Created by 123 on 16.10.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit
import Photos

class GlobalData {
    static let sharedInstance = GlobalData()
    private init() {}
    
    var dataRefenciesDict = [Int: String]()
    
    func fetchAsset(for localIdentifier: String, completion: @escaping (UIImage) -> Void) {
        
            let allPhotos = PHAsset.fetchAssets(withLocalIdentifiers: [localIdentifier], options: PHFetchOptions.init())
        
            DispatchQueue.global(qos: .background).async {
                allPhotos.enumerateObjects({ (asset, count, stop) in
                    let imageManager = PHImageManager.default()
                    let targetSize = CGSize(width: 200, height: 200)
                    let options = PHImageRequestOptions()
                    options.isSynchronous = true
                    imageManager.requestImage(for: asset,
                                              targetSize: targetSize,
                                              contentMode: .aspectFit,
                                              options: options,
                                              resultHandler:
                        { (image, info) in
                            
                            if let image = image {
                                completion(image)
                            }
                    })
                    
                })
            }
        
    }
    
}
