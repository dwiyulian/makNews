//
//  NewsSourcePresenter.swift
//  makNews
//
//  Created by MacBook on 15/04/22.
//

import Foundation

class NewsSourcePresenter: NewsSourcePresenterProtocol {
    var view: NewsSourcePresenterToViewProtocol?
    var interactor: NewsSourcePresenterToInteractorProtocol?
    var router: NewsSourcePresenterToRouterProtocol?
    
}


extension NewsSourcePresenter: NewsSourceViewToPresenterProtocol {
    func searchForNewsSource(genre: String) {
        view?.showActivityIndicator()
        interactor?.fetchSearchedNewsSources(genre: genre)
    }
    
    func goToNewsArticlesScreen(source: Sources) {
        router?.goToNewsArticlesScreen(source: source)
    }
    
}

extension NewsSourcePresenter: NewsSourceInteractorToPresenterProtocol {
    func successFetchedNewsSource(sources: [Sources]) {
        view?.hideActivityIndicator()
        view?.successFetchedNewsSource(sources: sources)
    }
    
    func handleErrorFetched() {
        view?.hideActivityIndicator()
        view?.handleErrorFetched()
    }
}

