import Foundation

struct Movie: Decodable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Double
    let releaseDate: String?
    let genreIds: [Int]?
    
    var posterUrl: URL? {
        guard let posterPath else {return nil}
        
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }
    
    var backdropURL: URL? {
        guard let backdropPath else {return nil}
        
        return URL(string: "https://image.tmdb.org/t/p/w1280\(backdropPath)")
    }
}
