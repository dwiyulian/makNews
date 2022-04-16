//
//  Color.swift
//  makNews
//
//  Created by MacBook on 16/04/22.
//

import UIKit

class Color {
    
    static let shared = Color()
    private init() {}
    
    var searchBar: UIColor{
        return Color.from(hexString: "#f2f2f2")!
    }
    
    var text: UIColor{
        return UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    }
    
    var secondText: UIColor{
        return UIColor(red: 0.589, green: 0.589, blue: 0.589, alpha: 1)
    }
    
    var inactive: UIColor{
        return UIColor(red: 0.755, green: 0.755, blue: 0.755, alpha: 1)
    }
    
    var grey: UIColor{
        return UIColor(red: 0.302, green: 0.302, blue: 0.31, alpha: 1)
    }
    
    
    func rgbColor(r: CGFloat, g: CGFloat, b: CGFloat, a:CGFloat) -> UIColor {
        return UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
    }
    
    static func from(hexString: String) -> UIColor? {
        var chars = Array(hexString.hasPrefix("#") ? hexString.dropFirst() : hexString[...])
        let red, green, blue, alpha: CGFloat
        
        switch chars.count {
        case 3:
            chars = chars.flatMap { [$0, $0] }
            fallthrough
        case 6:
            chars = ["F","F"] + chars
            fallthrough
        case 8:
            alpha = CGFloat(strtoul(String(chars[0...1]), nil, 16)) / 255
            red   = CGFloat(strtoul(String(chars[2...3]), nil, 16)) / 255
            green = CGFloat(strtoul(String(chars[4...5]), nil, 16)) / 255
            blue  = CGFloat(strtoul(String(chars[6...7]), nil, 16)) / 255
        default:
            return nil
        }
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
