//
//  NewsCatogoriesPresenter.swift
//  makNews
//
//  Created by MacBook on 14/04/22.
//

import Foundation


class NewsCategoryPresenter: NewsCategoryPresenterProtocol {
    
    var view: NewsCategoryPresenterToViewProtocol?
    
    var interactor: NewsCategoryPresenterToInteractorProtocol?
    
    var router: NewsCategoryPresenterToRouterProtocol?
    
    
}

extension NewsCategoryPresenter: NewsCategoryViewToPresenterProtocol {
    func fetchAllGenres() {
        interactor?.fetchAllGenres()
    }
    
    func fetchTopHeadlineArticle() {
        interactor?.fetchTopHeadlineArticle()
    }
    
    func goToNewsSourceScreen(genre: String) {
        router?.goToNewsSourceScreen(genre: genre)
    }
    
    func goToArticleWebScreen(article: Article) {
        router?.goToArticleWebScreen(article: article)
    }
}

extension NewsCategoryPresenter: NewsCategoryInteractorToPresenter {
    func successFetchedAllGenres(genres: [Categories]) {
        view?.successFetchedAllGenres(genres: genres)
    }
    
    func successFetchedTopHeadlineArticles(articles: [Article]) {
        view?.successFetchedTopHeadlineArticles(articles: articles)
    }
    
    func handleErrorFetched() {
        view?.handleErrorFetched()
    }
}

