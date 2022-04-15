//
//  NewsArticlePresenter.swift
//  makNews
//
//  Created by MacBook on 15/04/22.
//

import Foundation


class NewsArticlePresenter: NewsArticlePresenterProtocol {
    var view: NewsArticlePresenterToViewProtocol?
    var interactor: NewsArticlePresenterToInteractorProtocol?
    var router: NewsArticlePresenterToRouterProtocol?
}


extension NewsArticlePresenter: NewsArticleViewToPresenterProtocol {
    func searchForNewsArticles(sourceId: String) {
        interactor?.fetchSearchedNewsArticles(sourceId: sourceId)
    }
    
    func goToArticleWebScreen(article: Article) {
        router?.goToArticleWebScreen(article: article)
    }
}

extension NewsArticlePresenter: NewsArticleInteractorToPresenterProtocol {
    func successFetchedNewsArticles(articles: [Article]) {
        view?.successFetchedNewsArticles(articles: articles)
    }
    
    func handleErrorFetched() {
        view?.handleErrorFetched()
    }
}
