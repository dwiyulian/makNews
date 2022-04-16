//
//  NewsSearchPresenter.swift
//  makNews
//
//  Created by MacBook on 16/04/22.
//

import Foundation

class NewsSearchPresenter: NewsSearchPresenterProtocol {
    var view: NewsSearchPresenterToViewProtocol?
    var interactor: NewsSearchPresenterToInteractorProtocol?
    var router: NewsSearchPresenterToRouterProtocol?
    
    
}

extension NewsSearchPresenter: NewsSearchViewToPresenterProtocol {
    func searchNewsArticle(by: String) {
        interactor?.searchNewsArticle(by: by)
    }
    
    func searchNewsSource(by: String) {
        interactor?.searchNewsSource(by: by)
    }
    
    func loadMoreNewsArticles() {
        interactor?.loadMoreNewsArticles()
    }
    
    func loadMoreNewsSource() {
        interactor?.loadMoreNewsSource()
    }
    
    func goToNewsArticlesScreen(source: Sources) {
        router?.goToNewsArticlesScreen(source: source)
    }
    
    func goToArticleWebScreen(article: Article) {
        router?.goToArticleWebScreen(article: article)
    }
    
}

extension NewsSearchPresenter: NewsSearchInteractorToPresenterProtocol {
    func successFetchedNewsSources(sources: [Sources]) {
        view?.successFetchedNewsSources(sources: sources)
    }
    
    func successFetchedNewsArticles(articles: [Article]) {
        view?.successFetchedNewsArticles(articles: articles)
    }
    
    func successLoadMoreNewsArticles(articles: [Article]) {
        view?.successLoadMoreNewsArticles(articles: articles)
    }
    
    func successLoadMoreNewsSource(sources: [Sources]) {
        view?.successLoadMoreNewsSource(sources: sources)
    }
    
    func handleErrorFetched() {
        view?.handleErrorFetched()
    }
    
    
}
