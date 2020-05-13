//
//  Post.swift
//  Created 5/12/20
//  Using Swift 5.0
// 
//  Copyright © 2020 yu. All rights reserved.
//
//  https://github.com/1985wasagoodyear
//

import Foundation

struct Post: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

extension Post: JSONPlaceholder {
    var subtitle: String {
        body
    }
    var imageUrl: URL? {
        nil
    }
}
