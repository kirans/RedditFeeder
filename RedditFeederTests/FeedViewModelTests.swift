//
//  FeedViewModelTests.swift
//  RedditFeederTests
//
//  Created by Kiran kumar Sanka on 8/30/21.
//

import XCTest

class FeedViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testPosts() {
        let feedViewModel = FeedViewModel()
        XCTAssert(feedViewModel.posts.count == 0, "invalid  posts counts")
    }
    
    func testPostCount() {
        let post = Post(id: "id", title: "title", author: "author", url: "url", subredditNamePrefixed: "", thumbnail: "", after: "")
        let post1 = Post(id: "id1", title: "title1", author: "author1", url: "url1", subredditNamePrefixed: "", thumbnail: "", after: "")
        let feedViewModel = FeedViewModel()
        feedViewModel.addPosts([post, post1])
        XCTAssert(feedViewModel.posts.count == 2, "invalid  posts counts")

    }
}
