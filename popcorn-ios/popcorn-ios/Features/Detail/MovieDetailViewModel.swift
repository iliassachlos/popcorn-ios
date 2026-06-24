import Foundation

@Observable
class MovieDetailViewModel {
    var movie: Loadable<MovieDetail> = .idle
    
    private let service = MovieService()
    
    func loadMovie(id: Int) async {
        movie = .loading
        
        do {
            let result = try await service.fetchDetail(id: id)
            
            movie = .loaded(result)
        } catch {
            movie = .failed(error)
        }
    }
}
