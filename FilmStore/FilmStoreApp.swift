//
//  FilmStoreApp.swift
//  FilmStore
//
//  Created by Mehmet Ali Sevdinoğlu on 24.09.2025.
//
import SwiftUI

@main
struct FilmStoreApp: App {
    init() {
        
        let bar = UISearchBar.appearance()
        bar.searchBarStyle = .minimal
        bar.isTranslucent = false
        bar.barTintColor = .black
        bar.backgroundColor = .black
        bar.backgroundImage = UIImage()

       
        let placeholderColor = UIColor.darkGray

  
        let tf = UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        tf.backgroundColor = .white
        tf.textColor = .black
        tf.layer.cornerRadius = 12
        tf.clipsToBounds = true
        tf.attributedPlaceholder = NSAttributedString(
            string: "Ara",
            attributes: [.foregroundColor: placeholderColor]
        )

        
        let searchIcon = UIImage(systemName: "magnifyingglass")?
            .withTintColor(placeholderColor, renderingMode: .alwaysOriginal)
        bar.setImage(searchIcon, for: .search, state: .normal)

        
        let clearIcon = UIImage(systemName: "xmark.circle.fill")?
            .withTintColor(placeholderColor, renderingMode: .alwaysOriginal)
        bar.setImage(clearIcon, for: .clear, state: .normal)
    }

    var body: some Scene {
        WindowGroup {
            MovieListView()
        }
    }
}
