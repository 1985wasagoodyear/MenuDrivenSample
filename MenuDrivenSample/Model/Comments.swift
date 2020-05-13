//
//  Comments.swift
//  Created 5/12/20
//  Using Swift 5.0
// 
//  Copyright © 2020 yu. All rights reserved.
//
//  https://github.com/1985wasagoodyear
//

import Foundation

struct Comments: Decodable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}

extension Comments: JSONPlaceholder {
    var title: String {
        name
    }
    var subtitle: String {
        body
    }
    var imageUrl: URL? {
        nil
    }
}
