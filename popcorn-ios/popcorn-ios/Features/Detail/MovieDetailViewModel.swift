import Foundation
import SwiftData

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
    
    func toggleSave(existing: SavedMovie?, context: ModelContext) {
        if let existing {
            context.delete(existing)
            return
        }
        
        guard let detail = movie.value else { return }
        
        let savedMovie = SavedMovie(
            id: detail.id,
            title: detail.title,
            overview: detail.overview,
            posterPath: detail.posterPath,
            backdropPath: detail.backdropPath,
            voteAverage: detail.voteAverage,
            mainGenre: detail.genres.first?.name,
            releaseDate: detail.releaseDate
        )
        
        context.insert(savedMovie)
        
    }
}
