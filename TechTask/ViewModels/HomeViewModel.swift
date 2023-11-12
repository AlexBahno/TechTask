//
//  HomeViewModel.swift
//  TechTask
//
//  Created by Alexandr Bahno on 10.11.2023.
//

import Foundation
import Combine

final class HomeViewModel: ViewModelProtocol {

    typealias T = [Movie]

    private var movieService: MovieServiceProtocol
    private var cancellableSet: Set<AnyCancellable> = []

    @Published private(set) var phase: DataFetchPhase<[Movie]> = .empty
    @Published var data: [Movie] = []

    init(movieService: MovieServiceProtocol) {
        self.movieService = movieService
    }

    func getData() {
        phase = .empty
        movieService.getMoviesPublisher(from: .nowPlaying)
            .map(\.results)
            .sink(
                receiveCompletion: { [weak self] result in
                    result.error.map { error in
                        DispatchQueue.main.async {
                            self?.phase = .failure(error)
                        }
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
