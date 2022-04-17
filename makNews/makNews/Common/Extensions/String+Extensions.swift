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
        
        let strDate = String(self.prefix(10))
        
        formatter.setLocalizedDateFormatFromTemplate("HH:mm a")
        formatter.amSymbol = ""
        formatter.pmSymbol = ""
        formatter.locale = Locale(identifier: "en_US")
        formatter.timeZone = TimeZone(abbreviation: "GMT+0:00")!
        formatter.dateFormat = "yyyy-MM-dd"
        let updatedDate = formatter.date(from: strDate)
        
        formatter.dateFormat = "d MMM yyyy"
        
        if let convertedDate = updatedDate {
            return formatter.string(from: convertedDate)
        }
        
        return self
    }
}
