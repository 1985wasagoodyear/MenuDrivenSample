//
//  MockAPI.swift
//  Created 5/12/20
//  Using Swift 5.0
// 
//  Copyright © 2020 yu. All rights reserved.
//
//  https://github.com/1985wasagoodyear
//

import Foundation
@testable import MenuDrivenSample

final class MockAPI {
    
    let data: Data
    let decoder: JSONDecoder
    
    init(_ api: API, decoder: JSONDecoder = JSONDecoder()) throws {
        let bundle = Bundle(for: MockAPI.self)
        let name = api.rawValue
        guard let path = bundle.path(forResource: name, ofType: "json") else {
            fatalError("'\(name).json' not found in testing bundle")
        }
        let url = URL(fileURLWithPath: path)
        data = try Data(contentsOf: url)
        self.decoder = decoder
    }
    
    func load<T: DecodablePlaceholder>(type: T.Type) throws -> [T] {
        try decoder.decode([T].self, from: data)
    }
    
}
