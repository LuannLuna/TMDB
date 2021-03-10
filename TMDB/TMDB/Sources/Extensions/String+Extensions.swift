//
//  String+Extensions.swift
//
//  Created by Luann Marques Luna on 22/02/21.
//

import Foundation


extension String {
    func atFormat(with stringFormat: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = formatter.date(from: self) else {
            return ""
        }
        
        formatter.dateFormat = stringFormat
        return formatter.string(from: date).capitalized
    }
}
