import SwiftUI

struct DiscoverView: View {
    @State private var viewModel = DiscoverViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: Spacing.xl) {
                    featuredSection
                    carouselSection(
                        feed: .trending,
                        state: viewModel.trending
                    )
                    carouselSection(
                        feed: .nowPlaying,
                        state: viewModel.nowPlaying
                    )
                }
                .padding(.bottom, Spacing.xs)
                
            }
            .navigationTitle("Discover")
            .refreshable {
                await viewModel.loadAll()
            }
        }
        .task {	
            await viewModel.loadAll()
        }
    }
}

private extension DiscoverView {
    @ViewBuilder
    var featuredSection: some View {
        switch viewModel.trending {
        case .idle, .loading:
            FeaturedCard.skeleton

        case .loaded(let movies):
            if let featured = movies.first {
                NavigationLink {
                    MovieDetailView(movie: featured)
                } label: {
                    FeaturedCard(movie: featured)
                }
            }
        case .failed:
            EmptyView()
        }
    }
    
    @ViewBuilder
    func carouselSection(feed: MoviesFeed, state: Loadable<[Movie]>) -> some View {
        switch state {
        case .idle, .loading:
            MovieCarousel.skeleton(title: feed.title)
            
        case .loaded(let movies):
            if !movies.isEmpty {
                MovieCarousel(title: feed.title, movies: movies, feed: feed)
            } else {
                EmptyView()
            }
            
        case .failed:
            EmptyView()
        }
    }
}


#Preview {
    DiscoverView()
}
