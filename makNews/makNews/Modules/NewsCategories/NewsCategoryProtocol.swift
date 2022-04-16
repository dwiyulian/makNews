//
//  NewsCategoryProtocol.swift
//  makNews
//
//  Created by MacBook on 14/04/22.
//

import UIKit


protocol NewsCategoryViewToPresenterProtocol: AnyObject {
    func fetchAllGenres()
    func fetchTopHeadlineArticle()
    func goToNewsSourceScreen(genre: String)
    func goToArticleWebScreen(article: Article)
}

protocol NewsCategoryPresenterProtocol: AnyObject {
    var view: NewsCategoryPresenterToViewProtocol? { get set }
    var interactor: NewsCategoryPresenterToInteractorProtocol? { get set }
    var router: NewsCategoryPresenterToRouterProtocol? { get set }
}

protocol NewsCategoryPresenterToViewProtocol: AnyObject {
    func successFetchedAllGenres(genres: [Categories])
    func successFetchedTopHeadlineArticles(articles: [Article])
    func handleErrorFetched()
    func showActivityIndicator()
    func hideActivityIndicator()
}

protocol NewsCategoryPresenterToInteractorProtocol: AnyObject {
    func fetchAllGenres()
    func fetchTopHeadlineArticle()
}

protocol NewsCategoryPresenterToRouterProtocol: AnyObject {
    func goToNewsSourceScreen(genre: String)
    func goToArticleWebScreen(article: Article)
}

protocol NewsCategoryInteractorProtocol: AnyObject {
    var presenter: NewsCategoryInteractorToPresenter? {get set}
}

protocol NewsCategoryInteractorToPresenter: AnyObject {
    func successFetchedAllGenres(genres: [Categories])
    func successFetchedTopHeadlineArticles(articles: [Article])
    func handleErrorFetched()
}


protocol NewsCategoryRouterProtocol: AnyObject {
    var view: UIViewController? { get set }
    func build() -> UIViewController
}
