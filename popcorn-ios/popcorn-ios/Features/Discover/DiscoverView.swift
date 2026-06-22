import SwiftUI

struct DiscoverView: View {
    @State private var viewModel = DiscoverViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: Spacing.xl) {
                    featuredSection
                    carouselSection(title: "Trending", state: viewModel.trending)
                    carouselSection(title: "New Releases", state: viewModel.nowPlaying)
                }
                .padding(.bottom, Spacing.xs)
                
            }
            .navigationTitle("Discover")
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
                FeaturedCard(movie: featured)
            }
        case .failed:
            EmptyView()
        }
    }
    
    @ViewBuilder
    var trendingSection: some View {
        switch viewModel.trending {
        case .idle, .loading:
            MovieCarousel.skeleton(title: "Trending")
            
        case .loaded(let movies):
            if !movies.isEmpty {
                MovieCarousel(title: "Trendings", movies: movies, onSeeAll: {})
            } else {
                EmptyView()
            }
            
        case .failed:
            EmptyView()
        }
    }
    
    @ViewBuilder
    func carouselSection(title: String, state: Loadable<[Movie]>) -> some View {
        switch state {
        case .idle, .loading:
            MovieCarousel.skeleton(title: title)
            
        case .loaded(let movies):
            if !movies.isEmpty {
                MovieCarousel(title: title, movies: movies, onSeeAll: {})
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
