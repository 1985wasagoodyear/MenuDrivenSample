//
//  Todo.swift
//  Created 5/12/20
//  Using Swift 5.0
// 
//  Copyright © 2020 yu. All rights reserved.
//
//  https://github.com/1985wasagoodyear
//

import Foundation

struct Todo: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}

extension Todo: JSONPlaceholder {
    var subtitle: String {
        completed ? "Completed" : "Not Completed"
    }
    var imageUrl: URL? {
        nil
    }
}
