//
//  SimpleTableViewModelProtocol.swift
//  Created 5/12/20
//  Using Swift 5.0
// 
//  Copyright © 2020 yu. All rights reserved.
//
//  https://github.com/1985wasagoodyear
//

import Foundation

public typealias ViewModelHandler = () -> Void

public protocol SimpleTableViewModelProtocol {
    
    // binding setup
    func bind(_ handler: @escaping ViewModelHandler)
    func bindAndFire(_ handler: @escaping ViewModelHandler)
    func unbind()
    
    // data-accessors
    var sectionCount: Int { get }
    func rowCount(in section: Int) -> Int
    func title(for indexPath: IndexPath) -> String
    func subtitle(for indexPath: IndexPath) -> String?
    func image(for indexPath: IndexPath, _ completion: @escaping (Data?) -> Void)
    
}
