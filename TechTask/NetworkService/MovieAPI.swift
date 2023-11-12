//
//  MovieAPI.swift
//  TechTask
//
//  Created by Alexandr Bahno on 10.11.2023.
//

import Foundation
import Combine

class MovieAPI: MovieServiceProtocol {

    static let shared: MovieAPI = MovieAPI()

    private init() {}

    private var urlSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.urlCache = URLCache.shared
        config.waitsForConnectivity = true
        config.requestCachePolicy = .returnCacheDataElseLoad
        return URLSession(configuration: config, delegate: nil, delegateQueue: nil)
    }()
    private let jsonDecoder = Utils.jsonDecoder

    private func createPublisher<T: Codable>(for url: URL) -> AnyPublisher<T, Error> {
        return urlSession.dataTaskPublisher(for: url)
            .map({$0.data})
            .decode(type: T.self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }

    func getMoviesPublisher(from endpoint: MovieListEndpoint) -> AnyPublisher<MovieResponse, Error> {
        let url = URL.movies(for: endpoint)
        return createPublisher(for: url)
    }

    func getMovieDetailPublisher(for id: Int) -> AnyPublisher<Movie, Error> {
        let url = URL.movie(with: id)
        return createPublisher(for: url)
    }
}
