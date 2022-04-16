//
//  NewsSearchInteractor.swift
//  makNews
//
//  Created by MacBook on 16/04/22.
//

import Foundation

class NewsSearchInteractor: NewsSearchInteractorProtocol {
    var presenter: NewsSearchInteractorToPresenterProtocol?
    var network: NetworkServiceProtocol?
    var urlsApi: EndPointProtocols?
    var searchCategory: String = ""
}

extension NewsSearchInteractor: NewsSearchPresenterToInteractorProtocol {
    func searchNewsArticle(by: String) {
        guard let url = urlsApi?.newsSearchArticles(), let key = urlsApi?.key else {
          return
        }

        let parameters: [String:Any] = [
            "q": by,
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
    
    func searchNewsSource(by: String) {
        guard let url = urlsApi?.allCategories(), let key = urlsApi?.key else {
          return
        }

        let parameters: [String:Any] = [
            "apiKey": key
        ]

        network?.request(url: url, method: .get, parameters: parameters, success: { [weak self] (response) in
                do {
                  let responseApi = try JSONDecoder().decode(NewsSourcesModel.self, from: response)
                    let filterResult = self?.filterNewsSourceByKeyword(keyword: by, sources: responseApi.sources) ?? []
                    self?.presenter?.successFetchedNewsSources(sources: filterResult)
                } catch {
                    print(error.localizedDescription)
                    self?.presenter?.handleErrorFetched()
                }
            }, failure: { [weak self] _ in
                self?.presenter?.handleErrorFetched()
          })
    }
    
    
    func filterNewsSourceByKeyword(keyword: String, sources: [Sources]) -> [Sources]{
        let _sources = sources
        let _keyword = keyword.lowercased()
        
        return _sources.filter { source in
            let name = source.name ?? ""
            let desc = source.description ?? ""
            
            if name.isEmpty && desc.isEmpty {return false}
            
            return name.lowercased().contains(_keyword) || desc.lowercased().contains(_keyword)
        }
    }
    
}
