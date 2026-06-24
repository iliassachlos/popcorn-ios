import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    
    @State private var viewModel = MovieDetailViewModel()
    
    @Environment(\.openURL) private var openTrailerUrl
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.md) {
                hero.unredacted()
                VStack(alignment: .leading, spacing: Spacing.md) {
                    movieTitle.unredacted()
                    metaRow
                    movieInfo.unredacted()
                }
                .padding(Spacing.md)
            }
        }
        .ignoresSafeArea(edges: .top)
        .toolbarBackground(.hidden, for: .navigationBar)
        .toolbar { toolbar }
        .redacted(reason: viewModel.movie.value == nil ? .placeholder : [])
        .task {
            await viewModel.loadMovie(id: movie.id)
        }
    }
    
}

private extension MovieDetailView {
    var hero: some View {
        Color.clear
            .frame(height: 360)
            .overlay {
                AsyncImage(url: movie.backdropURL) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    Rectangle()
                        .fill(.surfaceMuted)
                        .overlay {
                            Image(systemName: "film")
                                .font(.title)
                                .foregroundStyle(.textMuted)
                        }
                }
            }
            .clipped()
            .overlay(alignment: .bottom) {
                LinearGradient(
                    colors: [.clear, Color(.systemBackground)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 160)
            }
    }
    
    var movieTitle: some View {
        Text(movie.title)
            .font(.largeTitle.bold())
    }

    var metaRow: some View {
        let detailedMovie = viewModel.movie.value
        
        return VStack(alignment: .leading) {
            HStack(spacing: Spacing.xs) {
                if let releaseDate = detailedMovie?.releaseDate {
                    Text(releaseDate)
                }
                
                if let formattedRuntime = detailedMovie?.formattedRuntime {
                    Text("·").foregroundStyle(.textMuted)
                    Text(formattedRuntime)
                }
            }
            
            
            if let genreNames = detailedMovie?.genreNames {
                
                Text(genreNames)

                    .lineLimit(1)
                    .truncationMode(.tail)
            }
        }
        .font(.caption)
        .foregroundStyle(Color.textMuted)
    }
    
    var movieInfo: some View {
        let detailedMovie = viewModel.movie.value
            
        return VStack(alignment: .leading, spacing: Spacing.lg) {
            HStack {
                Image(systemName: "star.fill")
                    .imageScale(.small)
                    .foregroundStyle(Color.warning)
                
                if let voteAverage = detailedMovie?.voteAverage {
                    Text(String(format: "%.1f", voteAverage))
                        .font(Font.body)
                        .fontWeight(.bold)
                }
               
                
                if let voteCount = detailedMovie?.voteCount {
                    Text("·")
                        .foregroundStyle(.textMuted)
                    
                    Text(String("\(voteCount) ratings"))
                        .font(Font.footnote)
                        .foregroundStyle(Color.textMuted)
                }
            }
            
            Button {
                if let url = detailedMovie?.trailerURL {
                    openTrailerUrl(url)
                }
            } label: {
                HStack {
                    Image(systemName: "play.fill")
                    Text("Watch Trailer")
                }
            }
            .buttonStyle(.glassProminent)
            .controlSize(.large)
            .tint(.accent)
            .disabled(viewModel.movie.value?.trailerURL == nil)
            
            VStack(alignment: .leading, spacing: Spacing.sm){
                Text("Overview")
                    .font(Font.headline)
                
                Text(movie.overview)
            }
        }
        
    }
    
    @ToolbarContentBuilder
    var toolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            HStack(spacing: Spacing.md) {
                if let shareUrl = movie.tmdbURL {
                    ShareLink(item: shareUrl) {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
                
                Button {
                    // Save action
                } label: {
                    Image(systemName: "bookmark")
                }
            }
            .padding(.horizontal, Spacing.sm)
        }
    }
}

#Preview {
    NavigationStack {
        MovieDetailView(movie: .preview)
    }
}
