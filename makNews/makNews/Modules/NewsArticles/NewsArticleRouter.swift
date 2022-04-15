//
//  NewsArticleRouter.swift
//  makNews
//
//  Created by MacBook on 15/04/22.
//

import UIKit

class NewsArticleRouter: NewsArticleRouterProtocol {
    var view: UIViewController?
    
    func build(source: Sources) -> UIViewController {
        let view = NewsArticleView()
        let interactor = NewsArticleInteractor()
        let presenter = NewsArticlePresenter()
        let router = NewsArticleRouter()
        let urlApi = NewsEndPoints()
        let networkService = NetworkService()
        
        view.presenter = presenter
        view.source = source
        interactor.presenter = presenter
        interactor.urlsApi = urlApi
        interactor.network = networkService
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.view = view
        
        return view
    }
    
}

extension NewsArticleRouter: NewsArticlePresenterToRouterProtocol{
    func goToArticleWebScreen(article: Article) {
        let postArticleWebPageView = ArticleWebPageRouter().build(article: article)
        view?.navigationController?.pushViewController(postArticleWebPageView, animated: true)
    }
}
