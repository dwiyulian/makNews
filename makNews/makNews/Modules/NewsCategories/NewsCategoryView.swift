//
//  ViewController.swift
//  makNews
//
//  Created by MacBook on 14/04/22.
//

import UIKit

class NewsCategoryView: UIViewController {

    var presenter: NewsCategoryViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBlue
    }


}

extension NewsCategoryView: NewsCategoryPresenterToViewProtocol {
    
}

