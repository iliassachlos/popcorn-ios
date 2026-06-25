import SwiftUI

struct FeaturedCard: View {
    let movie: Movie
    
    @State private var viewModel = MovieDetailViewModel()
    
    @Environment(\.openURL) private var openUrl
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            backdropImage
            gradientOverlay
            movieInfo
        }
        .frame(height: 220)
        .frame(maxWidth: .infinity)
        .clipShape(.rect(cornerRadius: Radius.lg))
        .padding(.horizontal, Spacing.md)
        .task {
            await viewModel.loadMovie(id: movie.id)
        }
    }
}

extension FeaturedCard {
    static var skeleton: some View {
        RoundedRectangle(cornerRadius: Radius.lg)
            .fill(.surfaceMuted)
            .frame(height: 220)
            .padding(.horizontal, Spacing.md)
    }
}

private extension FeaturedCard {
    var backdropImage: some View {
        AsyncImage(url: movie.backdropURL) { image in
            image
                .resizable()

        } placeholder: {
            Rectangle()
                .fill(.surfaceMuted)
        }
    }
    
    var gradientOverlay: some View {
        LinearGradient(
            colors: [.clear, .black.opacity(0.85)],
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    var movieInfo: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            Text("Featured")
                .font(Font.caption)
                .foregroundStyle(Color.white)
                .textCase(.uppercase)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .clipShape(.capsule)
                .glassEffect()
                .kerning(1.5)
                
            Spacer()
            
            Text(movie.title)
                .font(Font.title)
                .foregroundStyle(Color.white)
                .lineLimit(2)
            
            metadataRow
            
            trailerButton
                .padding(.top, Spacing.xs)
        }
        .padding(Spacing.md)
    }
    
    var metadataRow: some View {
        let detailedMovie = viewModel.movie.value
        
        return HStack(spacing: Spacing.sm) {
            Text(detailedMovie?.genreNames ?? "")
                .font(Font.caption)
                .foregroundStyle(Color.white)
            
            Text("·")
                .foregroundStyle(Color.white)
                        
            if let year = movie.releaseDate?.prefix(4) {
                Text("·")
                    .foregroundStyle(Color.white)
                Text(String(year))
                    .font(Font.caption)
                    .foregroundStyle(Color.white)
            }
            
            MovieRating(rating: movie.voteAverage)
        }
    }
    
    var trailerButton: some View {
        Button {
            if let url = viewModel.movie.value?.trailerURL {
                openUrl(url)
            }
        } label: {
            HStack(spacing: Spacing.sm) {
                Image(systemName: "play.fill")
                Text("Trailer")
            }
        }
        .buttonStyle(.glassProminent)
        .controlSize(.regular)
        .tint(.secondary)
        .disabled(viewModel.movie.value?.trailerURL == nil)
    }
}

#Preview {
    FeaturedCard(movie: .preview)
        .padding()
}
