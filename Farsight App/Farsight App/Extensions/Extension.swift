//
//  Extension.swift
//  Farsight App
//
//  Created by WebDEV on 7/15/21.
//

import Foundation

extension String {

    func toDate(withFormat format: String = "EEEE ، d MMMM yyyy") -> Date? {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self)
        return date
    }
    
}
