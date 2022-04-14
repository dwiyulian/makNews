//
//  AppRouter.swift
//  makNews
//
//  Created by MacBook on 14/04/22.
//

import UIKit

class AppRouter {
    
    func buildMainScreen() -> UIViewController {
      let navigation = UINavigationController()
      let newsCategoryView = NewsCategoryRouter().build()
      
      navigation.viewControllers = [newsCategoryView]
      
      return navigation
      
    }
}
