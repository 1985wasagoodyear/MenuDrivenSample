//
//  Album.swift
//  Created 5/12/20
//  Using Swift 5.0
// 
//  Copyright © 2020 yu. All rights reserved.
//
//  https://github.com/1985wasagoodyear
//

import Foundation

struct Album: Decodable {
    let userId: Int
    let id: Int
    let title: String
}

extension Album: JSONPlaceholder {
    var subtitle: String {
        "Album \(userId), Track \(id)"
    }
    var imageUrl: URL? {
        nil
    }
}
