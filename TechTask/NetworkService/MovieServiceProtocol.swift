//
//  APIConstants.swift
//  TechTask
//
//  Created by Alexandr Bahno on 10.11.2023.
//

import Foundation
import Combine

protocol MovieServiceProtocol {

    func getMoviesPublisher(from endpoint: MovieListEndpoint) -> AnyPublisher<MovieResponse, Error>
    func getMovieDetailPublisher(for id: Int) -> AnyPublisher<Movie, Error>
}

enum MovieListEndpoint: String, CaseIterable {

    case nowPlaying = "now_playing"

    var description: String {
        switch self {
        case .nowPlaying: return "Now Playing"
        }
    }
}

enum MovieError: Error, CustomNSError {
    case apiError
    case invalidRequest
    case invalidResponse
    case serializationError

    var localizedDescription: String {
        switch self {
        case .apiError: return "Failed to fetch data"
        case .invalidRequest: return "Invalid request"
        case .invalidResponse: return "Invalid response"
        case .serializationError: return "Failed to decode data"
        }
    }
}
