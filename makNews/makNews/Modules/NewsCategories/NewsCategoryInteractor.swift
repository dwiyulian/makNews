//
//  NewsCategoriesInteractor.swift
//  makNews
//
//  Created by MacBook on 14/04/22.
//

import Foundation

class NewsCategoryInteractor: NewsCategoryInteractorProtocol {
    
    var presenter: NewsCategoryInteractorToPresenter?
    
    
}

extension NewsCategoryInteractor: NewsCategoryPresenterToInteractorProtocol {
    
}
