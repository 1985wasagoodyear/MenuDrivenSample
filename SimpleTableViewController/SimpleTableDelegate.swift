//
//  SimpleTableDelegate.swift
//  Created 5/12/20
//  Using Swift 5.0
// 
//  Copyright © 2020 yu. All rights reserved.
//
//  https://github.com/1985wasagoodyear
//

import Foundation

public protocol SimpleTableDelegate: AnyObject {
    func didSelect(at indexPath: IndexPath)
}
