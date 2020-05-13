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
import CommonUtils

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
        imageService.download(url, completion)
    }
    
}
