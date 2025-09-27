//
//  Movie.swift
//  FilmStore
//
//  Created by Mehmet Ali Sevdinoğlu on 24.09.2025.
//
struct Movie: Identifiable, Codable, Equatable {
    let id: Int
    let name: String
    let image: String
    let price: Int
    let category: String
    let rating: Double
    let year: Int
    let director: String
    let description: String
}
struct MovieListResponse: Codable { let movies: [Movie] }
