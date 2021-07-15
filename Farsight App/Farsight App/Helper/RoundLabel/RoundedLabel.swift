//
//  RoundLabel.swift
//  DocCall
//
//  Created by Apple on 30/04/2019.
//  Copyright © 2019 Hamza. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedLabel: UILabel {
    
    var edgeInsets: UIEdgeInsets {
        if autoPadding {
            if cornerRadius == 0 {
                return UIEdgeInsets.zero
            } else {
                return UIEdgeInsets(top: 1, left: 4, bottom: 1, right: 4)
            }
        } else {
            return UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
        }
    }
    
    @IBInspectable var horizontalPadding: CGFloat = 0
    @IBInspectable var verticalPadding: CGFloat = 0
    @IBInspectable var autoPadding: Bool = true
    
     @IBInspectable var cornnerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: edgeInsets))
    }
    
    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        
        let edgeInsets = self.edgeInsets
        size.width += edgeInsets.left + edgeInsets.right
        size.height += edgeInsets.top + edgeInsets.bottom
        
        return size
    }
    
}
