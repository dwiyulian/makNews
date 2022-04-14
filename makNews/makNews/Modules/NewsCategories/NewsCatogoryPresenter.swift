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
    
}

extension NewsCategoryPresenter: NewsCategoryInteractorToPresenter {
    
}

