//
//  NewsEndPoints.swift
//  makNews
//
//  Created by MacBook on 14/04/22.
//

import Foundation

class NewsEndPoints: EndPointProtocols {
    
    private let baseUrl = "https://newsapi.org/v2/"
    var key = "b55d85bcee6248329f3cbac9cbfa1cef"
    
    func allCategories() -> String {
        return baseUrl + "top-headlines/sources"
    }
    
    func newsArticles() -> String {
        return baseUrl + "top-headlines"
    }
    
    func newsSearchArticles() -> String {
        return baseUrl + "everything"
    }
}
