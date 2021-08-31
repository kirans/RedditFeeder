//
//  PostViewModel.swift
//  RedditFeeder
//
//  Created by Kiran kumar Sanka on 8/30/21.
//

import Foundation
import UIKit
import Combine

protocol PostViewModelDelegate: AnyObject {
    func reload()
}
class PostViewModel {
    let api = API()
    let post: Post
    var feedImage: UIImage?
    var cancellable: AnyCancellable?

    weak var delegate: PostViewModelDelegate?
    
    init(with post: Post) {
        self.post = post
        self.loadImage()
    }
    
    /// download thumnail image
    func loadImage() {
        cancellable = api.download(url: post.thumbnail).sink { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        } receiveValue: { image in
            print(image)
            self.feedImage = image
            DispatchQueue.main.async {
                self.delegate?.reload()
            }
        }
    }
    
    var commentCount:String  {
        return "Comment: " + (String(self.post.commentCount ?? 0))
    }

    var score: String {
        return "Score: " + String(self.post.score ?? 0)
    }

}
