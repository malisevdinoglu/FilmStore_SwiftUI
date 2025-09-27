//
//  CartItem.swift
//  FilmStore
//
//  Created by Mehmet Ali Sevdinoğlu on 24.09.2025.
//

struct CartItem: Identifiable, Codable, Equatable {
    let cartId: Int
    let name: String
    let image: String
    let price: Int
    let category: String
    let rating: Double
    let year: Int
    let director: String
    let description: String
    let orderAmount: Int
    let userName: String
    var id: Int { cartId }
}
struct CartListResponse: Codable { let movie_cart: [CartItem] }
