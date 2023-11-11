//
//  MovieDetailViewModel.swift
//  TechTask
//
//  Created by Alexandr Bahno on 11.11.2023.
//

import Foundation
import Combine

class MovieDetailViewModel: ObservableObject {
    
    private var apiCaller = MovieAPI.shared
    private var cancellableSet: Set<AnyCancellable> = []
    
    @Published private(set) var phase: DataFetchPhase<Movie> = .empty
    @Published var movie: Movie?
    
    init() {}
    
    func getMovie(for id: Int) {
        phase = .empty
        apiCaller.getMovieDetailPublisher(for: id)
            .sink(
                receiveCompletion: { [weak self] result in
                    DispatchQueue.main.async {
                        result.error.map{self?.phase = .failure($0)}
                    }
                },
                receiveValue: { [weak self] result in
                    DispatchQueue.main.async {
                        self?.phase = .success(result)
                        self?.movie = result
                    }
                }
            ).store(in: &cancellableSet)
    }
}
