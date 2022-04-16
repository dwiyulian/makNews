//
//  UIView+Extensions.swift
//  makNews
//
//  Created by MacBook on 16/04/22.
//

import UIKit

extension UIView {
    func setShadow() {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 3.0
        self.layer.masksToBounds = false
    }
}
