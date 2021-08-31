//
//  PostViewModelTest.swift
//  RedditFeederTests
//
//  Created by Kiran kumar Sanka on 8/30/21.
//

import XCTest
import RedditFeeder


class PostViewModelTest: XCTestCase {

    var feedViewModel = FeedViewModel()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testPost() {
        let post = Post(id: "id", title: "title", author: "author", url: "url", subredditNamePrefixed: "", thumbnail: "", after: "")
        let postViewModel: PostViewModel? = PostViewModel(with: post)
        
        XCTAssert(postViewModel != nil, "post view model should not be nil")
        XCTAssert(postViewModel?.feedImage == nil, "image should be nil")
    }
}
