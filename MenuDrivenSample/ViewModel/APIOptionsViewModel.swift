//
//  APIOptionsViewModel.swift
//  Created 5/12/20
//  Using Swift 5.0
// 
//  Copyright © 2020 yu. All rights reserved.
//
//  https://github.com/1985wasagoodyear
//

import SimpleTableViewController

class APIOptionsViewModel: SimpleTableViewModelProtocol {
    
    private var handler: ViewModelHandler?
    
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
    
    var sectionCount: Int {
        1
    }
    
    func rowCount(in section: Int) -> Int {
        API.allCases.count
    }
    
    func title(for indexPath: IndexPath) -> String {
        API.allCases[indexPath.row].rawValue
    }
    
    func subtitle(for indexPath: IndexPath) -> String? {
        nil
    }
    
    func image(for indexPath: IndexPath, _ completion: @escaping (Data?) -> Void) {
        return
    }
    
}
