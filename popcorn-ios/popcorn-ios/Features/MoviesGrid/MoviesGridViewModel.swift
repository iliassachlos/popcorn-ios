import Foundation

@Observable
class MoviesGridViewModel {
    var movies: Loadable<[Movie]> = .idle
    var isLoadingMore = false
    let feed: MoviesFeed
    
    private var currentPage = 1
    private var totalPages = 1
    
    private let service = MovieService()
    
    init(feed: MoviesFeed) {
        self.feed = feed
    }
    
    func load() async {
        resetPagination()
        
        await loadMovies(page: 1)
    }
    
    func loadMore() async {
        guard !isLoadDisabled() else { return }
        await loadMovies(page: currentPage + 1)
    }
    
    private func resetPagination() {
        currentPage = 1
        totalPages = 1
    }
    
    private func isLoadDisabled() -> Bool {
        guard case .loading = movies else {
            return currentPage >= totalPages || isLoadingMore
        }
        return true
    }
    
    private func loadMovies(page: Int) async {
        if page == 1 {
            movies = .loading
        } else {
            isLoadingMore = true
        }

        
        do {
            let response = try await fetch(page: page)
            
            currentPage = response.page
            totalPages = response.totalPages
            
            if page == 1 {
                movies = .loaded(response.results)
            } else if case .loaded(let existing) = movies {
                movies = .loaded(existing + response.results)
            }
        } catch {
            if page == 1 { movies = .failed(error) }
        }

        isLoadingMore = false
    }
    
    private func fetch(page: Int) async throws -> PagedResponse<Movie> {
        switch feed {
        case .trending:
            return try await service.fetchTrending(page: page)
        case .nowPlaying:
            return try await service.fetchNowPlaying(page: page)
        }
    }
}
