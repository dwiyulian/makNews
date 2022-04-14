//
//  Categories.swift
//  makNews
//
//  Created by MacBook on 14/04/22.
//

import Foundation

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
}
