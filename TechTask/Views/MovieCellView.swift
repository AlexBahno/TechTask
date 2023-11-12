//
//  MovieCell.swift
//  TechTask
//
//  Created by Alexandr Bahno on 11.11.2023.
//

import SwiftUI

struct MovieCellView: View {

    let movie: Movie
    @StateObject var imageLoader = ImageLoader()

    var body: some View {
        HStack(alignment: .center) {
            imageView
            VStack(alignment: .leading) {
                Text(movie.title ?? "")
                Text("Rating: \(movie.scoreText) ⭐️")
                Text(movie.overview ?? "")
                    .lineLimit(4)
                    .font(.system(size: 17))
                    .padding(.vertical, 2)
                Text("Release date: \(movie.releaseDate ?? "")")
            }
            Spacer()
        }
        .frame(height: 185)
        .onAppear {
            self.imageLoader.loadImage(with: movie.posterURL)
        }
    }

    private var imageView: some View {
        VStack {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
        }
    .cornerRadius(8)
    }
}
