//
//  ArticleWebPageProtocol.swift
//  makNews
//
//  Created by MacBook on 15/04/22.
//

import UIKit

protocol ArticleWebPageRouterProtocol{
    var view: UIViewController? { get set }
    func build(article: Article) -> UIViewController
}




