//
//  Photos.swift
//  Created 5/12/20
//  Using Swift 5.0
// 
//  Copyright © 2020 yu. All rights reserved.
//
//  https://github.com/1985wasagoodyear
//

import Foundation

struct Photos: Decodable {
    let albumId: Int
    let id: Int
    let title: String
    let url: URL
    let thumbnailUrl: URL
}

extension Photos: JSONPlaceholder {
    var subtitle: String {
        "Album \(albumId), number \(id)"
    }
    var imageUrl: URL? {
        thumbnailUrl
    }
}
