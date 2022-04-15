//
//  ArticleWebPageRouter.swift
//  makNews
//
//  Created by MacBook on 15/04/22.
//

import UIKit


class ArticleWebPageRouter: ArticleWebPageRouterProtocol {
    var view: UIViewController?
    
    func build(article: Article) -> UIViewController {
        let view = ArticleWebPageView()
        view.article = article
        return view
    }
    
    
}

