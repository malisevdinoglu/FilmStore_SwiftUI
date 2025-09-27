import SwiftUI

struct MovieDetailView: View {
    @StateObject var vm: MovieDetailViewModel
    @State private var showCart = false  

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: DS.spacing) {

                    AsyncImage(url: AppConstants.imagesBaseURL.appendingPathComponent(vm.movie.image)) { img in
                        img.resizable().scaledToFit()
                    } placeholder: { Rectangle().fill(.gray.opacity(0.12)) }
                    .frame(maxWidth: .infinity, maxHeight: 360)
                    .clipShape(RoundedRectangle(cornerRadius: DS.corner))
                    .padding(.top)

                    HStack {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(vm.movie.name).font(.title2).bold()
                            HStack(spacing: 8) {
                                RatingView(value: vm.movie.rating)
                                Text("• \(vm.movie.year)").foregroundStyle(.secondary)
                            }
                        }
                        Spacer()
                    }

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            Tag("🏷Kategori: \(vm.movie.category)")
                            Tag("🎬Yönetmen: \(vm.movie.director)")
                        }
                    }

                    Text(vm.movie.description)
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 8)

                    HStack(spacing: 16) {
                        StepperButton(icon: "minus.circle.fill") { vm.decrease() }
                        Text("\(vm.amount)").font(.title2).monospacedDigit()
                        StepperButton(icon: "plus.circle.fill") { vm.increase() }
                        Spacer()
                    }
                    .padding(.vertical, 6)
                }
                .padding(.horizontal)
            }

         
            VStack(spacing: 10) {
                HStack {
                    Text("Toplam:")
                        .bold()
                        .foregroundColor(.white)
                    Spacer()
                    Text((vm.movie.price * vm.amount).asTL)
                        .bold()
                        .foregroundColor(.white)
                }
                Button {
                    Task { await vm.addToCart() }
                } label: {
                    Text(vm.isAdding ? "Ekleniyor…" : "Sepete Ekle")
                        .foregroundColor(.white)
                }
                .buttonStyle(PrimaryButtonStyle())
                .disabled(vm.isAdding)

                if let info = vm.info {
                    Text(info)
                        .font(.footnote)
                        .foregroundStyle(.white.opacity(0.7))
                }
            }
            .padding()
            .background(Color.black)
        }
        
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.black, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Film Detayı")
                    .font(.system(size: 22, weight: .heavy, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(radius: 1)
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showCart = true
                } label: {
                    Image(systemName: "cart")
                        .foregroundColor(.blue)
                     
                }
            }
        }
        .navigationDestination(isPresented: $showCart) {
            CartView()
        }

        // Sepete eklendi paneli (siyah tema)
        .overlay(alignment: .bottom) {
            if vm.didAdd {
                AddedToCartBar(
                    title: "Sepete eklendi",
                    goCart: {
                        vm.didAdd = false
                        showCart = true
                    },
                    dismiss: {
                        withAnimation { vm.didAdd = false }
                    }
                )
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .animation(.spring(response: 0.35, dampingFraction: 0.85), value: vm.didAdd)
                .padding(.horizontal)
                .padding(.bottom, 8)
            }
        }
        .onChange(of: vm.didAdd, { oldValue, newValue in
            guard newValue else { return }
            Task {
                try? await Task.sleep(nanoseconds: 2_000_000_000)
                await MainActor.run { withAnimation { vm.didAdd = false } }
            }
        })
    }
}


private struct AddedToCartBar: View {
    let title: String
    let goCart: () -> Void
    let dismiss: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "checkmark.circle.fill")
                .imageScale(.large)
                .foregroundStyle(.green)

            Text(title)
                .font(.subheadline).bold()
                .foregroundColor(.white)

            Spacer()

            Button("Sepete Git", action: goCart)
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.gray.opacity(0.3))
                .clipShape(Capsule())
        }
        .padding(12)
        .background(Color.black)
        .clipShape(RoundedRectangle(cornerRadius: DS.corner, style: .continuous))
        .shadow(color: .black.opacity(0.4), radius: 8, y: 2)
    }
}

private struct Tag: View {
    let text: String
    init(_ text: String) { self.text = text }
    var body: some View {
        Text(text)
            .font(.caption)
            .padding(.horizontal, 10).padding(.vertical, 6)
            .background(DS.surface)
            .clipShape(Capsule())
    }
}

private struct StepperButton: View {
    let icon: String; let action: () -> Void
    var body: some View {
        Button(action: {
            action()
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }) {
            Image(systemName: icon).font(.title2)
        }
        .tint(DS.brand)
    }
}
