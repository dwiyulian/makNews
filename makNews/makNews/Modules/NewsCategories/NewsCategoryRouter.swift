//
//  NewsCategoriRouter.swift
//  makNews
//
//  Created by MacBook on 14/04/22.
//

import UIKit

class NewsCategoryRouter: NewsCategoryRouterProtocol {
    var view: UIViewController?
    
    func build() -> UIViewController {
        let view = NewsCategoryView()
        let presenter = NewsCategoryPresenter()
        let interactor = NewsCategoryInteractor()
        let router = NewsCategoryRouter()
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

extension NewsCategoryRouter: NewsCategoryPresenterToRouterProtocol {
    func goToNewsSourceScreen(genre: String) {
        let postNewsSourceView = NewsSourceRouter().build(genre: genre)
        view?.navigationController?.pushViewController(postNewsSourceView, animated: true)
    }
    
    func goToArticleWebScreen(article: Article) {
        let postArticleWebView = ArticleWebPageRouter().build(article: article)
        view?.navigationController?.pushViewController(postArticleWebView, animated: true)
    }
}
