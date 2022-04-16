//
//  NewsSearchProtocol.swift
//  makNews
//
//  Created by MacBook on 16/04/22.
//

import UIKit

protocol NewsSearchViewToPresenterProtocol {
    func searchNewsArticle(by: String)
    func searchNewsSource(by: String)
    func goToNewsArticlesScreen(source: Sources)
    func goToArticleWebScreen(article: Article)
}

protocol NewsSearchPresenterProtocol {
    var view: NewsSearchPresenterToViewProtocol? { get set }
    var interactor: NewsSearchPresenterToInteractorProtocol? { get set }
    var router: NewsSearchPresenterToRouterProtocol? { get set }
}

protocol NewsSearchPresenterToViewProtocol {
    func successFetchedNewsSources(sources: [Sources])
    func successFetchedNewsArticles(articles: [Article])
    func handleErrorFetched()
}

protocol NewsSearchPresenterToInteractorProtocol {
    func searchNewsArticle(by: String)
    func searchNewsSource(by: String)
}

protocol NewsSearchPresenterToRouterProtocol {
    func goToNewsArticlesScreen(source: Sources)
    func goToArticleWebScreen(article: Article)
}

protocol NewsSearchInteractorProtocol {
    var presenter: NewsSearchInteractorToPresenterProtocol? { get set }
}

protocol NewsSearchInteractorToPresenterProtocol {
    func successFetchedNewsSources(sources: [Sources])
    func successFetchedNewsArticles(articles: [Article])
    func handleErrorFetched()
}

protocol NewsSearchRouterProtocol {
    var view: UIViewController? { get set }
    func build() -> UIViewController
}


