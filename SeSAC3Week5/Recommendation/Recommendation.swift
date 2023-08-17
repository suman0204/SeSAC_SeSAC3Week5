//
//  Recommendation.swift
//  SeSAC3Week5
//
//  Created by 홍수만 on 2023/08/17.
//

import Foundation

// MARK: - Recommendation
struct Recommendation: Codable {
    let totalResults: Int
    let results: [Movie]
    let page, totalPages: Int

    enum CodingKeys: String, CodingKey {
        case totalResults = "total_results"
        case results, page
        case totalPages = "total_pages"
    }
}

// MARK: - Result
struct Movie: Codable {
    let adult: Bool
    let originalTitle, title: String
    let posterPath: String?
    let backdropPath: String?
    let voteCount: Int
    let releaseDate: String
    let genreIDS: [Int]
    let popularity, voteAverage: Double
    let originalLanguage: String
    let overview: String
    let video: Bool
    let mediaType: MediaType
    let id: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case originalTitle = "original_title"
        case title
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case voteCount = "vote_count"
        case releaseDate = "release_date"
        case genreIDS = "genre_ids"
        case popularity
        case voteAverage = "vote_average"
        case originalLanguage = "original_language"
        case overview, video
        case mediaType = "media_type"
        case id
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case ko = "ko"
    case zh = "zh"
}
