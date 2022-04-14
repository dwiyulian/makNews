//
//  NewsSources.swift
//  makNews
//
//  Created by MacBook on 14/04/22.
//

import Foundation

struct NewsSourcesModel: Codable {
    let sources: [Sources]
}

struct Sources:  Codable {
    let name: String?
    let description: String?
}
