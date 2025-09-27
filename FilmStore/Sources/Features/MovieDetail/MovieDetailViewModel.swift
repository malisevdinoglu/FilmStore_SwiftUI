//
//  MovieDetailViewModel.swift
//  FilmStore
//
//  Created by Mehmet Ali Sevdinoğlu on 24.09.2025.
//

import Foundation
import Combine

@MainActor
final class MovieDetailViewModel: ObservableObject {
    @Published var movie: Movie
    @Published var amount: Int = 1
    @Published var isAdding = false
    @Published var info: String?
    @Published var didAdd = false

    private let api = APIClient()

    init(movie: Movie) {
        self.movie = movie
    }

    func increase() { amount = min(amount + 1, 20) }
    func decrease() { amount = max(amount - 1, 1) }

    func addToCart() async {
        guard !isAdding else { return }
        isAdding = true; defer { isAdding = false }
        do {
            try await api.insertMovieToCart(movie: movie, amount: amount, userName: AppConstants.userName)
            info = "Sepete eklendi"
            didAdd = true
        } catch {
            info = "Hata: \(error)"
            didAdd = false
        }
    }
}
