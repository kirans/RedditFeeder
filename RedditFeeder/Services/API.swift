//
//  ServicesViewModel.swift
//  RedditFeeder
//
//  Created by Kiran kumar Sanka on 8/27/21.
//

import Foundation
import Combine
import UIKit

//enum GameError: Error {
//  case statusCode
//  case decoding
//  case invalidImage
//  case invalidURL
//  case other(Error)
//
//  static func map(_ error: Error) -> GameError {
//    return (error as? GameError) ?? .other(error)
//  }
//}

struct API {
    
    /// API Errors
    /// List all errors that can be retrieved by URLSession
    enum FeedError: Error {
        case statusCode
        case addressUnreachable(URL)
        case invalidResponse
        case invalidImage
        case invalidURL
        case other(Error)

        var errorDescription: String? {
            switch self {
            case .statusCode:
                return "Invalid StatusCode"
            case .invalidResponse:
                return "Invalid response from the server"
            case .addressUnreachable(let url):
                return "Unreachable URL: \(url.absoluteString)"
            case .invalidImage:
                return "Invalid image for URL"
            case .other(let error):
                return "error \(error.localizedDescription)"
            case .invalidURL:
                return "Invalid URL"
            }
        }
        
        static func map(_ error: Error) -> API.FeedError {
            return (error as? FeedError) ?? .other(error)
        }

    }
    
    /// API Endpoints
    /// Define all endpoints for the API
    enum EndPoint {
        static let baseURL = "https://www.reddit.com/"
        
        case listing
        case listingAfter(String)
        
        var url:URL {
            switch self {
            case .listing:
                return URL(string: EndPoint.baseURL+".json")!
            case .listingAfter(let after):
                let urlString = EndPoint.baseURL + ".json?after=" + after
                return URL(string: urlString)!
            }
        }
    }
    
    /// Private decoder for JSON decoding
    private let decoder = JSONDecoder()

    /// Specify the scheduler that manages the responses
    private let apiQueue = DispatchQueue(label: "ListingFeedAPI",
                                         qos: .default,
                                         attributes: .concurrent)
    
    
    //MARK: - API Methods
    
    /// Retrieve the publisher for listing  feed
    func listing() -> AnyPublisher<[Post], FeedError> {
        URLSession.shared
            .dataTaskPublisher(for: EndPoint.listing.url)
            .receive(on: apiQueue)
            .map(\.data)
            .decode(type: Listing.self, decoder: decoder)
            .catch { _ in Empty<Listing, FeedError>() }
            .map(\.posts)
            .eraseToAnyPublisher()
    }
    
    /// Retrieve the publisher for listing  after
    func listingAfter(_ after: String) -> AnyPublisher<[Post], FeedError> {
        URLSession.shared
            .dataTaskPublisher(for: EndPoint.listingAfter(after).url)
            .receive(on: apiQueue)
            .map(\.data)
            .decode(type: Listing.self, decoder: decoder)
            .catch { _ in Empty<Listing, FeedError>() }
            .map(\.posts)
            .eraseToAnyPublisher()
    }

    func download(url: String) -> AnyPublisher<UIImage, Error> {
      guard let url = URL(string: url) else {
        return Fail(error: FeedError.invalidURL)
          .eraseToAnyPublisher()
      }
      return URLSession.shared.dataTaskPublisher(for: url)
        .tryMap { response -> Data in
          guard
            let httpURLResponse = response.response as? HTTPURLResponse,
            httpURLResponse.statusCode == 200
            else {
              throw FeedError.statusCode
          }
          
          return response.data
        }
        .tryMap { data in
          guard let image = UIImage(data: data) else {
            throw FeedError.invalidImage
          }
          return image
        }
        .mapError { FeedError.map($0) }
        .eraseToAnyPublisher()
    }

}
