//
//  MainMenuViewModel.swift
//  Created 5/12/20
//  Using Swift 5.0
//
//  Copyright © 2020 yu. All rights reserved.
//
//  https://github.com/1985wasagoodyear
//

import SimpleTableViewController


import Foundation


final class ImageDownloadService {
    
    // MARK: - Properties
    
    private var enqueued = Set<String>()
    private let cache = NSCache<NSString, NSData>()
    private let session: URLSession
    private let queue: DispatchQueue
    
    // MARK: - Init
    
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
        queue = DispatchQueue(label: "ImageDownloadService", qos: .utility, attributes: .concurrent)
    }
    
    // MARK: - Method
    func downloadImage(_ urlString: String,
                       _ completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil); return
        }
        downloadImage(url, completion)
    }
    
    func downloadImage(_ url: URL,
                       _ completion: @escaping (Data?) -> Void) {
        let urlString = url.absoluteString
        let nsStr = NSString(string: urlString)
        if let nsDat = cache.object(forKey: nsStr) {
            completion(Data(referencing: nsDat))
            return
        }
        if enqueued.contains(urlString) {
            completion(nil)
            return
        }
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        enqueued.insert(urlString)
        session.dataTask(with: url) { (data, _, _) in
            guard let dat = data else {
                completion(nil)
                return
            }
            self.cache.setObject(NSData(data: dat), forKey: nsStr)
            self.enqueued.remove(urlString)
        }.resume()
    }
}

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

class MainMenuViewModel: SimpleTableViewModelProtocol {
    
    private let apiService: APIService = APIService()
    private let imageService: ImageDownloadService = ImageDownloadService()
    private var handler: ViewModelHandler?
    private(set) var currentTitle: String = ""
    
    private var items: [JSONPlaceholder] = [] {
        didSet {
            handler?()
        }
    }
    
    func bind(_ handler: @escaping ViewModelHandler) {
        self.handler = handler
    }
    
    func bindAndFire(_ handler: @escaping ViewModelHandler) {
        self.handler = handler
        handler()
    }
    
    func unbind() {
        handler = nil
    }
    
    func select(_ option: IndexPath) {
        
        func completion(_ result: Result<[JSONPlaceholder], Error>) {
            switch result {
            case .success(let items):
                self.items = items
            case .failure(let error):
                print(error)
            }
        }
        
        let row = option.row
        guard let api = API(row) else {
            self.currentTitle = ""; return
        }
        self.currentTitle = api.rawValue
        
        // TODO: - Fix this mess
        switch api {
        case .posts:
            apiService.fetch(type: [Posts].self, api: api) { result in
                completion(result.flatMap { .success($0 as [JSONPlaceholder]) })
            }
        case .comments:
            apiService.fetch(type: [Comments].self, api: api) { result in
                completion(result.flatMap { .success($0 as [JSONPlaceholder]) })
            }
        case .albums:
            apiService.fetch(type: [Albums].self, api: api) { result in
                completion(result.flatMap { .success($0 as [JSONPlaceholder]) })
            }
        case .photos:
            apiService.fetch(type: [Photos].self, api: api) { result in
                completion(result.flatMap { .success($0 as [JSONPlaceholder]) })
            }
        case .todos:
            apiService.fetch(type: [Todos].self, api: api) { result in
                completion(result.flatMap { .success($0 as [JSONPlaceholder]) })
            }
        case .users:
            apiService.fetch(type: [Users].self, api: api) { result in
                completion(result.flatMap { .success($0 as [JSONPlaceholder]) })
            }
        }
    }
    
}

extension MainMenuViewModel {
    
    var sectionCount: Int {
        1 // items.count
    }
    
    func rowCount(in section: Int) -> Int {
        items.count
    }
    
    func title(for indexPath: IndexPath) -> String {
        items[indexPath.row].title
    }
    
    func subtitle(for indexPath: IndexPath) -> String? {
        items[indexPath.row].subtitle
    }
    
    func image(for indexPath: IndexPath, _ completion: @escaping (Data?) -> Void) {
        guard let url = items[indexPath.row].imageUrl else {
            completion(nil); return
        }
        imageService.downloadImage(url, completion)
    }
    
}
