import SwiftUI

struct MoviesGridView: View {
    @State private var viewModel: MoviesGridViewModel
    
    init(feed: MoviesFeed) {
        _viewModel = State(initialValue: MoviesGridViewModel(feed: feed))
    }
    
    var body: some View {
        content
            .navigationTitle(viewModel.feed.title)
            .task {
                await viewModel.load()
            }
    }
}

private extension MoviesGridView {
    @ViewBuilder
    var content: some View {
        switch viewModel.movies {
        case .idle, .loading:
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        case .loaded(let movies):
            grid(movies: movies)
            
        case .failed:
            ContentUnavailableView(
                "Couldn't load \(viewModel.feed.title)",
                systemImage: "exclamationmark.triangle"
            )
        }
    }
    
    func grid(movies: [Movie]) -> some View {
        let columns = [GridItem(.adaptive(minimum: 130), spacing: Spacing.xs)]
        
        return ScrollView {
            LazyVGrid(columns: columns, spacing: Spacing.md) {
                ForEach(movies) { movie in
                    NavigationLink {
                        MovieDetailView(movie: movie)
                    } label: {
                        PosterCard(movie: movie, width: 160, height: 220)
                    }
                    .buttonStyle(.plain)
                    .task {
                        if movie.id == movies.last?.id {
                            await viewModel.loadMore()
                        }
                    }
                }
            }
            .padding(.horizontal, Spacing.md)
            
            if viewModel.isLoadingMore {
                ProgressView()
                    .padding()
            }
        }
    }
}
