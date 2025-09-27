//
//  APIClient.swift
//  FilmStore
//
//  Created by Mehmet Ali Sevdinoğlu on 24.09.2025.
//

import Foundation

enum APIError: Error { case invalidResponse, network(Error), decoding, server(String) }

struct APIMessageResponse: Codable {
    let success: Int?
    let message: String?
}


private func formBody(_ params: [String: String]) -> Data {
    let pairs = params.map { key, value in
        let k = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? key
        let v = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? value
        return "\(k)=\(v)"
    }
    .joined(separator: "&")
    return Data(pairs.utf8)
}

final class APIClient {
    static let shared = APIClient()
    private let session = URLSession.shared


    func getAllMovies() async throws -> [Movie] {
        let url = AppConstants.baseURL.appendingPathComponent(Endpoints.allMovies)
        let (data, resp) = try await session.data(from: url)
        guard let http = resp as? HTTPURLResponse, (200...299).contains(http.statusCode) else { throw APIError.invalidResponse }
        do {
            let decoded = try JSONDecoder().decode(MovieListResponse.self, from: data)
            return decoded.movies
        } catch { throw APIError.decoding }
    }


    func insertMovieToCart(movie: Movie, amount: Int, userName: String) async throws {
        let url = AppConstants.baseURL.appendingPathComponent(Endpoints.insertMovie)
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")

        let params: [String: String] = [
            "name": movie.name,
            "image": movie.image,
            "price": String(movie.price),
            "category": movie.category,
            "rating": String(movie.rating),
            "year": String(movie.year),
            "director": movie.director,
            "description": movie.description,
            "orderAmount": String(amount),
            "userName": userName
        ]
        req.httpBody = formBody(params)

        do {
            let (data, resp) = try await session.data(for: req)
            guard let http = resp as? HTTPURLResponse, (200...299).contains(http.statusCode) else { throw APIError.invalidResponse }
            let msg = try? JSONDecoder().decode(APIMessageResponse.self, from: data)
            if let m = msg, m.success == 1 { return }
            throw APIError.server(msg?.message ?? "Insert failed")
        } catch { throw (error as? APIError) ?? .network(error) }
    }

    
    func getCart(userName: String) async throws -> [CartItem] {
        let url = AppConstants.baseURL.appendingPathComponent(Endpoints.getCart)
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        req.httpBody = formBody(["userName": userName])

        let (data, resp) = try await session.data(for: req)
        guard let http = resp as? HTTPURLResponse, (200...299).contains(http.statusCode) else { throw APIError.invalidResponse }
        do {
            let decoded = try JSONDecoder().decode(CartListResponse.self, from: data)
            return decoded.movie_cart
        } catch { throw APIError.decoding }
    }

   
    func deleteFromCart(cartId: Int, userName: String) async throws {
        let url = AppConstants.baseURL.appendingPathComponent(Endpoints.deleteMovie)
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        req.httpBody = formBody(["cartId": String(cartId), "userName": userName])

        let (data, resp) = try await session.data(for: req)
        guard let http = resp as? HTTPURLResponse, (200...299).contains(http.statusCode) else { throw APIError.invalidResponse }
        let msg = try? JSONDecoder().decode(APIMessageResponse.self, from: data)
        if let m = msg, m.success == 1 { return }
        throw APIError.server(msg?.message ?? "Delete failed")
    }
}


struct DeleteResponse: Decodable {
    let success: Int
    let message: String?
}

extension APIClient {

    /// Sepetten film sil (API: deleteMovie.php)
    @discardableResult
    func deleteMovie(cartId: Int, userName: String) async throws -> Bool {
        let url = AppConstants.baseURL.appendingPathComponent(Endpoints.deleteMovie)
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.setValue("application/x-www-form-urlencoded; charset=utf-8",
                     forHTTPHeaderField: "Content-Type")

        // API bu projede form-encoded bekliyor
        let body = "cartId=\(cartId)&userName=\(userName)"
        req.httpBody = body.data(using: .utf8)

        let (data, resp) = try await URLSession.shared.data(for: req)
        guard let http = resp as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }

        // { "success":1, "message":"..." } bekleniyor
        let decoded = try JSONDecoder().decode(DeleteResponse.self, from: data)
        return decoded.success == 1
    }
}
