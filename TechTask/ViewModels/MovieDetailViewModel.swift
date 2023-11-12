//
//  MovieDetailViewModel.swift
//  TechTask
//
//  Created by Alexandr Bahno on 11.11.2023.
//

import Foundation
import Combine

final class MovieDetailViewModel: ViewModelProtocol {

    typealias T = Movie?

    private var movieService: MovieServiceProtocol
    private var cancellableSet: Set<AnyCancellable> = []
    private var movieId: Int

    @Published private(set) var phase: DataFetchPhase<Movie> = .empty
    @Published var data: Movie?

    init(movieService: MovieServiceProtocol, movieId: Int) {
        self.movieService = movieService
        self.movieId = movieId
    }

    func getData() {
        phase = .empty
        movieService.getMovieDetailPublisher(for: movieId)
            .sink(
                receiveCompletion: { [weak self] result in
                    DispatchQueue.main.async {
                        result.error.map { self?.phase = .failure($0) }
                    }
                },
                receiveValue: { [weak self] result in
                    DispatchQueue.main.async {
                        self?.phase = .success(result)
                        self?.data = result
                    }
                }
            ).store(in: &cancellableSet)
    }
}
