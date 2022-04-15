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
                  let responseApi = try JSONDecoder().decode(NewsSourcesModel.self, from: response)
                    self?.presenter?.successFetchedNewsSource(sources: responseApi.sources)
                } catch {
                    print(error.localizedDescription)
                    self?.presenter?.handleErrorFetched()
                }
            }, failure: { [weak self] _ in
                self?.presenter?.handleErrorFetched()
          })
    }
}
