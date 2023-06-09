//
//  Movie.swift
//  MovieApp
//
//  Created by Aleksandr Kan on 19/03/23.
//

import Foundation

struct MovieResponse: Codable {
    
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let title: String?
    let mediaType: String?
    let originalName: String?
    let originalTitle: String?
    let posterPath: String?
    let overview: String?
    let voteCount: Int
    let releaseDate: String?
    let voteAverage: Double
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case mediaType = "media_type"
        case originalName = "original_name"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case overview
        case voteCount = "vote_count"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
    
}



