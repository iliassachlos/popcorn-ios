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

extension Movie {
    static let preview = Movie(
        id: 693134,
        title: "Dune: Part Two",
        overview: "Paul Atreides unites with the Fremen to wage war against House Harkonnen, torn between the love of his life and the fate of the universe.",
        posterPath: "/1pdfLvkbY9ohJlCjQH2CZjjYVvJ.jpg",
        backdropPath: "/xOMo8BRK7PfcJv9JCnx7s5hj0PX.jpg",
        voteAverage: 8.3,
        releaseDate: "2024-03-01",
        genreIds: [878, 12]
    )
}
