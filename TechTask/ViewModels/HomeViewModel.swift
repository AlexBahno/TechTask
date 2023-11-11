//
//  HomeViewModel.swift
//  TechTask
//
//  Created by Alexandr Bahno on 10.11.2023.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    private var apiCaller = MovieAPI.shared
    private var cancellableSet: Set<AnyCancellable> = []
    
    @Published private(set) var phase: DataFetchPhase<[Movie]> = .empty
    @Published var movies: [Movie] = []
    
    init() {}
    
    func getMovies(for endpoint: MovieListEndpoint)  {
        phase = .empty
        apiCaller.getMoviesPublisher(from: endpoint)
            .map(\.results)
            .sink(
                receiveCompletion: { [weak self] result in
                    result.error.map{ error in
                        DispatchQueue.main.async {
                            self?.phase = .failure(error)
                        }
                    }
                },
                receiveValue: { [weak self] result in
                    DispatchQueue.main.async {
                        self?.phase = .success(result)
                        self?.movies = result
                    }
                }
            )
            .store(in: &cancellableSet)
    }
}
