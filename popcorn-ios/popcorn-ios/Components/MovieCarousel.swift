import SwiftUI

struct MovieCarousel: View {
    let title: String
    let movies: [Movie]
    let onSeeAll: () -> Void
    
    var body: some View {
        let _ = print("🎠 carousel \(title) rendering \(movies.count) movies, unique ids: \(Set(movies.map(\.id)).count)")
        
        return VStack(alignment: .leading, spacing: Spacing.sm) {
            HStack {
                Text(title)
                    .font(Font.title)
                
                Spacer()
                
                Button("See All", action: onSeeAll)
                    .font(Font.subheadline)
                    .foregroundStyle(Color.accent)
            }
            .padding(.horizontal, Spacing.md)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: Spacing.sm) {
                    ForEach(movies) {movie in
                        NavigationLink {
                            MovieDetailView(movie: movie)
                        } label: {
                        PosterCard(movie: movie)
                        }
                    }
                }
                .padding(.leading, Spacing.md)
            }
        }
    }
}

extension MovieCarousel {
    static func skeleton(title: String) -> some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text(title)
                .font(.title)
                .padding(.horizontal, Spacing.md)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: Spacing.sm) {
                    ForEach(0..<5, id: \.self) { _ in
                        PosterCard.skeleton
                    }
                }
                .padding(.leading, Spacing.md)
            }
            .disabled(true)
        }
    }
}


#Preview {
    MovieCarousel(
        title: "Trending",
        movies: [.preview, .preview, .preview],
        onSeeAll: {}
    )
}
