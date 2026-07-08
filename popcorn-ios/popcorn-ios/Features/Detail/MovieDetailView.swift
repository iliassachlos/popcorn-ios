import SwiftUI
import SwiftData

struct MovieDetailView: View {
    let movie: Movie
    
    @State private var viewModel = MovieDetailViewModel()
    
    @Query private var savedMovies: [SavedMovie]
    
    @Environment(\.openURL) private var openTrailerUrl
    @Environment(\.modelContext) private var modelContext
    
    init(movie: Movie) {
        self.movie = movie
        
        let id = movie.id
        
        _savedMovies = Query(filter: #Predicate<SavedMovie> { $0.id == id})
    }
    
    private var isSaved: Bool {
        !savedMovies.isEmpty
    }
    
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
                
                castSection.unredacted()
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
                if let voteAverage = detailedMovie?.voteAverage {
                    MovieRating(rating: voteAverage, style: .bold)
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
    
    @ViewBuilder
    var castSection: some View {
        let detailedMovie = viewModel.movie.value
        
        // Hide the section entirely once loaded if the movie has no cast
        if detailedMovie == nil || detailedMovie?.credits.cast.isEmpty == false {
            VStack(alignment: .leading, spacing: Spacing.sm) {
                Text("Cast")
                    .font(Font.headline)
                    .padding(.horizontal, Spacing.md)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .top, spacing: Spacing.md) {
                        if let detailedMovie {
                            ForEach(detailedMovie.credits.cast.prefix(10)) { member in
                                CastCard(member: member)
                            }
                        } else {
                            ForEach(0..<6, id: \.self) { _ in
                                CastCard.skeleton
                            }
                        }
                    }
                    .padding(.leading, Spacing.md)
                }
                .disabled(detailedMovie == nil)
            }
            .padding(.bottom, Spacing.lg)
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
                    viewModel
                        .toggleSave(
                            existing: savedMovies.first,
                            context: modelContext
                        )
                } label: {
                    Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
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
