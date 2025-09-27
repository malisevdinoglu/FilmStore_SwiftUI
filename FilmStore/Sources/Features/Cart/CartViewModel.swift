//
//  CartViewModel.swift
//  FilmStore
//
//  Created by Mehmet Ali Sevdinoğlu on 24.09.2025.
//

import Foundation
import Combine

@MainActor
final class CartViewModel: ObservableObject {
    @Published private(set) var rawItems: [CartItem] = []
    @Published private(set) var displayItems: [CartDisplayItem] = []
    @Published var isLoading = false
    @Published var error: String?

    // UI’de göstereceğimiz satır
    struct CartDisplayItem: Identifiable, Hashable {
        let id: String                  // composite key
        let name: String
        let image: String
        let price: Int
        let totalAmount: Int            // toplam adet (toplanmış)
        let cartIds: [Int]              // bu gruba ait tüm cartId’ler
    }

    var total: Int {
        displayItems.reduce(0) { $0 + $1.price * $1.totalAmount }
    }

    func load() async {
        isLoading = true; error = nil
        defer { isLoading = false }
        do {
            let items = try await APIClient.shared.getCart(userName: AppConstants.userName)
            await MainActor.run {
                self.rawItems = items
                self.displayItems = Self.group(items)
            }
        }
        // —— Seçenek A: Boş sepeti hata sayma ——
        catch APIError.decoding {
            await MainActor.run {
                self.rawItems = []
                self.displayItems = []
                self.error = nil
            }
        }
        catch APIError.server {
            await MainActor.run {
                self.rawItems = []
                self.displayItems = []
                self.error = nil
            }
        }
        // Gerçek hataları göstermeye devam et
        catch {
            await MainActor.run { self.error = error.localizedDescription }
        }
    }

    // Aynı film(ler)i tek satırda topla
    private static func group(_ items: [CartItem]) -> [CartDisplayItem] {
        var dict: [String:(name:String,image:String,price:Int,amount:Int,ids:[Int])] = [:]

        for i in items {
            let key = "\(i.name)|\(i.image)|\(i.price)"   // aynı filmi belirleyen anahtar
            var entry = dict[key] ?? (i.name, i.image, i.price, 0, [])
            entry.amount += i.orderAmount
            entry.ids.append(i.cartId)
            dict[key] = entry
        }

        return dict.map { (key, v) in
            CartDisplayItem(
                id: key,
                name: v.name,
                image: v.image,
                price: v.price,
                totalAmount: v.amount,
                cartIds: v.ids
            )
        }
        .sorted { $0.name < $1.name }
    }

    // Gruplanmış bir satırı sil: gruptaki tüm cartId’leri sil
    func delete(_ item: CartDisplayItem) async {
        isLoading = true
        defer { isLoading = false }
        for id in item.cartIds {
            _ = try? await APIClient.shared.deleteMovie(cartId: id, userName: AppConstants.userName)
        }
        await load()
    }
}
