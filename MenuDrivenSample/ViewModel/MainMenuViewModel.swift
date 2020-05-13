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
        guard let api = API(option.row) else {
            currentTitle = ""; return
        }
        currentTitle = api.rawValue
        fetch(api)
    }
    
    private func fetch(_ api: API) {
        apiService.fetch(api: api) { result in
            switch result {
            case .success(let items):
                self.items = items
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension MainMenuViewModel {
    
    var sectionCount: Int {
        1
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
