//
//  UIImageView.swift
//  DocCall
//
//  Created by Apple on 23/05/2019.
//  Copyright © 2019 Hamza. All rights reserved.
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


