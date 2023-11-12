//
//  MovieDetail.swift
//  TechTask
//
//  Created by Alexandr Bahno on 11.11.2023.
//

import SwiftUI

struct MovieDetailView<ViewModel>: View where ViewModel: MovieDetailViewModel {

    @ObservedObject var viewModel: ViewModel
    @StateObject private var imageLoader = ImageLoader()

    var body: some View {
        List {
            if let movie = viewModel.data {
                imageView
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .listRowSeparator(.hidden)
                    .onAppear {
                        self.imageLoader.loadImage(with: movie.backdropURL)
                    }
                    .navigationTitle(movie.title ?? "")
                Text("\(movie.genreText) · \(movie.yearText) · \(movie.durationText)")
                    .listRowSeparator(.hidden)
                Text(movie.overview ?? "")
                    .listRowSeparator(.hidden)
                HStack {
                    Text(movie.ratingText)
                        .foregroundColor(.yellow)
                    Text(movie.scoreText)
                }
            }
        }
        .listStyle(.plain)
        .task {
            self.loadMovie()
        }
    }

    var imageView: some View {
        VStack {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
            }
        }
        .aspectRatio(16/9, contentMode: .fit)
    }

    private func loadMovie() {
        viewModel.getData()
    }
}
