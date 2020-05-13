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

protocol JSONPlaceholder: Decodable {
    var title: String { get }
    var subtitle: String { get }
    var imageUrl: URL? { get }
}

struct AnyJSONPlaceholder {
    var title: String {
        value.title
    }
    
    var subtitle: String {
        value.subtitle
    }
    
    var imageUrl: URL? {
        value.imageUrl
    }
    
    let value: JSONPlaceholder
}
