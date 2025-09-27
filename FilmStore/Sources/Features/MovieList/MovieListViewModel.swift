//
//  MovieListViewModel.swift
//  FilmStore
//
//  Created by Mehmet Ali Sevdinoğlu on 24.09.2025.
//
import Foundation

@MainActor
final class MovieListViewModel: ObservableObject {
    @Published var state: ViewState<[Movie]> = .idle

    private let api = APIClient()

    func load() async {
        state = .loading
        do {
            let movies = try await api.getAllMovies()
            state = .loaded(movies)
        } catch {
            state = .failed(error)
        }
    }
}
