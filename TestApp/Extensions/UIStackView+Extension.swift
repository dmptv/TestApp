//
//  UIStackView+Extension.swift
//  TestApp
//
//  Created by 123 on 13.10.2018.
//  Copyright © 2018 kanat. All rights reserved.
//


import UIKit

extension UIView {
    func createStackView(views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        return stackView
    }
}
