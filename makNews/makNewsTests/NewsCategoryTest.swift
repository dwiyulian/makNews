//
//  NewsCategoryInteractor.swift
//  makNewsTests
//
//  Created by MacBook on 14/04/22.
//

import XCTest
@testable import makNews

class NewsCategoryTest: XCTestCase {

    var presenter: NewsCategoryPresenter?
    var interactor: NewsCategoryInteractor?
    var router: NewsCategoryRouter?
    
    override func setUp() {
        presenter = NewsCategoryPresenter()
        interactor = NewsCategoryInteractor()
        router = NewsCategoryRouter()
    }
    
    
    
    func testFilterTopHeadlines() {
        
        let dummy: [Article] = [
            Article(source: Source(name: ""), author: "First", title: "First", description: "", content: "", url: "", urlToImage: "", publishedAt: ""),
            Article(source: Source(name: ""), author: "Second", title: "Second", description: "", content: "", url: "", urlToImage: "", publishedAt: "BBB"),
            Article(source: Source(name: ""), author: "Third", title: "Third", description: "", content: "", url: "", urlToImage: "", publishedAt: ""),
            Article(source: Source(name: ""), author: "Fourth", title: "Fourth", description: "", content: "", url: "", urlToImage: "BBB", publishedAt: ""),
            Article(source: Source(name: ""), author: "Fifth", title: "Fifth", description: "", content: "", url: "", urlToImage: "", publishedAt: ""),
            Article(source: Source(name: ""), author: "Sixth", title: "Sixth", description: "", content: "", url: "", urlToImage: "", publishedAt: "")
        ]
        
        let result = interactor?.filterTopHeadlines(articles: dummy) ?? []
        
        XCTAssertTrue(result.count == 5)
        XCTAssertEqual(result.last?.title, "Fifth")
        
        XCTAssert((presenter?.successFetchedTopHeadlineArticles(articles: result) != nil))
        
        
    }

    
    func testGotoSourceScreen() {
        presenter?.goToNewsSourceScreen(genre: "general")
        XCTAssertTrue(((router?.goToNewsSourceScreen) != nil))
    }
}
