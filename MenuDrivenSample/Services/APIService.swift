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

typealias PlaceholderResult = Result<[JSONPlaceholder], Error>
typealias PlaceholderAPIHandler = (PlaceholderResult) -> Void

class APIService {
    
    private let networker: NetworkService = NetworkService()
    
    private func fetch<T: Decodable>(type: T.Type,
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
    
    func fetch(api: API,
               _ completion: @escaping PlaceholderAPIHandler) {
        switch api {
        case .posts:
            fetch(type: [Post].self,
                    api: api) { result in
                completion(result.flatMap { .success($0 as [JSONPlaceholder]) })
            }
        case .comments:
            fetch(type: [Comment].self,
                    api: api) { result in
                completion(result.flatMap { .success($0 as [JSONPlaceholder]) })
            }
        case .albums:
            fetch(type: [Album].self,
                  api: api) { result in
                completion(result.flatMap { .success($0 as [JSONPlaceholder]) })
            }
        case .photos:
            fetch(type: [Photo].self,
                  api: api) { result in
                completion(result.flatMap { .success($0 as [JSONPlaceholder]) })
            }
        case .todos:
            fetch(type: [Todo].self,
                  api: api) { result in
                completion(result.flatMap { .success($0 as [JSONPlaceholder]) })
            }
        case .users:
            fetch(type: [User].self,
                  api: api) { result in
                completion(result.flatMap { .success($0 as [JSONPlaceholder]) })
            }
        }
    }
    
}
