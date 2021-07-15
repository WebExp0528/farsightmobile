//
//  RoundButton.swift
//  kharchi
//
//  Created by Apple on 28/08/2018.
//  Copyright © 2018 Apple. All rights reserved.
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
