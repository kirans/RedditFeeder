//
//  FeedViewModel.swift
//  RedditFeeder
//
//  Created by Kiran kumar Sanka on 8/30/21.
//

import Foundation
import Combine

protocol FeedViewModelDelegate: AnyObject {
    func reload()
}

class FeedViewModel {
    var posts:[PostViewModel] = []
    let api = API()
    var isLoading = false
    var loadmore = false
    weak var delegate: FeedViewModelDelegate?
    var cancellable: AnyCancellable?
    
    init() {
        self.load()
    }
    
    private func load() {
        guard !isLoading else {
            return
        }
        isLoading = true
        cancellable = api.listing().sink { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        } receiveValue: { newPosts in
            self.addPosts(newPosts)
            self.isLoading = false
            self.delegate?.reload()
        }
    }
    
    func loadNext() {
        guard !isLoading else {
            return
        }
        guard let after = self.posts.last?.post.after else {
            return
        }
        self.isLoading = true
        cancellable = api.listingAfter(after).sink { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
            self.isLoading = false
        } receiveValue: { newPosts in
            self.addPosts(newPosts)
            self.isLoading = false
            self.delegate?.reload()
        }
    }
    
    func addPosts(_ posts:[Post]) {
        for each in posts {
            self.posts.append(PostViewModel(with: each))
        }
    }
}
