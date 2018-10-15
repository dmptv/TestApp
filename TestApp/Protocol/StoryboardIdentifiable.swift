//
//  StoryboardIdentifiable.swift
//  TestApp
//
//  Created by 123 on 13.10.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}
