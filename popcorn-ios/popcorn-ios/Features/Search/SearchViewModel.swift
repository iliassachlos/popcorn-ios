import Foundation

@Observable
class SearchViewModel {
    var movies: Loadable<[Movie]> = .idle
    var searchTerm: String = ""
    var isLoadingMore: Bool = false
    
    private var currentPage = 1
    private var totalPages = 1
    
    private let service = MovieService()
    private var searchTask: Task<Void, Never>?
    
    func onSearchTermChanged() {
        searchTask?.cancel()
        
        let term = searchTerm.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !term.isEmpty else {
            movies = .idle
            resetPagination()
            return
        }
        
        searchTask = Task {
            try? await Task.sleep(for: .milliseconds(400))
            guard !Task.isCancelled else { return }
            
            await loadMovies(page: 1)
        }
    }
    
    func loadMore() async {
        guard currentPage < totalPages, !isLoadingMore else { return }
        
        await loadMovies(page: currentPage + 1)
    }
    
    private func loadMovies(page: Int) async {
        if page == 1 {
            movies = .loading
        } else {
            isLoadingMore = true
        }
        
        do {
            let response = try await service.fetchSearch(searchTerm: searchTerm, page: page)
            
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
    
    private func resetPagination() {
        currentPage = 1
        totalPages = 1

    }
}
