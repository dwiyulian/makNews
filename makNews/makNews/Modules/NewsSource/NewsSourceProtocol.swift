//
//  NewsSourceProtocol.swift
//  makNews
//
//  Created by MacBook on 15/04/22.
//

import Foundation
import UIKit


protocol NewsSourceViewToPresenterProtocol: AnyObject {
    func searchForNewsSource(genre: String)
    func loadMoreNewsSource()
    func goToNewsArticlesScreen(source: Sources)
}

protocol NewsSourcePresenterProtocol: AnyObject {
    var view: NewsSourcePresenterToViewProtocol? {get set}
    var interactor: NewsSourcePresenterToInteractorProtocol? {get set}
    var router: NewsSourcePresenterToRouterProtocol? {get set}
}

protocol NewsSourcePresenterToViewProtocol: AnyObject {
    func successFetchedNewsSource(sources: [Sources])
    func successLoadMoreNewsSource(sources: [Sources])
    func handleErrorFetched()
    func showActivityIndicator()
    func hideActivityIndicator()
}

protocol NewsSourcePresenterToInteractorProtocol: AnyObject {
    func fetchSearchedNewsSources(genre: String)
    func loadMoreNewsSource()
}

protocol NewsSourcePresenterToRouterProtocol: AnyObject {
    func goToNewsArticlesScreen(source: Sources)
}

protocol NewsSourceInteractorProtocol: AnyObject {
    var presenter: NewsSourceInteractorToPresenterProtocol? { get set }
}

protocol NewsSourceInteractorToPresenterProtocol: AnyObject {
    func successFetchedNewsSource(sources: [Sources])
    func successLoadMoreNewsSource(sources: [Sources])
    func handleErrorFetched()
}

protocol NewsSourceRouterProtocol: AnyObject {
    var view: UIViewController? { get set }
    func build(genre: String) -> UIViewController
}
