//
//  NewsSearchRouter.swift
//  makNews
//
//  Created by MacBook on 16/04/22.
//

import UIKit

class NewsSearchRouter: NewsSearchRouterProtocol {
    var view: UIViewController?
    
    func build() -> UIViewController {
        let view = NewsSearchView()
        let interactor = NewsSearchInteractor()
        let presenter = NewsSearchPresenter()
        let router = NewsSearchRouter()
        let network = NetworkService()
        let urlsApi = NewsEndPoints()
        
        view.presenter = presenter
        interactor.presenter = presenter
        interactor.network = network
        interactor.urlsApi = urlsApi
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.view = view        
        
        return view
    }
    
    
}

extension NewsSearchRouter: NewsSearchPresenterToRouterProtocol {
    func goToNewsArticlesScreen(source: Sources) {
        let postNewsArticlesView = NewsArticleRouter().build(source: source)
        view?.navigationController?.pushViewController(postNewsArticlesView, animated: true)
    }
    
    func goToArticleWebScreen(article: Article) {
        let postArticleWebView = ArticleWebPageRouter().build(article: article)
        view?.navigationController?.pushViewController(postArticleWebView, animated: true)
    }
    
    
}
