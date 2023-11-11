//
//  Movie.swift
//  TechTask
//
//  Created by Alexandr Bahno on 10.11.2023.
//

import Foundation

struct MovieResponse: Codable {
    let results: [Movie]
}

struct Genre: Codable{
    let id: Int
    let name: String
}

struct Movie: Codable, Identifiable {
    let id: Int?
    let title: String?
    let releaseDate: String?
    let overview: String?
    let popularity: CGFloat?
    let genres: [Genre]?
    let voteAverage: CGFloat?
    let originalLanguage: String?
    let posterPath: String?
    let backdropPath: String?
    let voteCount: Int?
    let status: String?
    let runtime,revenue: Int?
    let budget: Int?
    
    static private let yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    static private let durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour, .minute]
        return formatter
    }()
    
    var backdropURL: URL {
        return URL(string: .baseImageUrl + "\(backdropPath ?? "")")!
    }
    
    var posterURL: URL {
        return URL(string: .baseImageUrl + "\(posterPath ?? "")")!
    }
    
    var genreText: String {
        genres?.first?.name ?? "n/a"
    }
    
    var ratingText: String {
        let rating = Int(voteAverage ?? 0)
        let ratingText = (0...rating).reduce("") { (acc, _) -> String in
            return acc + "★"
        }
        return ratingText
    }
    
    var scoreText: String {
        guard ratingText.count > 0 else {
            return "n/a"
        }
        return "\(ratingText.count)/10"
    }
    
    var yearText: String {
        guard let releaseDate = self.releaseDate, let date = Utils.dateFormatter.date(from: releaseDate) else {
            return "n/a"
        }
        return Movie.yearFormatter.string(from: date)
    }
    
    var durationText: String {
        guard let runtime = self.runtime, runtime > 0 else {
            return "n/a"
        }
        return Movie.durationFormatter.string(from: TimeInterval(runtime) * 60) ?? "n/a"
    }
}
