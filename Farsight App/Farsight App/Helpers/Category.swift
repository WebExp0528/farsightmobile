//
//  Category.swift
//  Farsight App
//
//  Created by WebDEV on 7/23/21.
//

import Foundation

protocol CategoryType {
    var id : String { get }
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
}
