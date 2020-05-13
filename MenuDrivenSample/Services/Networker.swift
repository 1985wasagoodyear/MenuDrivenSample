//
//  Networker.swift
//  Created 5/12/20
//  Using Swift 5.0
// 
//  Copyright © 2020 yu. All rights reserved.
//
//  https://github.com/1985wasagoodyear
//

import Foundation

enum NetworkError: Error {
    case unknownError
    case connectionError
    case invalidCredentials
    case invalidRequest
    case notFound
    case invalidResponse(Error)
    case serverError
    case serverUnavailable
    case timeOut
    case unsupportedURL
    case emptyResult
}

enum HTTPVerb: String {
    case GET
    case PUT
    case POST
}

final class NetworkService {
    
    // MARK: - Properties
    
    fileprivate var session: URLSession
    
    // MARK: - Initialization
    
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    init(_ session: URLSession) {
        self.session = session
    }
    
    // MARK: - Endpoint Accessors
    
    func dataTask<T: Decodable>(type: T.Type,
                                url: URL,
                                verb: HTTPVerb = .GET,
                                params: [String: String]?,
                                completion: @escaping (Result<T, NetworkError>) -> Void) {
        dataTaskHelper(type: T.self,
                       url: url,
                       verb: verb,
                       params: params) {
                        completion($0)
        }
    }
    
    private func dataTaskHelper<T: Decodable>(type: T.Type,
                                              url: URL,
                                              verb: HTTPVerb,
                                              params: [String: String]?,
                                              completion: @escaping (Result<T, NetworkError>) -> Void) {
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = params
        urlRequest.httpMethod = verb.rawValue
        session.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                completion(Result.failure(.connectionError))
                return
            }
            guard response != nil else {
                completion(Result.failure(.serverError))
                return
            }
            guard let data = data else {
                completion(Result.failure(.emptyResult))
                return
            }
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(Result.success(result))
            } catch let err {
                completion(Result.failure(.invalidResponse(err)))
            }
        }.resume()
    }
}
