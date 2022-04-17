//
//  NewSourceTest.swift
//  makNewsTests
//
//  Created by MacBook on 17/04/22.
//

import XCTest
@testable import makNews

class NewSourceTest: XCTestCase {

    var presenter: NewsSourcePresenter?
    var interactor: NewsSourceInteractor?
    var router: NewsSourceRouter?
    
    override func setUp() {
        presenter = NewsSourcePresenter()
        interactor = NewsSourceInteractor()
        router = NewsSourceRouter()
    }

    func testPagingNewsSource() {
        interactor?.allNewsSource = []
        interactor?.currentPaging = 0
        
        var result = interactor?.fetchPagingNewsSource(page: interactor!.currentPaging) ?? []
        
        XCTAssertTrue(result.count == 0)
        
        interactor?.allNewsSource = [
            Sources(id: "", name: "First", description: ""),
            Sources(id: "", name: "Second", description: ""),
            Sources(id: "", name: "Third", description: ""),
            Sources(id: "", name: "Fourth", description: ""),
            Sources(id: "", name: "Fifth", description: ""),
            Sources(id: "", name: "Sixth", description: ""),
            Sources(id: "", name: "Seventh", description: ""),
            Sources(id: "", name: "Eighth", description: ""),
            Sources(id: "", name: "Ninth", description: ""),
            Sources(id: "", name: "Tenth", description: ""),
            Sources(id: "", name: "Eleventh", description: ""),
        ]
        
        result = interactor?.fetchPagingNewsSource(page: interactor!.currentPaging) ?? []
        
        XCTAssertTrue(result.count == 10)
        XCTAssertEqual(result.last?.name, "Tenth")
        
        interactor?.currentPaging = 1
        
        result = interactor?.fetchPagingNewsSource(page: interactor!.currentPaging) ?? []
        
        XCTAssertTrue(result.count == 1)
        XCTAssertEqual(result.first?.name, "Eleventh")
        
    }
    
}
