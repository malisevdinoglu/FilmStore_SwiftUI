# FilmStore - iOS Movie Shopping Application

<div align="center">

![SwiftUI](https://img.shields.io/badge/SwiftUI-iOS%2015+-blue.svg)
![Swift](https://img.shields.io/badge/Swift-5.9+-red.svg)
![MVVM](https://img.shields.io/badge/Architecture-MVVM-green.svg)
![License](https://img.shields.io/badge/License-MIT-orange.svg)

### Language / Dil
**[English](#english)** | **[Türkçe](#turkish)**

---

## English

A modern iOS movie shopping application built with SwiftUI, featuring movie browsing, detailed information, shopping cart management, and favorites functionality.

[Features](#features) • [Architecture](#architecture) • [Installation](#installation) • [Tech Stack](#tech-stack) • [Screenshots](#screenshots)

</div>

---

## 📋 Overview

FilmStore is a comprehensive movie browsing and shopping application that allows users to explore movies, view detailed information including ratings, directors, and release years, add movies to their shopping cart, manage quantities, and save favorites. The app demonstrates modern iOS development practices using SwiftUI and MVVM architecture with clean code principles.

## ✨ Features

### 🎬 Movie Browsing
- **Comprehensive Movie List**: Browse through an extensive collection of movies
- **Search Functionality**: Powerful search bar to find movies quickly
- **Movie Details**: View complete information including:
  - Movie title and poster
  - Director information
  - Release year
  - Category/Genre
  - Rating scores with visual indicators
  - Detailed plot descriptions

### 🛒 Shopping Cart Management
- **Add to Cart**: Seamlessly add movies to your shopping cart
- **Quantity Control**: Increase or decrease quantities with intuitive controls
- **Cart Overview**: View all items in your cart with total price calculation
- **Remove Items**: Easy removal of unwanted items from cart
- **Persistent Cart**: Cart data persists across app sessions

### ❤️ Favorites System
- **Save Favorites**: Mark movies as favorites for quick access
- **Favorites Collection**: Dedicated view for all your favorite movies
- **Quick Toggle**: One-tap favorite/unfavorite functionality

### 📱 Modern UI/UX
- **SwiftUI Interface**: Native, fluid iOS experience
- **Responsive Design**: Optimized for all iPhone screen sizes
- **Smooth Animations**: Polished transitions and interactions
- **Dark Mode Support**: Seamless dark/light theme adaptation
- **Custom Components**: Reusable UI components for consistency

### 🌐 API Integration
- **RESTful API**: Fetches movie data from backend services
- **Async/Await**: Modern Swift concurrency for smooth performance
- **Error Handling**: Comprehensive error management with user feedback
- **Loading States**: Visual feedback during data fetching

---

## 🏗️ Architecture

FilmStore follows the MVVM (Model-View-ViewModel) architecture pattern with clean separation of concerns:

```
┌─────────────────────────────────────────────────────┐
│                  Views (SwiftUI)                     │
│   MovieListView, MovieDetailView, CartView, etc.   │
└─────────────────────┬───────────────────────────────┘
                      │
┌─────────────────────▼───────────────────────────────┐
│                   ViewModels                         │
│    MovieListViewModel, MovieDetailViewModel, etc.   │
│              (Business Logic Layer)                  │
└─────────────────────┬───────────────────────────────┘
                      │
┌─────────────────────▼───────────────────────────────┐
│                    Models                            │
│         Movie, CartItem, User, Response              │
└─────────────────────┬───────────────────────────────┘
                      │
┌─────────────────────▼───────────────────────────────┐
│                  Networking                          │
│            APIClient, Endpoints, Services            │
└──────────────────────────────────────────────────────┘
```

### Key Components

#### 1. **Models**
```swift
struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let director: String
    let year: Int
    let category: String
    let rating: Double
    let posterURL: String
    let overview: String
}

struct CartItem: Identifiable {
    let id: UUID
    let movie: Movie
    var quantity: Int
}
```

#### 2. **ViewModels**
- **MovieListViewModel**: Manages movie list state, search, and filtering
- **MovieDetailViewModel**: Handles movie detail display and actions
- **CartViewModel**: Manages shopping cart operations and calculations
- **FavoritesViewModel**: Handles favorite movies management

#### 3. **Views**
- **MovieListView**: Main movie browsing interface
- **MovieDetailView**: Detailed movie information screen
- **CartView**: Shopping cart management interface
- **FavoritesView**: Favorite movies collection
- **SearchBar**: Custom search component

#### 4. **Networking Layer**
- **APIClient**: Generic networking client with async/await
- **Endpoints**: Type-safe API endpoint definitions
- **NetworkService**: Handles HTTP requests and responses
- **Error Handling**: Custom error types and user-friendly messages

---

## 🚀 Installation

### Prerequisites

- **Xcode 14+**
- **iOS 15.0+**
- **Swift 5.9+**
- **Internet connection** for API calls

### Setup Steps

1. **Clone the repository**
```bash
git clone https://github.com/malisevdinoglu/FilmStore_SwiftUI.git
cd FilmStore_SwiftUI
```

2. **Open in Xcode**
```bash
open FilmStore.xcodeproj
```

3. **Configure API Endpoint (if needed)**
   - Navigate to `Networking/APIClient.swift`
   - Update the base URL if using a custom backend:
   ```swift
   private let baseURL = "https://your-api-endpoint.com"
   ```

4. **Configure Signing**
   - Select your development team in `Signing & Capabilities`
   - Update Bundle Identifier if needed

5. **Build and Run**
   - Select iOS 15+ Simulator or physical device
   - Press `Cmd + R` to build and run

---

## 📱 Usage

### Browsing Movies

1. **Launch the app** - Main movie list appears
2. **Scroll through movies** - Swipe to browse the collection
3. **Use search bar** - Type to filter movies by title, director, or category
4. **Tap a movie** - View detailed information

### Managing Cart

1. **Add to Cart**: 
   - From movie detail screen, tap "Add to Cart" button
   - Movie appears in cart with quantity 1
2. **Modify Quantity**:
   - Navigate to Cart tab
   - Use + / - buttons to adjust quantities
3. **Remove Items**:
   - Swipe left on cart item
   - Tap delete button
4. **View Total**:
   - Cart automatically calculates total price

### Favorites

1. **Mark as Favorite**:
   - Tap heart icon on movie detail or list item
   - Heart fills to indicate favorite status
2. **View Favorites**:
   - Navigate to Favorites tab
   - See all your saved movies
3. **Remove from Favorites**:
   - Tap filled heart icon to unfavorite

---

## 🛠️ Tech Stack

| Category | Technology |
|----------|-----------|
| **UI Framework** | SwiftUI |
| **Architecture** | MVVM (Model-View-ViewModel) |
| **Programming Language** | Swift 5.9+ |
| **Async Operations** | Async/Await, Combine |
| **Networking** | URLSession, Codable |
| **Data Persistence** | UserDefaults (Cart & Favorites) |
| **Dependency Management** | Swift Package Manager |
| **Design Patterns** | Repository Pattern, Dependency Injection |

### Swift Features Used
- **SwiftUI**: Declarative UI framework
- **Combine**: Reactive programming for state management
- **Async/Await**: Modern concurrency for network calls
- **Property Wrappers**: @State, @StateObject, @ObservedObject
- **Codable**: JSON encoding/decoding
- **Generics**: Type-safe networking layer

---

## 📂 Project Structure

```
FilmStore/
├── FilmStoreApp.swift           # App entry point
│
├── Models/
│   ├── Movie.swift              # Movie data model
│   ├── CartItem.swift           # Shopping cart item model
│   ├── MoviesResponse.swift     # API response wrapper
│   └── ErrorResponse.swift      # Error handling models
│
├── ViewModels/
│   ├── MovieListViewModel.swift    # Movie list business logic
│   ├── MovieDetailViewModel.swift  # Movie detail logic
│   ├── CartViewModel.swift         # Cart management
│   └── FavoritesViewModel.swift    # Favorites management
│
├── Views/
│   ├── MovieList/
│   │   ├── MovieListView.swift      # Main movie list screen
│   │   ├── MovieRowView.swift       # Movie list item component
│   │   └── SearchBarView.swift      # Search bar component
│   │
│   ├── MovieDetail/
│   │   ├── MovieDetailView.swift    # Movie detail screen
│   │   └── RatingView.swift         # Rating display component
│   │
│   ├── Cart/
│   │   ├── CartView.swift           # Shopping cart screen
│   │   └── CartItemView.swift       # Cart item component
│   │
│   └── Favorites/
│       └── FavoritesView.swift      # Favorites collection screen
│
├── Networking/
│   ├── APIClient.swift              # Generic API client
│   ├── Endpoints.swift              # API endpoint definitions
│   ├── NetworkService.swift         # Network request handler
│   └── NetworkError.swift           # Network error types
│
├── Utils/
│   ├── Constants.swift              # App constants
│   ├── Extensions/
│   │   ├── Color+Extension.swift    # Color utilities
│   │   ├── View+Extension.swift     # View modifiers
│   │   └── String+Extension.swift   # String utilities
│   └── ImageCache.swift             # Image caching utility
│
└── Resources/
    ├── Assets.xcassets              # Images, colors, icons
    └── Info.plist                   # App configuration
```

---

## 🎨 Design System

### Color Palette
```swift
extension Color {
    static let primaryAccent = Color("AccentColor")
    static let background = Color("BackgroundColor")
    static let cardBackground = Color("CardBackground")
    static let textPrimary = Color("TextPrimary")
    static let textSecondary = Color("TextSecondary")
}
```

### Typography
- **Title**: Bold, 28pt
- **Headline**: Semibold, 20pt
- **Body**: Regular, 16pt
- **Caption**: Regular, 12pt

### Components
- **Movie Card**: Rounded corners, shadow, poster image
- **Rating Stars**: Custom star rating view
- **Cart Badge**: Quantity indicator on cart icon
- **Search Bar**: Custom styled search field

---

## 🔧 Configuration

### API Configuration

```swift
// APIClient.swift
struct APIClient {
    private let baseURL = "https://api.example.com"
    
    enum Endpoint {
        case movies
        case movieDetail(id: Int)
        case search(query: String)
        
        var path: String {
            switch self {
            case .movies: return "/movies"
            case .movieDetail(let id): return "/movies/\(id)"
            case .search: return "/movies/search"
            }
        }
    }
}
```

### UserDefaults Keys

```swift
enum UserDefaultsKeys {
    static let cartItems = "cartItems"
    static let favoriteMovieIDs = "favoriteMovieIDs"
    static let lastSearchQuery = "lastSearchQuery"
}
```

---

## 🎯 Features Breakdown

### Search Implementation
```swift
@Published var searchText = ""
@Published var filteredMovies: [Movie] = []

var searchResults: [Movie] {
    if searchText.isEmpty {
        return movies
    } else {
        return movies.filter { movie in
            movie.title.localizedCaseInsensitiveContains(searchText) ||
            movie.director.localizedCaseInsensitiveContains(searchText) ||
            movie.category.localizedCaseInsensitiveContains(searchText)
        }
    }
}
```

### Cart Calculation
```swift
var totalPrice: Double {
    cartItems.reduce(0) { sum, item in
        sum + (item.movie.price * Double(item.quantity))
    }
}

var totalItems: Int {
    cartItems.reduce(0) { sum, item in
        sum + item.quantity
    }
}
```

---

## 🐛 Troubleshooting

### Common Issues

**Problem**: Movies not loading
- **Solution**: Check internet connection, verify API endpoint is accessible

**Problem**: Search not working
- **Solution**: Ensure search text binding is properly connected to ViewModel

**Problem**: Cart items disappearing
- **Solution**: Verify UserDefaults persistence, check for proper encoding/decoding

**Problem**: Images not displaying
- **Solution**: Confirm image URLs are valid, check network permissions in Info.plist

**Problem**: App crashes on launch
- **Solution**: Check for missing assets, verify all @Published properties are initialized

---

## 🗺️ Roadmap

### Planned Features

- [ ] **User Authentication** with Firebase/Backend
- [ ] **Payment Integration** (Stripe, Apple Pay)
- [ ] **Order History** tracking
- [ ] **Movie Trailers** integration (YouTube API)
- [ ] **User Reviews & Ratings** system
- [ ] **Advanced Filtering** (genre, year, rating range)
- [ ] **Sorting Options** (popularity, rating, year, title)
- [ ] **Wishlist** separate from cart
- [ ] **Share Functionality** (share movies with friends)
- [ ] **Push Notifications** for new releases
- [ ] **iPad Support** with adaptive layouts
- [ ] **watchOS Companion App**
- [ ] **Offline Mode** with CoreData
- [ ] **Multi-language Support** (Localization)
- [ ] **Accessibility Improvements** (VoiceOver, Dynamic Type)

### Improvements

- [ ] Unit Tests coverage
- [ ] UI Tests automation
- [ ] Performance optimization for large lists
- [ ] Image caching improvements
- [ ] Better error handling and user feedback
- [ ] Pagination for movie lists
- [ ] Pull-to-refresh functionality
- [ ] Skeleton loading screens
- [ ] Haptic feedback

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

```
MIT License

Copyright (c) 2024 Erdem Maliş

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

### Contribution Guidelines

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Code Style

- Follow [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
- Use SwiftLint for code consistency
- Write clear, descriptive commit messages
- Add comments for complex logic
- Update documentation for new features

---

## 📧 Contact

**Developer**: Erdem Maliş

- GitHub: [@malisevdinoglu](https://github.com/malisevdinoglu)
- LinkedIn: [Erdem Maliş](https://linkedin.com/in/erdem-malis)
- Email: [Contact via GitHub](https://github.com/malisevdinoglu)

---

## 🙏 Acknowledgments

- Built with ❤️ using SwiftUI
- Inspired by modern e-commerce applications
- Thanks to the Swift and iOS development community
- Movie data provided by [Your API Source]

---

<div align="center">

**⭐ If you find this project useful, please consider giving it a star!**

Made with 💻 and ☕ by [Erdem Maliş](https://github.com/malisevdinoglu)

</div>

---
---
---

<div id="turkish"></div>

# FilmStore - iOS Film Alışveriş Uygulaması

<div align="center">

![SwiftUI](https://img.shields.io/badge/SwiftUI-iOS%2015+-blue.svg)
![Swift](https://img.shields.io/badge/Swift-5.9+-red.svg)
![MVVM](https://img.shields.io/badge/Mimari-MVVM-green.svg)
![License](https://img.shields.io/badge/Lisans-MIT-orange.svg)

**[English](#english)** | **[Türkçe](#turkish)**

SwiftUI ile geliştirilmiş, film gezinme, detaylı bilgi görüntüleme, alışveriş sepeti yönetimi ve favori özelliklerine sahip modern bir iOS film alışveriş uygulaması.

[Özellikler](#özellikler-tr) • [Mimari](#mimari-tr) • [Kurulum](#kurulum-tr) • [Teknoloji Yığını](#teknoloji-yığını-tr) • [Ekran Görüntüleri](#ekran-görüntüleri-tr)

</div>

---

## 📋 Genel Bakış

FilmStore, kullanıcıların filmleri keşfetmesine, derecelendirmeler, yönetmenler ve yayın yılları dahil detaylı bilgileri görüntülemesine, filmleri alışveriş sepetine eklemesine, miktarları yönetmesine ve favorileri kaydetmesine olanak tanıyan kapsamlı bir film gezinme ve alışveriş uygulamasıdır. Uygulama, temiz kod prensipleriyle SwiftUI ve MVVM mimarisi kullanarak modern iOS geliştirme uygulamalarını göstermektedir.

## ✨ Özellikler {#özellikler-tr}

### 🎬 Film Gezinme
- **Kapsamlı Film Listesi**: Geniş bir film koleksiyonuna göz atın
- **Arama İşlevselliği**: Filmleri hızlı bulmak için güçlü arama çubuğu
- **Film Detayları**: Şunlar dahil tam bilgileri görüntüleyin:
  - Film başlığı ve posteri
  - Yönetmen bilgisi
  - Yayın yılı
  - Kategori/Tür
  - Görsel göstergelerle derecelendirme puanları
  - Detaylı konu açıklamaları

### 🛒 Alışveriş Sepeti Yönetimi
- **Sepete Ekle**: Filmleri sorunsuz bir şekilde alışveriş sepetinize ekleyin
- **Miktar Kontrolü**: Sezgisel kontrollerle miktarları artırın veya azaltın
- **Sepet Özeti**: Toplam fiyat hesaplamasıyla sepetinizdeki tüm öğeleri görüntüleyin
- **Öğeleri Kaldır**: İstenmeyen öğelerin sepetten kolay kaldırılması
- **Kalıcı Sepet**: Sepet verileri uygulama oturumları arasında korunur

### ❤️ Favoriler Sistemi
- **Favorileri Kaydet**: Hızlı erişim için filmleri favori olarak işaretleyin
- **Favori Koleksiyonu**: Tüm favori filmleriniz için özel görünüm
- **Hızlı Değiştirme**: Tek dokunuşla favori/favoriden çıkarma işlevselliği

### 📱 Modern Arayüz/Kullanıcı Deneyimi
- **SwiftUI Arayüzü**: Yerel, akıcı iOS deneyimi
- **Duyarlı Tasarım**: Tüm iPhone ekran boyutları için optimize edilmiştir
- **Yumuşak Animasyonlar**: Cilalı geçişler ve etkileşimler
- **Koyu Mod Desteği**: Sorunsuz koyu/açık tema adaptasyonu
- **Özel Bileşenler**: Tutarlılık için yeniden kullanılabilir UI bileşenleri

### 🌐 API Entegrasyonu
- **RESTful API**: Backend servislerinden film verilerini çeker
- **Async/Await**: Sorunsuz performans için modern Swift eşzamanlılığı
- **Hata Yönetimi**: Kullanıcı geri bildirimi ile kapsamlı hata yönetimi
- **Yükleme Durumları**: Veri çekerken görsel geri bildirim

---

## 🏗️ Mimari {#mimari-tr}

FilmStore, endişelerin temiz ayrımı ile MVVM (Model-View-ViewModel) mimari desenini izler:

```
┌─────────────────────────────────────────────────────┐
│              Views (SwiftUI) - Görünümler            │
│   MovieListView, MovieDetailView, CartView, vb.    │
└─────────────────────┬───────────────────────────────┘
                      │
┌─────────────────────▼───────────────────────────────┐
│                   ViewModels                         │
│    MovieListViewModel, MovieDetailViewModel, vb.    │
│              (İş Mantığı Katmanı)                   │
└─────────────────────┬───────────────────────────────┘
                      │
┌─────────────────────▼───────────────────────────────┐
│                  Models - Modeller                   │
│         Movie, CartItem, User, Response              │
└─────────────────────┬───────────────────────────────┘
                      │
┌─────────────────────▼───────────────────────────────┐
│                Networking - Ağ İşlemleri             │
│            APIClient, Endpoints, Services            │
└──────────────────────────────────────────────────────┘
```

### Ana Bileşenler

#### 1. **Modeller**
```swift
struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let director: String
    let year: Int
    let category: String
    let rating: Double
    let posterURL: String
    let overview: String
}

struct CartItem: Identifiable {
    let id: UUID
    let movie: Movie
    var quantity: Int
}
```

#### 2. **ViewModeller**
- **MovieListViewModel**: Film listesi durumunu, aramayı ve filtrelemeyi yönetir
- **MovieDetailViewModel**: Film detay görüntülemesini ve aksiyonlarını işler
- **CartViewModel**: Alışveriş sepeti işlemlerini ve hesaplamalarını yönetir
- **FavoritesViewModel**: Favori film yönetimini işler

#### 3. **Görünümler**
- **MovieListView**: Ana film gezinme arayüzü
- **MovieDetailView**: Detaylı film bilgi ekranı
- **CartView**: Alışveriş sepeti yönetim arayüzü
- **FavoritesView**: Favori filmler koleksiyonu
- **SearchBar**: Özel arama bileşeni

#### 4. **Ağ Katmanı**
- **APIClient**: Async/await ile genel ağ istemcisi
- **Endpoints**: Tip güvenli API endpoint tanımları
- **NetworkService**: HTTP isteklerini ve yanıtlarını işler
- **Error Handling**: Özel hata tipleri ve kullanıcı dostu mesajlar

---

## 🚀 Kurulum {#kurulum-tr}

### Ön Koşullar

- **Xcode 14+**
- **iOS 15.0+**
- **Swift 5.9+**
- API çağrıları için **İnternet bağlantısı**

### Kurulum Adımları

1. **Depoyu klonlayın**
```bash
git clone https://github.com/malisevdinoglu/FilmStore_SwiftUI.git
cd FilmStore_SwiftUI
```

2. **Xcode'da açın**
```bash
open FilmStore.xcodeproj
```

3. **API Endpoint'ini Yapılandırın (gerekirse)**
   - `Networking/APIClient.swift` dosyasına gidin
   - Özel bir backend kullanıyorsanız temel URL'yi güncelleyin:
   ```swift
   private let baseURL = "https://sizin-api-endpoint.com"
   ```

4. **İmzalamayı Yapılandırın**
   - `Signing & Capabilities` bölümünde geliştirme ekibinizi seçin
   - Gerekirse Bundle Identifier'ı güncelleyin

5. **Derleyin ve Çalıştırın**
   - iOS 15+ Simülatör veya fiziksel cihaz seçin
   - Derlemek ve çalıştırmak için `Cmd + R` tuşlarına basın

---

## 📱 Kullanım

### Film Gezinme

1. **Uygulamayı başlatın** - Ana film listesi görünür
2. **Filmler arasında gezinin** - Koleksiyona göz atmak için kaydırın
3. **Arama çubuğunu kullanın** - Başlık, yönetmen veya kategoriye göre filmleri filtrelemek için yazın
4. **Bir filme dokunun** - Detaylı bilgileri görüntüleyin

### Sepeti Yönetme

1. **Sepete Ekle**: 
   - Film detay ekranından "Sepete Ekle" düğmesine dokunun
   - Film 1 miktarla sepette görünür
2. **Miktarı Değiştir**:
   - Sepet sekmesine gidin
   - Miktarları ayarlamak için + / - düğmelerini kullanın
3. **Öğeleri Kaldır**:
   - Sepet öğesinde sola kaydırın
   - Sil düğmesine dokunun
4. **Toplamı Görüntüle**:
   - Sepet otomatik olarak toplam fiyatı hesaplar

### Favoriler

1. **Favori Olarak İşaretle**:
   - Film detayında veya liste öğesinde kalp simgesine dokunun
   - Kalp favori durumunu belirtmek için dolar
2. **Favorileri Görüntüle**:
   - Favoriler sekmesine gidin
   - Tüm kaydedilmiş filmlerinizi görün
3. **Favorilerden Kaldır**:
   - Favoriden çıkarmak için dolu kalp simgesine dokunun

---

## 🛠️ Teknoloji Yığını {#teknoloji-yığını-tr}

| Kategori | Teknoloji |
|----------|-----------|
| **UI Framework** | SwiftUI |
| **Mimari** | MVVM (Model-View-ViewModel) |
| **Programlama Dili** | Swift 5.9+ |
| **Async İşlemler** | Async/Await, Combine |
| **Ağ İşlemleri** | URLSession, Codable |
| **Veri Kalıcılığı** | UserDefaults (Sepet & Favoriler) |
| **Bağımlılık Yönetimi** | Swift Package Manager |
| **Tasarım Desenleri** | Repository Deseni, Dependency Injection |

### Kullanılan Swift Özellikleri
- **SwiftUI**: Bildirimsel UI framework'ü
- **Combine**: Durum yönetimi için reaktif programlama
- **Async/Await**: Ağ çağrıları için modern eşzamanlılık
- **Property Wrappers**: @State, @StateObject, @ObservedObject
- **Codable**: JSON kodlama/çözme
- **Generics**: Tip güvenli ağ katmanı

---

## 📂 Proje Yapısı

```
FilmStore/
├── FilmStoreApp.swift           # Uygulama giriş noktası
│
├── Models/
│   ├── Movie.swift              # Film veri modeli
│   ├── CartItem.swift           # Alışveriş sepeti öğesi modeli
│   ├── MoviesResponse.swift     # API yanıt sarmalayıcı
│   └── ErrorResponse.swift      # Hata işleme modelleri
│
├── ViewModels/
│   ├── MovieListViewModel.swift    # Film listesi iş mantığı
│   ├── MovieDetailViewModel.swift  # Film detay mantığı
│   ├── CartViewModel.swift         # Sepet yönetimi
│   └── FavoritesViewModel.swift    # Favoriler yönetimi
│
├── Views/
│   ├── MovieList/
│   │   ├── MovieListView.swift      # Ana film listesi ekranı
│   │   ├── MovieRowView.swift       # Film listesi öğesi bileşeni
│   │   └── SearchBarView.swift      # Arama çubuğu bileşeni
│   │
│   ├── MovieDetail/
│   │   ├── MovieDetailView.swift    # Film detay ekranı
│   │   └── RatingView.swift         # Derecelendirme gösterim bileşeni
│   │
│   ├── Cart/
│   │   ├── CartView.swift           # Alışveriş sepeti ekranı
│   │   └── CartItemView.swift       # Sepet öğesi bileşeni
│   │
│   └── Favorites/
│       └── FavoritesView.swift      # Favoriler koleksiyon ekranı
│
├── Networking/
│   ├── APIClient.swift              # Genel API istemcisi
│   ├── Endpoints.swift              # API endpoint tanımları
│   ├── NetworkService.swift         # Ağ isteği işleyicisi
│   └── NetworkError.swift           # Ağ hata tipleri
│
├── Utils/
│   ├── Constants.swift              # Uygulama sabitleri
│   ├── Extensions/
│   │   ├── Color+Extension.swift    # Renk araçları
│   │   ├── View+Extension.swift     # Görünüm değiştiricileri
│   │   └── String+Extension.swift   # String araçları
│   └── ImageCache.swift             # Görüntü önbellekleme aracı
│
└── Resources/
    ├── Assets.xcassets              # Görseller, renkler, simgeler
    └── Info.plist                   # Uygulama yapılandırması
```

---

## 🎨 Tasarım Sistemi

### Renk Paleti
```swift
extension Color {
    static let primaryAccent = Color("AccentColor")
    static let background = Color("BackgroundColor")
    static let cardBackground = Color("CardBackground")
    static let textPrimary = Color("TextPrimary")
    static let textSecondary = Color("TextSecondary")
}
```

### Tipografi
- **Başlık**: Kalın, 28pt
- **Alt Başlık**: Yarı kalın, 20pt
- **Gövde**: Normal, 16pt
- **Altyazı**: Normal, 12pt

### Bileşenler
- **Film Kartı**: Yuvarlatılmış köşeler, gölge, poster görseli
- **Derecelendirme Yıldızları**: Özel yıldız derecelendirme görünümü
- **Sepet Rozeti**: Sepet simgesinde miktar göstergesi
- **Arama Çubuğu**: Özel stillendirilmiş arama alanı

---

## 🔧 Yapılandırma

### API Yapılandırması

```swift
// APIClient.swift
struct APIClient {
    private let baseURL = "https://api.example.com"
    
    enum Endpoint {
        case movies
        case movieDetail(id: Int)
        case search(query: String)
        
        var path: String {
            switch self {
            case .movies: return "/movies"
            case .movieDetail(let id): return "/movies/\(id)"
            case .search: return "/movies/search"
            }
        }
    }
}
```

### UserDefaults Anahtarları

```swift
enum UserDefaultsKeys {
    static let cartItems = "cartItems"
    static let favoriteMovieIDs = "favoriteMovieIDs"
    static let lastSearchQuery = "lastSearchQuery"
}
```

---

## 🎯 Özellik Detayları

### Arama Uygulaması
```swift
@Published var searchText = ""
@Published var filteredMovies: [Movie] = []

var searchResults: [Movie] {
    if searchText.isEmpty {
        return movies
    } else {
        return movies.filter { movie in
            movie.title.localizedCaseInsensitiveContains(searchText) ||
            movie.director.localizedCaseInsensitiveContains(searchText) ||
            movie.category.localizedCaseInsensitiveContains(searchText)
        }
    }
}
```

### Sepet Hesaplama
```swift
var totalPrice: Double {
    cartItems.reduce(0) { sum, item in
        sum + (item.movie.price * Double(item.quantity))
    }
}

var totalItems: Int {
    cartItems.reduce(0) { sum, item in
        sum + item.quantity
    }
}
```

---

## 🐛 Sorun Giderme

### Yaygın Sorunlar

**Sorun**: Filmler yüklenmiyor
- **Çözüm**: İnternet bağlantısını kontrol edin, API endpoint'inin erişilebilir olduğunu doğrulayın

**Sorun**: Arama çalışmıyor
- **Çözüm**: Arama metni bağlamasının ViewModel'e düzgün bağlandığından emin olun

**Sorun**: Sepet öğeleri kayboluyor
- **Çözüm**: UserDefaults kalıcılığını doğrulayın, uygun kodlama/çözme kontrol edin

**Sorun**: Görseller görüntülenmiyor
- **Çözüm**: Görsel URL'lerinin geçerli olduğunu onaylayın, Info.plist'te ağ izinlerini kontrol edin

**Sorun**: Uygulama başlangıçta çöküyor
- **Çözüm**: Eksik varlıkları kontrol edin, tüm @Published özelliklerinin başlatıldığını doğrulayın

---

## 🗺️ Yol Haritası

### Planlanan Özellikler

- [ ] Firebase/Backend ile **Kullanıcı Kimlik Doğrulaması**
- [ ] **Ödeme Entegrasyonu** (Stripe, Apple Pay)
- [ ] **Sipariş Geçmişi** takibi
- [ ] **Film Fragmanları** entegrasyonu (YouTube API)
- [ ] **Kullanıcı İncelemeleri & Derecelendirmeleri** sistemi
- [ ] **Gelişmiş Filtreleme** (tür, yıl, derecelendirme aralığı)
- [ ] **Sıralama Seçenekleri** (popülerlik, derecelendirme, yıl, başlık)
- [ ] Sepetten ayrı **İstek Listesi**
- [ ] **Paylaşım İşlevselliği** (filmleri arkadaşlarla paylaş)
- [ ] Yeni çıkışlar için **Push Bildirimleri**
- [ ] Uyarlanabilir düzenlerle **iPad Desteği**
- [ ] **watchOS Yardımcı Uygulaması**
- [ ] CoreData ile **Çevrimdışı Mod**
- [ ] **Çoklu Dil Desteği** (Yerelleştirme)
- [ ] **Erişilebilirlik İyileştirmeleri** (VoiceOver, Dinamik Tip)

### İyileştirmeler

- [ ] Birim testleri kapsamı
- [ ] UI testleri otomasyonu
- [ ] Büyük listeler için performans optimizasyonu
- [ ] Görüntü önbellekleme iyileştirmeleri
- [ ] Daha iyi hata işleme ve kullanıcı geri bildirimi
- [ ] Film listeleri için sayfalandırma
- [ ] Yenilemek için çekme işlevselliği
- [ ] İskelet yükleme ekranları
- [ ] Dokunsal geri bildirim

---

## 📄 Lisans

Bu proje MIT Lisansı altında lisanslanmıştır - detaylar için [LICENSE](LICENSE) dosyasına bakın.

```
MIT Lisansı

Telif Hakkı (c) 2024 Erdem Maliş

İzin, bu yazılımın ve ilişkili dokümantasyon dosyalarının ("Yazılım") bir kopyasını 
alan herhangi bir kişiye, Yazılım'ı kullanma, kopyalama, değiştirme, birleştirme, 
yayınlama, dağıtma, alt lisanslama ve/veya satma hakları dahil olmak üzere, 
sınırlama olmaksızın Yazılım'da işlem yapma izni ücretsiz olarak verilir.
```

---

## 🤝 Katkıda Bulunma

Katkılar memnuniyetle karşılanır! Lütfen Pull Request göndermekten çekinmeyin. Büyük değişiklikler için, lütfen önce yapmak istediğiniz değişikliği tartışmak için bir issue açın.

### Katkı Kuralları

1. Depoyu fork edin
2. Özellik dalınızı oluşturun (`git checkout -b feature/HarikaBirOzellik`)
3. Değişikliklerinizi commit edin (`git commit -m 'Harika bir özellik ekle'`)
4. Dalınıza push edin (`git push origin feature/HarikaBirOzellik`)
5. Bir Pull Request açın

### Kod Stili

- [Swift API Tasarım Kılavuzları](https://swift.org/documentation/api-design-guidelines/)'nı takip edin
- Kod tutarlılığı için SwiftLint kullanın
- Açık, tanımlayıcı commit mesajları yazın
- Karmaşık mantık için yorumlar ekleyin
- Yeni özellikler için dokümantasyonu güncelleyin

---

## 📧 İletişim

**Geliştirici**: Mehmet Ali Sevdinoglu

- GitHub: [@malisevdinoglu](https://github.com/malisevdinoglu)
- LinkedIn: [Mehmet Ali Sevdinoglu](https://linkedin.com/in/erdem-malis)
- E-posta: [GitHub üzerinden iletişim](https://github.com/malisevdinoglu)

---

## 🙏 Teşekkürler

- SwiftUI kullanarak ❤️ ile yapılmıştır
- Modern e-ticaret uygulamalarından ilham alınmıştır
- Swift ve iOS geliştirme topluluğuna teşekkürler
- Film verileri [API Kaynağınız] tarafından sağlanmaktadır

---

<div align="center">

**⭐ Bu projeyi yararlı buluyorsanız, lütfen yıldız vermeyi düşünün!**

💻 ve ☕ ile [Mehmet Ali Sevdinoglu](https://github.com/malisevdinoglu) tarafından yapılmıştır

</div>
