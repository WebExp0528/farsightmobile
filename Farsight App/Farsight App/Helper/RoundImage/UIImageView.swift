//
//  UIImageView.swift
//  Farsight App
//
//  Created by WebDEV on 7/15/21.
//

import UIKit

extension UIImageView {
    
    func roundedImage() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
    func maskWithColor(color: UIColor) {
    self.image = self.image?.withRenderingMode(.alwaysTemplate)
    self.tintColor = color

    }
    
    
    
}


