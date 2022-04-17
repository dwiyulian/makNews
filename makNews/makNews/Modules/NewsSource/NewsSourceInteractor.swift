//
//  NewsSourceInteractor.swift
//  makNews
//
//  Created by MacBook on 15/04/22.
//

import Foundation

class NewsSourceInteractor: NewsSourceInteractorProtocol {
    var presenter: NewsSourceInteractorToPresenterProtocol?
    var network: NetworkServiceProtocol?
    var urlsApi: EndPointProtocols?
    var allNewsSource = [Sources]()
    var currentPaging: Int = 0
}


extension NewsSourceInteractor: NewsSourcePresenterToInteractorProtocol {
    
    func fetchSearchedNewsSources(genre: String) {
        
        guard let url = urlsApi?.allCategories(), let key = urlsApi?.key else {
          return
        }
        
        let parameters: [String:Any] = [
            "category": genre,
            "apiKey": key
        ]
        
        network?.request(url: url, method: .get, parameters: parameters, success: { [weak self] (response) in
                do {
                    guard let _self = self else {return}
                    let responseApi = try JSONDecoder().decode(NewsSourcesModel.self, from: response)
                    _self.allNewsSource = responseApi.sources
                    let sources = _self.fetchPagingNewsSource(page: _self.currentPaging)
                    _self.presenter?.successFetchedNewsSource(sources: sources)
                } catch {
                    print(error.localizedDescription)
                    self?.presenter?.handleErrorFetched()
                }
            }, failure: { [weak self] _ in
                self?.presenter?.handleErrorFetched()
          })
    }
    
    func loadMoreNewsSource() {
        let sources = fetchPagingNewsSource(page: self.currentPaging)
        self.presenter?.successLoadMoreNewsSource(sources: sources)
    }
    
    
    func fetchPagingNewsSource(page: Int) -> [Sources] {
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
}

