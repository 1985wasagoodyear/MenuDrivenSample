//
//  JSONPlaceholder.swift
//  Created 5/12/20
//  Using Swift 5.0
// 
//  Copyright © 2020 yu. All rights reserved.
//
//  https://github.com/1985wasagoodyear
//

import Foundation

protocol JSONPlaceholder {
    var title: String { get }
    var subtitle: String { get }
    var imageUrl: URL? { get }
}

typealias DecodablePlaceholder = JSONPlaceholder & Decodable
