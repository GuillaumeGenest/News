//
//  Utils.swift
//  News
//
//  Created by Guillaume Genest on 24/03/2023.
//

import Foundation
extension Date {
    
    func FormattedDate(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
        
    }
    
}
