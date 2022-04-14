//
//  NewsCategoryProtocol.swift
//  makNews
//
//  Created by MacBook on 14/04/22.
//

import UIKit


protocol NewsCategoryViewToPresenterProtocol: AnyObject {
    
}

protocol NewsCategoryPresenterProtocol: AnyObject {
    var view: NewsCategoryPresenterToViewProtocol? { get set }
    var interactor: NewsCategoryPresenterToInteractorProtocol? { get set }
    var router: NewsCategoryPresenterToRouterProtocol? { get set }
}

protocol NewsCategoryPresenterToViewProtocol: AnyObject {
    
}

protocol NewsCategoryPresenterToInteractorProtocol: AnyObject {
    
}

protocol NewsCategoryPresenterToRouterProtocol: AnyObject {
    
}

protocol NewsCategoryInteractorProtocol: AnyObject {
    var presenter: NewsCategoryInteractorToPresenter? {get set}
}

protocol NewsCategoryInteractorToPresenter: AnyObject {
}


protocol NewsCategoryRouterProtocol: AnyObject {
    var view: UIViewController? { get set }
    func build() -> UIViewController
}
