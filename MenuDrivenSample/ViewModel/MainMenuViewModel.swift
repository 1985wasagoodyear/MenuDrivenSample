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

struct Item {
    let title: String
}

class MainMenuViewModel: SimpleTableViewModelProtocol {
    
    private var handler: ViewModelHandler?
    
    private var items: [Item] = [] {
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
    
    func select(_ option: API) {
        
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
    
}
