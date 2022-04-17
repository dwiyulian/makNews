//
//  NewsArticleInteractor.swift
//  makNews
//
//  Created by MacBook on 15/04/22.
//

import Foundation

class NewsArticleInteractor: NewsArticleInteractorProtocol {
    var presenter: NewsArticleInteractorToPresenterProtocol?
    var network: NetworkServiceProtocol?
    var urlsApi: EndPointProtocols?
    var allNewsArticles = [Article]()
    var currentPaging: Int = 0
}

extension NewsArticleInteractor: NewsArticlePresenterToInteractorProtocol {
    func fetchSearchedNewsArticles(sourceId: String) {
        guard let url = urlsApi?.newsArticles(), let key = urlsApi?.key else {
          return
        }
        
        let parameters: [String:Any] = [
            "sources": sourceId,
            "apiKey": key
        ]

        network?.request(url: url, method: .get, parameters: parameters, success: { [weak self] (response) in
                do {
                    guard let _self = self else {return}
                    let responseApi = try JSONDecoder().decode(NewsArticles.self, from: response)
                    _self.allNewsArticles = responseApi.articles
                    let articles = _self.fetchPagingNewsArticles(page: _self.currentPaging)
                    self?.presenter?.successFetchedNewsArticles(articles: articles)
                } catch {
                    print(error.localizedDescription)
                    self?.presenter?.handleErrorFetched()
                }
            
            }, failure: { [weak self] _ in
                self?.presenter?.handleErrorFetched()
          })
        
    }
    
    func loadMoreNewsArticles() {
        let articles = fetchPagingNewsArticles(page: self.currentPaging)
        self.presenter?.successLoadMoreNewsArticles(articles: articles)
    }
    
    
    func fetchPagingNewsArticles(page: Int) -> [Article] {
        guard allNewsArticles.count > 0 else {
            return []
        }
        
        var newsArticles = [Article]()
        
        let totalData = allNewsArticles.count
        let pageSize = 5
        let minRange = page * pageSize
        var maxRange = minRange + pageSize - 1
        
        if totalData > minRange {
            if maxRange > totalData - 1 {maxRange = totalData - 1}
            
            let arrSlice = allNewsArticles[minRange...maxRange]
            newsArticles =  Array(arrSlice)
            self.currentPaging += 1
        }
        
        return newsArticles
    }
}
