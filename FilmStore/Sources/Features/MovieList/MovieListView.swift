import SwiftUI
import Combine

struct MovieListView: View {
    @StateObject private var vm = MovieListViewModel()
    @State private var query = ""

    private let cols = [
        GridItem(.flexible(), spacing: DS.spacing),
        GridItem(.flexible(), spacing: DS.spacing)
    ]

    var body: some View {
      
        let content: some View = Group {
            switch vm.state {
            case .idle, .loading:
                LoadingView()
                    .background(Color.clear)

            case .failed(let error):
                ErrorView(message: error.localizedDescription) {
                    Task { await vm.load() }
                }
                .background(Color.clear)

            case .loaded(let movies):
                let filtered = query.isEmpty
                ? movies
                : movies.filter {
                    $0.name.localizedCaseInsensitiveContains(query) ||
                    $0.category.localizedCaseInsensitiveContains(query)
                }

                if filtered.isEmpty {
                    EmptyViewState(title: "Film bulunamadı", message: "Başka bir arama dene.")
                        .padding()
                        .background(Color.clear)
                } else {
                    ScrollView {
                        LazyVGrid(columns: cols, spacing: DS.spacing) {
                            ForEach(filtered) { m in
                                NavigationLink {
                                    MovieDetailView(vm: .init(movie: m))
                                } label: {
                                    MovieCard(movie: m)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding()
                    }
                    .refreshable { await vm.load() }
                    .background(Color.clear)
                }
            }
        }
        .navigationTitle("Film Store")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Film Store")
                    .font(.system(size: 22, weight: .heavy, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(radius: 1)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: CartView()) {
                    Image(systemName: "cart")
                        .foregroundColor(.blue)
                }
            }
        }
        .toolbarBackground(
            LinearGradient(
                colors: [Color.black.opacity(0.8), Color.red.opacity(0.8)],
                startPoint: .leading, endPoint: .trailing
            ),
            for: .navigationBar
        )
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbar {
            NavigationLink(destination: CartView()) {
                
                
            }
        }
        .task { await vm.load() }
        .background(Color.clear)

        
        ZStack {
            
            LinearGradient(
                colors: [
                    Color.blue.opacity(0.3),
                    Color.purple.opacity(0.14)
                ],
                startPoint: .top, endPoint: .bottom
            )
            .ignoresSafeArea()

            NavigationStack {
                content
            }
            .background(Color.clear)
            
            .toolbarBackground(.clear, for: .navigationBar)
            .toolbarBackgroundVisibility(.visible, for: .navigationBar)
            .searchable(
                text: $query,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Ara"
            )
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
            .onAppear {
                
                let tf = UISearchBar.appearance().searchTextField
                tf.backgroundColor = .white
                tf.layer.cornerRadius = 12
                tf.clipsToBounds = true
              
                tf.textColor = .label
                tf.attributedPlaceholder = NSAttributedString(
                    string: "Ara",
                    attributes: [.foregroundColor: UIColor.secondaryLabel]
                )
            }
            
        }
    }
}

// MARK: - Card
private struct MovieCard: View {
    let movie: Movie
    @State private var isFav: Bool = false
    @State private var appear = false

    init(movie: Movie) {
        self.movie = movie
        _isFav = State(initialValue: UserDefaults.standard.bool(forKey: "fav_\(movie.id)"))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack(alignment: .topLeading) {
                AsyncImage(url: AppConstants.imagesBaseURL.appendingPathComponent(movie.image)) { img in
                    img.resizable().scaledToFill()
                } placeholder: {
                    Rectangle().fill(.gray.opacity(0.12))
                }
                .frame(height: 160)
                .clipped()
                .overlay(
                    VStack {
                        Spacer()
                        LinearGradient(
                            colors: [.clear, .black.opacity(0.55)],
                            startPoint: .center, endPoint: .bottom
                        )
                        .frame(height: 64)
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: DS.corner))

                Text(movie.category)
                    .font(.caption2.weight(.semibold))
                    .padding(.horizontal, 8).padding(.vertical, 5)
                    .background(.ultraThinMaterial)
                    .clipShape(Capsule())
                    .padding(8)

                HStack { Spacer()
                    Button {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                            isFav.toggle()
                            UserDefaults.standard.set(isFav, forKey: "fav_\(movie.id)")
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        }
                    } label: {
                        Image(systemName: isFav ? "heart.fill" : "heart")
                            .symbolEffect(.bounce, value: isFav)
                            .foregroundStyle(isFav ? .red : .white)
                            .shadow(radius: 2)
                            .padding(10)
                    }
                }
                .padding(2)
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(movie.name)
                    .font(.subheadline).bold()
                    .lineLimit(2)

                HStack {
                    RatingView(value: movie.rating)
                    Spacer()
                    Text(movie.price.asTL).font(.headline)
                }
            }
            .padding(.horizontal, 6)
            .padding(.bottom, 8)
        }
        .cardStyle()
        .scaleEffect(appear ? 1 : 0.98)
        .opacity(appear ? 1 : 0)
        .onAppear { withAnimation(.easeOut(duration: 0.2)) { appear = true } }
    }
}
