import SwiftUI

struct WatchlistRow: View {
    let movie: SavedMovie

    var body: some View {
        HStack(spacing: Spacing.md) {
            poster
            info
            Spacer()
            Image(systemName: "bookmark.fill")
                .foregroundStyle(.accent)
        }
        .padding(.vertical, Spacing.sm)
    }
}

private extension WatchlistRow {
    var poster: some View {
        AsyncImage(url: movie.posterUrl) { image in
            image.resizable().aspectRatio(contentMode: .fill)
        } placeholder: {
            Rectangle()
                .fill(.surfaceMuted)
                .overlay {
                    Image(systemName: "film")
                        .font(.title)
                        .foregroundStyle(.textMuted)
                }
        }
        .frame(width: 56, height: 80)
        .clipShape(RoundedRectangle(cornerRadius: Radius.sm))
    }

    var info: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            Text(movie.title)
                .font(Font.headline)
                .lineLimit(1)

            metaLine
        }
    }

    var metaLine: some View {
        HStack(spacing: Spacing.xs) {
            if let releaseYear = movie.releaseYear {
                Text(releaseYear)
                Text("·").foregroundStyle(Color.textMuted)
            }
            if let mainGenre = movie.mainGenre {
                Text(mainGenre)
                Text("·").foregroundStyle(Color.textMuted)
            }
            MovieRating(rating: movie.voteAverage)
        }
        .font(Font.caption)
        .foregroundStyle(Color.textMuted)
    }
}
