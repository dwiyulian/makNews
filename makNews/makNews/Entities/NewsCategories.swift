//
//  Categories.swift
//  makNews
//
//  Created by MacBook on 14/04/22.
//

import Foundation
import UIKit

struct NewsCategories {
    static let categories: [Categories] = [.business, .entertainment, .general, .health, .science, .sports, .technology]
}

enum Categories: String {
    case business = "Business"
    case entertainment = "Entertainment"
    case general = "General"
    case health = "Health"
    case science = "Science"
    case sports = "Sports"
    case technology = "Technology"
    
    var icon: UIImage {
        switch self {
        case .business:
            return UIImage(named: "iconBusiness")!
        case .entertainment:
            return UIImage(named: "iconEntertainment")!
        case .general:
            return UIImage(named: "iconGeneral")!
        case .health:
            return UIImage(named: "iconHealth")!
        case .science:
            return UIImage(named: "iconScience")!
        case .sports:
            return UIImage(named: "iconSports")!
        case .technology:
            return UIImage(named: "iconTechnology")!
        }
    }
    
    var bgColor: UIColor {
        switch self {
        case .business:
            return Color.from(hexString: "#eb7385")!
        case .entertainment:
            return Color.from(hexString: "#42cef5")!
        case .general:
            return Color.from(hexString: "#f5a442")!
        case .health:
            return Color.from(hexString: "#c25ced")!
        case .science:
            return Color.from(hexString: "#4f3e57")!
        case .sports:
            return Color.from(hexString: "#71c97b")!
        case .technology:
            return Color.from(hexString: "#7393eb")!
        }
    }
}
