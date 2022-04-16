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
    var allNewsArticles = [Article]()
    var allNewsSource = [Sources]()
    var currentPaging: Int = 0
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
                    guard let _self = self else {return}
                    _self.currentPaging = 0
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
    
    func searchNewsSource(by: String) {
        guard let url = urlsApi?.allCategories(), let key = urlsApi?.key else {
          return
        }

        let parameters: [String:Any] = [
            "apiKey": key
        ]

        network?.request(url: url, method: .get, parameters: parameters, success: { [weak self] (response) in
                do {
                    guard let _self = self else {return}
                    _self.currentPaging = 0
                    let responseApi = try JSONDecoder().decode(NewsSourcesModel.self, from: response)
                    let filterResult = _self.filterNewsSourceByKeyword(keyword: by, sources: responseApi.sources)
                    
                    _self.allNewsSource = filterResult
                    let sources = _self.fetchPagingNewsSource(page: _self.currentPaging)
                    _self.presenter?.successFetchedNewsSources(sources: sources)
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
    
    func loadMoreNewsSource() {
        let sources = fetchPagingNewsSource(page: self.currentPaging)
        self.presenter?.successLoadMoreNewsSource(sources: sources)
    }
    
    
    private func fetchPagingNewsSource(page: Int) -> [Sources] {
        guard allNewsSource.count > 0 else {
            return []
        }
        
        var newsSources = [Sources]()
        
        let totalData = allNewsSource.count
        let pageSize = 10
        let minRange = page * pageSize
        var maxRange = minRange + pageSize - 1
        
        if totalData > minRange {
            if maxRange > totalData - 1 {maxRange = totalData - 1}
            
            let arrSlice = allNewsSource[minRange...maxRange]
            newsSources =  Array(arrSlice)
            self.currentPaging += 1
        }
        
        return newsSources
    }
    
    func loadMoreNewsArticles() {
        let articles = fetchPagingNewsArticles(page: self.currentPaging)
        self.presenter?.successLoadMoreNewsArticles(articles: articles)
    }
    
    
    private func fetchPagingNewsArticles(page: Int) -> [Article] {
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
