import SwiftUI

struct MovieRow: View {
    let movie: Movie
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: Spacing.md) {
                poster
                info
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(Font.footnote)
                    .fontWeight(.semibold)
                    .foregroundStyle(.tertiary)
            }
            .padding(.horizontal, Spacing.md)
            .padding(.vertical,Spacing.sm)
        }
    }
}

private extension MovieRow {
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
        .clipShape(RoundedRectangle(cornerRadius: 4))
    }
    
    var info: some View {
        VStack(alignment: .leading) {
            Text(movie.title)
                .font(Font.headline)
            
            HStack {
                if let releaseYear = movie.releaseYear {
                    Text(releaseYear)
                    Text("·").foregroundStyle(Color.textMuted)
                }
                
                MovieRating(rating: movie.voteAverage)
            }
        }
    }
}

#Preview {
    MovieRow(movie: .preview)
}
