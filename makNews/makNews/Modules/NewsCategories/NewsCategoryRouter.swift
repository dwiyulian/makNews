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
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.view = view
        
        return view
    }
    
    
}

extension NewsCategoryRouter: NewsCategoryPresenterToRouterProtocol {
    func goToNewsSourceScreen(genre: String) {
//        let postDetailView = MovieDetailRouter().build(movie: movie)
//        view?.navigationController?.pushViewController(postDetailView, animated: true)
    }
    
}
