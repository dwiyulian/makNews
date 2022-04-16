//
//  NewsArticleProtocol.swift
//  makNews
//
//  Created by MacBook on 15/04/22.
//

import UIKit

protocol NewsArticleViewToPresenterProtocol {
    func searchForNewsArticles(sourceId: String)
    func loadMoreNewsArticles()
    func goToArticleWebScreen(article: Article)
}

protocol NewsArticlePresenterProtocol {
    var view: NewsArticlePresenterToViewProtocol? {get set}
    var interactor: NewsArticlePresenterToInteractorProtocol? {get set}
    var router: NewsArticlePresenterToRouterProtocol? {get set}
}

protocol NewsArticlePresenterToViewProtocol {
    func successFetchedNewsArticles(articles: [Article])
    func successLoadMoreNewsArticles(articles: [Article])
    func handleErrorFetched()
    func showActivityIndicator()
    func hideActivityIndicator()
}

protocol NewsArticlePresenterToInteractorProtocol {
    func fetchSearchedNewsArticles(sourceId: String)
    func loadMoreNewsArticles()
}

protocol NewsArticlePresenterToRouterProtocol {
    func goToArticleWebScreen(article: Article)
}

protocol NewsArticleInteractorProtocol {
    var presenter: NewsArticleInteractorToPresenterProtocol? { get set }
}

protocol NewsArticleInteractorToPresenterProtocol {
    func successFetchedNewsArticles(articles: [Article])
    func successLoadMoreNewsArticles(articles: [Article])
    func handleErrorFetched()
}

protocol NewsArticleRouterProtocol {
    var view: UIViewController? { get set }
    func build(source: Sources) -> UIViewController
}
