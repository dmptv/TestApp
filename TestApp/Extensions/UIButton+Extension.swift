//
//  UIButton+Extension.swift
//  TestApp
//
//  Created by 123 on 13.10.2018.
//  Copyright © 2018 kanat. All rights reserved.
//


import UIKit

extension UIButton {
    public convenience init(title: String, borderColor: UIColor) {
        self.init()
        let atribtitle = NSAttributedString(string: title,
                                            attributes:
            [
                NSAttributedString.Key.font:            UIFont.systemFont(ofSize: 18),
                NSAttributedString.Key.foregroundColor: UIColor.white
            ])
        let attributedString = NSMutableAttributedString(attributedString: atribtitle)
        self.setAttributedTitle(attributedString, for: .normal)
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = borderColor.cgColor
        self.setAnchor(width: 0, height: 50)
    }
}
