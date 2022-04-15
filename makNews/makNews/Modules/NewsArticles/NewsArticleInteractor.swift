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
                  let responseApi = try JSONDecoder().decode(NewsArticles.self, from: response)
                    self?.presenter?.successFetchedNewsArticles(articles: responseApi.articles)
                } catch {
                    print(error.localizedDescription)
                    self?.presenter?.handleErrorFetched()
                }
            
            }, failure: { [weak self] _ in
                self?.presenter?.handleErrorFetched()
          })
        
    }
}
