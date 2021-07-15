//
//  RoundButton.swift
//  Farsight App
//
//  Created by WebDEV on 7/15/21.
//

import UIKit
@IBDesignable
class RoundButton: UIButton {
    
     var cornerRadiuss : CGFloat = 0 {
        didSet{
            
            self.layer.cornerRadius = cornerRadiuss
            
        }
        
    }
    
     var borderrWidth : CGFloat = 0 {
        didSet{
            
            self.layer.borderWidth = borderrWidth
        }
        
    }
     var borderrColor : UIColor  = UIColor.clear {
        didSet{
            
            self.layer.borderColor = borderrColor.cgColor
            
        }
        
    }
    
}
