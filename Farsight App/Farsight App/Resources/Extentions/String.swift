//
//  String.swift
//  Farsight App
//
//  Created by WebDEV on 7/22/21.
//

import Foundation

extension String {
    
    func toDate(withFormat format: String = "MMM dd,yyyy") -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self)
        return date
    }
    
}
