import SwiftUI

struct CartView: View {
    @StateObject private var vm = CartViewModel()

    // MARK: - İçerik (ViewBuilder ile tek bir view)
    @ViewBuilder
    private var mainContent: some View {
        if vm.isLoading {
            LoadingView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)

        } else if let e = vm.error {
            ErrorView(message: e) {
                Task { await vm.load() }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

        } else if vm.displayItems.isEmpty {
            EmptyState(
                title: "Sepetin boş",
                message: "Film eklemek için listeden bir film seç ve “Sepete Ekle”ye bas."
            )
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)

        } else {
            List {
                ForEach(vm.displayItems, id: \.id) { item in
                    HStack(spacing: 12) {
                        AsyncImage(
                            url: AppConstants.imagesBaseURL.appendingPathComponent(item.image)
                        ) { img in
                            img.resizable().scaledToFill()
                        } placeholder: {
                            Rectangle().fill(.gray.opacity(0.12))
                        }
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 10))

                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.name).font(.subheadline).bold()
                            Text("Adet: \(item.totalAmount)").foregroundStyle(.secondary)
                            Text(item.price.asTL)
                        }
                        Spacer()
                        
                        Text((item.price * item.totalAmount).asTL)
                                        .font(.headline)
                    }
                    .padding(.vertical, 4)
                    .swipeActions {
                        Button(role: .destructive) {
                            Task { await vm.delete(item) }   // grubu sil
                        } label: {
                            Label("Sil", systemImage: "trash")
                        }
                    }
                }
            }
            .listStyle(.plain)
            .refreshable { await vm.load() }
        }
    }

    // MARK: - Alt bar (siyah)
    private var footerBar: some View {
        VStack(spacing: 12) {
            Divider().background(Color.white.opacity(0.1))
            HStack(alignment: .firstTextBaseline) {
                Text("Toplam:")
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                Text(vm.total.asTL)
                    .font(.system(size: 28, weight: .bold, design: .default))
                    .monospacedDigit()
                    .foregroundColor(.white)
            }
            Button { /* onay */ } label: {
                Text("SEPETİ ONAYLA")
            }
            .buttonStyle(PrimaryButtonStyle())
        }
        .padding()
        .background(Color.black)
    }

    // MARK: - Body
    var body: some View {
        VStack(spacing: 0) {
            mainContent
            footerBar
        }
        // Üst bar (siyah + başlık stili)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.black, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Sepetim")
                    .font(.system(size: 22, weight: .heavy, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(radius: 1)
            }
        }
        .navigationTitle("Sepetim")
        .task { await vm.load() }
    }
}

// MARK: - Empty state
private struct EmptyState: View {
    let title: String
    let message: String
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "cart").font(.system(size: 44))
            Text(title).font(.headline)
            Text(message)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
