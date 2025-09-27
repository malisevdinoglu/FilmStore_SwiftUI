//
//  Design.swift
//  FilmStore
//
//  Created by Mehmet Ali Sevdinoğlu on 24.09.2025.
//
import SwiftUI

enum DS {
    static let corner: CGFloat = 16
    static let spacing: CGFloat = 12
    static let shadow: CGFloat = 8

   
    static let brand    = Color.indigo
    static let accent   = Color.orange
    static let surface  = Color(UIColor.secondarySystemBackground)
    static let outline  = Color.black.opacity(0.06)

   
    static let priceFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .currency
        f.currencySymbol = "₺"
        f.maximumFractionDigits = 0
        return f
    }()
}


extension Int {
    var asTL: String { DS.priceFormatter.string(from: NSNumber(value: self)) ?? "\(self) ₺" }
}


extension View {
    func cardStyle() -> some View {
        self
            .background(DS.surface)
            .clipShape(RoundedRectangle(cornerRadius: DS.corner, style: .continuous))
            .shadow(color: DS.outline, radius: DS.shadow, y: 2)
    }
}


struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .font(.headline).bold()
            .foregroundStyle(.white)
            .background(DS.brand.opacity(configuration.isPressed ? 0.8 : 1))
            .clipShape(RoundedRectangle(cornerRadius: DS.corner, style: .continuous))
            .shadow(color: .black.opacity(0.08), radius: DS.shadow, y: 3)
            .animation(.easeInOut(duration: 0.12), value: configuration.isPressed)
    }
}
