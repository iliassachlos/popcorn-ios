import SwiftUI

struct MovieCarousel: View {
    let title: String
    let movies: [Movie]
    let feed: MoviesFeed
    
    var body: some View {
        return VStack(alignment: .leading, spacing: Spacing.sm) {
            HStack {
                Text(title)
                    .font(Font.title2)
                    .fontWeight(.semibold)
                    
                Spacer()
                
                NavigationLink {
                    MoviesGridView(feed: feed)
                } label :{
                    Text("See All")
                        .font(Font.subheadline)
                        .foregroundStyle(Color.accent)
                }
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
                        .buttonStyle(.plain)
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
        feed: .trending
    )
}
