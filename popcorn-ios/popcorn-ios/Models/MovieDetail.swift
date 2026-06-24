import Foundation

struct MovieDetail: Decodable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Double
    let voteCount: Int
    let releaseDate: String?
    let runtime: Int?
    let genres: [Genre]
    let videos: VideoResponse?

    struct VideoResponse: Decodable {
        let results: [Video]
    }

    var formattedRuntime: String {
        guard let runtime else { return "—" }
        let hours = runtime / 60
        let minutes = runtime % 60
        return hours > 0 ? "\(hours)h \(minutes)m" : "\(minutes)m"
    }

    var genreNames: String {
        genres.map(\.name).joined(separator: " · ")
    }

    var trailerURL: URL? {
        let trailers = videos?.results.filter {
            $0.type == "Trailer" && $0.site == "YouTube"
        } ?? []
        
        let best = trailers.first { $0.official } ?? trailers.first
        
        guard let key = best?.key else { return nil }
        
        return URL(string: "https://www.youtube.com/watch?v=\(key)")
    }
}
