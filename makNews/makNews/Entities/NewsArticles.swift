//
//  NewsArticles.swift
//  makNews
//
//  Created by MacBook on 14/04/22.
//

import Foundation

struct NewsArticles: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let content: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
}


struct Source: Codable {
    let name: String?
}
