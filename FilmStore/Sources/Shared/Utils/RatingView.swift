//
//  RatingView.swift
//  FilmStore
//
//  Created by Mehmet Ali Sevdinoğlu on 24.09.2025.
//
import SwiftUI

struct RatingView: View {
    let value: Double
    var body: some View {
        let stars = Int((value / 2.0).rounded()) 
        HStack(spacing: 2) {
            ForEach(0..<5, id: \.self) { i in
                Image(systemName: i < stars ? "star.fill" : "star")
                    .imageScale(.small)
            }
        }
        .foregroundStyle(.yellow)
        .accessibilityLabel(Text("Puan \(value, specifier: "%.1f")"))
    }
}
