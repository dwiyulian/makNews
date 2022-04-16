//
//  String+Extensions.swift
//  makNews
//
//  Created by MacBook on 17/04/22.
//

import Foundation

extension String{
    func toDateFormat() -> String {
        guard !self.isEmpty else {return "-"}
        
        let formatter = DateFormatter()
        
        formatter.setLocalizedDateFormatFromTemplate("HH:mm a")
        formatter.amSymbol = ""
        formatter.pmSymbol = ""
        formatter.locale = Locale(identifier: "en_US")
        formatter.timeZone = TimeZone(abbreviation: "GMT+0:00")!
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let updatedDate = formatter.date(from: self)
        
        
            formatter.dateFormat = "d MMM yyyy"
        
//            dateFormat = "d MMMM yyyy"
        
        
        if let convertedDate = updatedDate {
            return formatter.string(from: convertedDate)
        }
        
        return self
    }
}
