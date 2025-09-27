//
//  ViewState.swift
//  FilmStore
//
//  Created by Mehmet Ali Sevdinoğlu on 26.09.2025.
//
import Foundation

enum ViewState<T> {
    case idle
    case loading
    case loaded(T)
    case failed(Error)
}
