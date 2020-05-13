//
//  ImageDownloadService.swift
//  Created 5/13/20
//  Using Swift 5.0
// 
//  Copyright © 2020 yu. All rights reserved.
//
//  https://github.com/1985wasagoodyear
//

import Foundation

public final class ImageDownloadService {
    
    private var enqueued = Set<String>()
    private let cache = NSCache<NSString, NSData>()
    private let session: URLSession
    private let queue: DispatchQueue
    
    public init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
        queue = DispatchQueue(label: "ImageDownloadService", qos: .utility, attributes: .concurrent)
    }
    
    public func download(_ urlString: String,
                         _ completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil); return
        }
        download(url, completion)
    }
    
    public func download(_ url: URL,
                         _ completion: @escaping (Data?) -> Void) {
        let urlString = url.absoluteString
        let nsStr = NSString(string: urlString)
        if let nsDat = cache.object(forKey: nsStr) {
            completion(Data(referencing: nsDat))
            return
        }
        queue.sync(flags: .barrier) {
            if enqueued.contains(urlString) {
                completion(nil)
                return
            }
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        _ = queue.sync(flags: .barrier) {
            enqueued.insert(urlString)
        }
        session.dataTask(with: url) { (data, _, _) in
            guard let dat = data else {
                completion(nil)
                return
            }
            self.cache.setObject(NSData(data: dat), forKey: nsStr)
            
            _ = self.queue.sync(flags: .barrier) {
                self.enqueued.remove(urlString)
            }
        }.resume()
    }
    
}
