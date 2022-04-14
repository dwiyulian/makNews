//
//  EndPointProtocols.swift
//  makNews
//
//  Created by MacBook on 14/04/22.
//

import Foundation

protocol EndPointProtocols: AnyObject {
    var key: String { get set }
    func allCategories() -> String
    func newsArticles() -> String
    func newsSearchArticles() -> String
}
