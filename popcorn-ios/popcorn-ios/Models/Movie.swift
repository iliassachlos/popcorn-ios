import Foundation

struct Movie: Decodable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Double
    let voteCount: Int
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
    
    var tmdbURL: URL? {
        URL(string: "https://www.themoviedb.org/movie/\(id)")
    }
    
    var releaseYear: String? {
        guard let releaseDate, releaseDate.count >= 4 else { return nil }
        return String(releaseDate.prefix(4))
    }
}

extension Movie {
    static let preview = Movie(
        id: 693134,
        title: "Dune: Part Two",
        overview: "Paul Atreides unites with the Fremen to wage war against House Harkonnen, torn between the love of his life and the fate of the universe.",
        posterPath: "/1pdfLvkbY9ohJlCjQH2CZjjYVvJ.jpg",
        backdropPath: "/xOMo8BRK7PfcJv9JCnx7s5hj0PX.jpg",
        voteAverage: 8.3,
        voteCount: 594,
        releaseDate: "2024-03-01",
        genreIds: [878, 12]
    )
}
