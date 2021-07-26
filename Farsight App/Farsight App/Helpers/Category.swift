//
//  Category.swift
//  Farsight App
//
//  Created by WebDEV on 7/23/21.
//

import Foundation
import UIKit

protocol CategoryType {
    var id : String { get }
    var color : UIColor { get }
}

enum Category {
    case Before
    case After
    case During
}

extension Category : CategoryType {
    var id: String {
        switch self {
            case  .Before :
                return "before"
            case .After :
                return "after"
            case .During :
                return "during"
        }
    }
    
    var color: UIColor {
        switch self {
            case  .Before :
                return UIColor.init(hexString: "#f8841d")
            case .After :
                return UIColor.init(hexString: "#28b62c")
            case .During :
                return UIColor.init(hexString: "#75caeb")
        }
    }
}
