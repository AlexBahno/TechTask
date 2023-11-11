//
//  HomeView.swift
//  TechTask
//
//  Created by Alexandr Bahno on 10.11.2023.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.movies) { movie in
                    ZStack (alignment: .leading) {
                        NavigationLink (
                            destination: MovieDetailView(id: movie.id ?? 0)
                        ) {
                            EmptyView()
                        }
                        .opacity(0)
                        MovieCellView(movie: movie)
                    }
                    .buttonStyle(.plain)
                    .listRowBackground(Color(uiColor: UIColor.systemBackground))
                }
                .listRowSeparator(.hidden)
            }
            .overlay(DataFetchPhaseOverlayView(phase: viewModel.phase, retryAction: { loadMovies() })
            )
            .refreshable { loadMovies() }
            .listStyle(.plain)
            .navigationTitle("Now Playing")
            .task {
                self.loadMovies()
            }
        }
    }
    
    private func loadMovies() {
        viewModel.getMovies(for: .nowPlaying)
    }
}

#Preview {
    HomeView()
}
