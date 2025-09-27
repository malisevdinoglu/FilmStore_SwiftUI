//
//  States.swift
//  FilmStore
//
//  Created by Mehmet Ali Sevdinoğlu on 26.09.2025.
//
import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView("Yükleniyor…")
            .padding()
    }
}

struct ErrorView: View {
    let message: String
    let retry: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.largeTitle)
                .foregroundStyle(.orange)
            Text("Bir hata oluştu").font(.headline)
            Text(message).font(.subheadline).foregroundStyle(.secondary)
            Button("Tekrar Dene", action: retry)
                .buttonStyle(PrimaryButtonStyle())
                .padding(.top, 4)
        }
        .padding()
    }
}

struct EmptyViewState: View {
    let title: String
    let message: String
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "film")
                .font(.largeTitle)
                .foregroundStyle(.secondary)
            Text(title).font(.headline)
            Text(message)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}
