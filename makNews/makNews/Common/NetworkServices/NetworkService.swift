//
//  NetworkService.swift
//  makNews
//
//  Created by MacBook on 14/04/22.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol{
    func request(url: String, method: HTTPMethod, parameters: Parameters?, success: @escaping (Data) -> Void, failure: @escaping(_ error: String) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func request(url: String, method: HTTPMethod, parameters: Parameters?, success: @escaping (Data) -> Void, failure: @escaping (String) -> Void) {
        
        guard var url = URLComponents(string: url)else {
          failure("Error create URL")
          return
        }
        
        var parameters = parameters
        
        if let parametersPassed = parameters, method == .get {
          let queryItens = parametersPassed.map { URLQueryItem(name: $0.key, value: ($0.value as? String)) }
          url.queryItems = queryItens
          parameters = nil
        }
        
//        AF.request.responseDecodable(decoder: decoder, completionHandler: { (response: DataResponse<T>) in
//
//            switch response.result {
//            case .success:
//                if let data = response.data {
//                    success(data)
//                }
//                case .failure(let error):
//                    failure(error.localizedDescription)
//            }
//
//        })
        
        AF.request(url, method: method, parameters: parameters).validate().responseJSON(completionHandler: { response in
          switch response.result {
          case .success:
            if let data = response.data {
              success(data)
            }
          case .failure(let error):
            failure(error.localizedDescription)
          }
        })
        
    }
    
}

