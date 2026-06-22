import SwiftUI

struct FeaturedCard: View {
    let movie: Movie
    
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
                .font(.caption)
                .textCase(.uppercase)
                .foregroundStyle(.white.opacity(0.8))
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(.white.opacity(0.2))
                .clipShape(.capsule)
                .kerning(1.5)
                
                
            Spacer()
            
            Text(movie.title)
                .font(.title)
                .foregroundStyle(.white)
                .lineLimit(2)
            
            metadataRow
            
            trailerButton
                .padding(.top, Spacing.xs)
        }
        .padding(Spacing.md)
    }
    
    var metadataRow: some View {
        HStack(spacing: Spacing.sm) {
            HStack(spacing: 4) {
                Image(systemName: "star.fill")
                    .font(.caption)
                    .foregroundStyle(.warning)
                Text(String(format: "%.1f", movie.voteAverage))
                    .font(.caption)
                    .foregroundStyle(.white)
            }
            
            if let year = movie.releaseDate?.prefix(4) {
                Text("·")
                    .foregroundStyle(.white.opacity(0.4))
                Text(String(year))
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.7))
            }
        }
    }
    
    var trailerButton: some View {
        Button {
            // wire up later
        } label: {
            HStack(spacing: Spacing.xs) {
                Image(systemName: "play.fill")
                    .font(.caption)
                Text("Trailer")
            }
            .font(.subheadline)
            .foregroundStyle(.white)
            .padding(.horizontal, Spacing.md)
            .padding(.vertical, Spacing.sm)
            .background(.primary)
            .clipShape(.rect(cornerRadius: Radius.full))
        }
    }
}

#Preview {
    FeaturedCard(movie: .preview)
        .padding()
}
