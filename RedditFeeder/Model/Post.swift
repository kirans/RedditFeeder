//
//  Post.swift
//  RedditFeeder
//
//  Created by Kiran kumar Sanka on 8/27/21.
//

import Foundation

struct Post: Identifiable {
    var id: String
    var title: String
    var author: String
    var url: String
    var subredditNamePrefixed: String
    var thumbnail: String
    var after: String?
    
    mutating func setAfter(_ after: String) {
        self.after = after
    }
}

// MARK: - Decodable

extension Post: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case author
        case url
        case thumbnail
        case subredditNamePrefixed = "subreddit_name_prefixed"
        
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        //load nested child data container
        let dataContainer = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        
        id = try dataContainer.decode(String.self, forKey: .id)
        title = try dataContainer.decode(String.self, forKey: .title)
        author = try dataContainer.decode(String.self, forKey: .author)
        url = try dataContainer.decode(String.self, forKey: .url)
        thumbnail = try dataContainer.decode(String.self, forKey: .thumbnail)
        subredditNamePrefixed = try dataContainer.decode(String.self, forKey: .subredditNamePrefixed)
    }
}
