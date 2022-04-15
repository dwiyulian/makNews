//
//  NewsCategoriesInteractor.swift
//  makNews
//
//  Created by MacBook on 14/04/22.
//

import Foundation

class NewsCategoryInteractor: NewsCategoryInteractorProtocol {
    
    var presenter: NewsCategoryInteractorToPresenter?
    var network: NetworkServiceProtocol?
    var urlsApi: EndPointProtocols?
    
    
}

extension NewsCategoryInteractor: NewsCategoryPresenterToInteractorProtocol {
    func fetchAllGenres() {
        let genres = NewsCategories.categories
        self.presenter?.successFetchedAllGenres(genres: genres)
    }
    
    func fetchTopHeadlineArticle() {
        
        guard let url = urlsApi?.newsArticles(), let key = urlsApi?.key else {
          return
        }
        
        let parameters: [String:Any] = [
            "country": "us",
            "apiKey": key
        ]
        
        network?.request(url: url, method: .get, parameters: parameters, success: { [weak self] (response) in
                do {
                  let responseApi = try JSONDecoder().decode(NewsArticles.self, from: response)
                    
                    let filteredTopHeadline = self?.filterTopHeadlines(articles: responseApi.articles) ?? []
                    
                    self?.presenter?.successFetchedTopHeadlineArticles(articles: filteredTopHeadline)
                } catch {
                    print(error.localizedDescription)
                    self?.presenter?.handleErrorFetched()
                }
            }, failure: { [weak self] _ in
                self?.presenter?.handleErrorFetched()
          })
        
    }
    
    func filterTopHeadlines(articles: [Article], max: Int = 5) -> [Article]{
        let arrSlice = articles.prefix(max)
        return Array(arrSlice)
    }
    
    
}
