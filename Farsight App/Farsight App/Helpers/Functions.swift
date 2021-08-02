//
//  GetStatusFromDate.swift
//  Farsight App
//
//  Created by WebDEV on 7/22/21.
//

import Foundation
import UIKit

protocol StatusType {
    var label: String { get }
    var color: UIColor { get }
}

enum StatusItems {
    case OnTime
    case PastDue
    case DueToday
}

extension StatusItems : StatusType {
    var label: String {
        switch self {
        case .OnTime:
            return "On Time"
        case .DueToday:
            return "Due Today"
        case .PastDue:
            return "Past Due"
        }
    }
    
    var color: UIColor {
        switch self {
        case .OnTime:
            return UIColor.green
        case .DueToday:
            return UIColor.yellow
        case .PastDue:
            return UIColor.red
        }
    }
}

func statusFromDate(date:Date) ->StatusItems {
    let currentDate = Date()
    
    if (date > currentDate) {
        return StatusItems.OnTime
    } else if (date < currentDate) {
        return StatusItems.PastDue
    } else if (date == currentDate) {
        return StatusItems.DueToday
    }
    return StatusItems.DueToday
}
