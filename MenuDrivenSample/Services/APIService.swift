//
//  APIService.swift
//  Created 5/13/20
//  Using Swift 5.0
// 
//  Copyright © 2020 yu. All rights reserved.
//
//  https://github.com/1985wasagoodyear
//

import CommonUtils

class APIService {
    
    private let networker: NetworkService = NetworkService()
    
    func fetch<T: Decodable>(type: T.Type,
                             api: API,
                             _ completion: @escaping (Result<T, Error>) -> Void) {
        networker.dataTask(type: T.self, url: api.url, params: nil) { (result) in
            switch result {
            case .success(let items):
                completion(.success(items))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
