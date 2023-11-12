//
//  URL.swift
//  TechTask
//
//  Created by Alexandr Bahno on 11.11.2023.
//

import Foundation

extension URL {

    private static let apiKey = "e9ade1c8f31d8c1b38c20c378c15f594"

    static var nowPlaying: URL {
        get {
            URL(string: .baseUrl + "/movie/now_playing?api_key=\(apiKey)&language=en-US&page=1")!
        }
    }
    static func movie(with id: Int) -> URL {
        return URL(string: .baseUrl + "/movie/\(id)?api_key=\(apiKey)&language=en-US&page=1")!
    }

    static func movies(for endpoint: MovieListEndpoint) -> URL {
        URL(string: .baseUrl + "/movie/\(endpoint.rawValue)?api_key=\(apiKey)&language=en-US&page=1")!
    }
}
