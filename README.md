# 🎬 FilmStore App

SwiftUI ile geliştirilmiş modern bir film mağazası uygulaması.  
Kullanıcılar filmleri görüntüleyebilir, detaylarına bakabilir ve sepetlerine ekleyebilir.  

##  Özellikler
- 📱 SwiftUI ile modern arayüz
- 🔎 Arama çubuğu ile film arama
-  Kategori, yönetmen ve yıl bilgisi görüntüleme
-  Film değerlendirme puanları
-  Sepete film ekleme, adet artırma/azaltma ve silme
-  Favorilere ekleme
-  API üzerinden film verilerini çekme

## 🛠 Kullanılan Teknolojiler
- **SwiftUI** – Arayüz geliştirme
- **MVVM** – Mimari yapı
- **Combine** – State yönetimi
- **Async/Await** – Asenkron ağ istekleri
- **Core Networking** – `APIClient` ile backend iletişimi

 📂 Proje Yapısı

FilmStore/
├── Resources/
│   └── Assets.xcassets/     # Uygulama ikonları ve renkler
├── Sources/
│   ├── Features/
│   │   ├── MovieList/       # Film listesi ekranı
│   │   ├── MovieDetail/     # Film detay ekranı
│   │   └── Cart/            # Sepet ekranı
│   ├── Shared/
│   │   ├── Models/          # Veri modelleri
│   │   ├── Networking/      # API istemcisi ve endpointler
│   │   └── Utils/           # Tasarım sistemleri, sabitler
└── FilmStoreApp.swift       # Giriş noktası