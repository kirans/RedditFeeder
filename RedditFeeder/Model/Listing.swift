//
//  Listing.swift
//  RedditFeeder
//
//  Created by Kiran kumar Sanka on 8/27/21.
//

import Foundation

struct Listing {
    var posts = [Post]()
}

// MARK: - Decodable

extension Listing: Decodable {
    enum CodingKeys: String, CodingKey {
        case posts = "children"
        case after
        
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let data = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        let after = try? data.decode(String.self, forKey: .after)
        
        let listPosts = try data.decode([Post].self, forKey: .posts)
        for var post in listPosts {
            post.after = after
            self.posts.append(post)
        }
    }
}
