//
//  NewsSourceRouter.swift
//  makNews
//
//  Created by MacBook on 15/04/22.
//

import UIKit

class NewsSourceRouter: NewsSourceRouterProtocol {
    var view: UIViewController?
    
    func build(genre: String) -> UIViewController {
        let view = NewsSourceView()
        let interactor = NewsSourceInteractor()
        let presenter = NewsSourcePresenter()
        let router = NewsSourceRouter()
        let network = NetworkService()
        let endPoints = NewsEndPoints()
        
        view.presenter = presenter
        view.genre = genre
        interactor.presenter = presenter
        interactor.network = network
        interactor.urlsApi = endPoints
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.view = view
        
        return view
    }
    
    
}

extension NewsSourceRouter: NewsSourcePresenterToRouterProtocol {
    func goToNewsArticlesScreen(source: Sources) {
        let postNewsArticlesView = NewsArticleRouter().build(source: source)
        view?.navigationController?.pushViewController(postNewsArticlesView, animated: true)
    }
    
}
