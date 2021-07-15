//
//  Extension.swift
//  Farsight App
//
//  Created by Hamza Malik on 16/07/2021.
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
