//
//  API.swift
//  Created 5/12/20
//  Using Swift 5.0
// 
//  Copyright © 2020 yu. All rights reserved.
//
//  https://github.com/1985wasagoodyear
//

import Foundation

enum API: String, CaseIterable {
    case posts
    case comments
    case albums
    case photos
    case todos
    case users
    
    static let root = "https://jsonplaceholder.typicode.com/"
    
    var url: URL {
        let urlString = API.root + rawValue
        guard let url = URL(string: urlString) else {
            fatalError("API.url invalid")
        }
        return url
    }
    
    var type: JSONPlaceholder.Type {
        switch self {
        case .posts:
            return Post.self
        case .comments:
            return Comment.self
        case .albums:
            return Album.self
        case .photos:
            return Photo.self
        case .todos:
            return Todo.self
        case .users:
            return User.self
        }
    }
}

extension API {
    init?(_ int: Int) {
        let count = API.allCases.count
        guard int >= 0 && int < count else {
            return nil
        }
        self = API.allCases[int]
    }
}
