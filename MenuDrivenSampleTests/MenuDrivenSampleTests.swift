//
//  MenuDrivenSampleTests.swift
//  Created 5/12/20
//  Using Swift 5.0
// 
//  Copyright © 2020 yu. All rights reserved.
//
//  https://github.com/1985wasagoodyear
//

import XCTest
@testable import MenuDrivenSample

final class MenuDrivenSampleTests: XCTestCase {

    func testCanLoadPosts() {
        // Arrange
        let mock = { try MockAPI(.posts) }
        
        // Act
        var posts: [Post] = []
        do {
            posts = try mock().load(type: Post.self)
        } catch {
            XCTFail("could not decode \(error)")
        }
        
        // Assert
        XCTAssertFalse(posts.isEmpty)
        XCTAssertEqual(posts.count, 100)
    }
    
    func testCanLoadComments() {
        // Arrange
        let mock = { try MockAPI(.comments) }
        
        // Act
        var comments: [Comment] = []
        do {
            comments = try mock().load(type: Comment.self)
        } catch {
            XCTFail("could not decode \(error)")
        }
        
        // Assert
        XCTAssertFalse(comments.isEmpty)
        XCTAssertEqual(comments.count, 500)
    }
    
    func testCanLoadAlbums() {
        // Arrange
        let mock = { try MockAPI(.albums) }
        
        // Act
        var albums: [Album] = []
        do {
            albums = try mock().load(type: Album.self)
        } catch {
            XCTFail("could not decode \(error)")
        }
        
        // Assert
        XCTAssertFalse(albums.isEmpty)
        XCTAssertEqual(albums.count, 100)
    }
    
    func testCanLoadPhotos() {
        // Arrange
        let mock = { try MockAPI(.photos) }
        
        // Act
        var photos: [Photo] = []
        do {
            photos = try mock().load(type: Photo.self)
        } catch {
            XCTFail("could not decode \(error)")
        }
        
        // Assert
        XCTAssertFalse(photos.isEmpty)
        XCTAssertEqual(photos.count, 5000)
    }
    
    func testCanLoadTodos() {
        // Arrange
        let mock = { try MockAPI(.todos) }
        
        // Act
        var todos: [Todo] = []
        do {
            todos = try mock().load(type: Todo.self)
        } catch {
            XCTFail("could not decode \(error)")
        }
        
        // Assert
        XCTAssertFalse(todos.isEmpty)
        XCTAssertEqual(todos.count, 200)
    }
    
    func testCanLoadUsers() {
        // Arrange
        let mock = { try MockAPI(.users) }
        
        // Act
        var users: [User] = []
        do {
            users = try mock().load(type: User.self)
        } catch {
            XCTFail("could not decode \(error)")
        }
        
        // Assert
        XCTAssertFalse(users.isEmpty)
        XCTAssertEqual(users.count, 10)
    }
    
}
