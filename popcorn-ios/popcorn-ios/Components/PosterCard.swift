
import SwiftUI

struct PosterCard: View {
    static let defaultWidth: CGFloat = 120
    static let defaultHeight: CGFloat = 180

    let movie: Movie
    var width: CGFloat = defaultWidth
    var height: CGFloat = defaultHeight
    

    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            poster
            title
            MovieRating(rating: movie.voteAverage)
        }
        .frame(width: 130)
    }
}

extension PosterCard {
    static var skeleton: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            RoundedRectangle(cornerRadius: Radius.md)
                .fill(.surfaceMuted)
                .frame(width: defaultWidth, height: defaultHeight)
            
            RoundedRectangle(cornerRadius: 4)
                .fill(.surfaceMuted)
                .frame(width: 90, height: 14)
            
            RoundedRectangle(cornerRadius: 4)
                .fill(.surfaceMuted)
                .frame(width: 50, height: 12)
        }
        .frame(width: 120)
    }
}

private extension PosterCard {
    var poster: some View {
        AsyncImage(url: movie.posterUrl) {image in
            image.resizable()
        } placeholder: {
            Rectangle()
                .fill(.surfaceMuted)
                .overlay {
                    Image(systemName: "film")
                        .foregroundStyle(.textMuted)
                }
        }
        .frame(width: width, height: height)
        .clipShape(.rect(cornerRadius: Radius.sm))
    }
    
    var title: some View {
        Text(movie.title)
            .font(Font.headline)
            .foregroundStyle(Color.primary)
            .lineLimit(1)
    }
}

#Preview {
    PosterCard(movie: .preview)
        .padding()
}
