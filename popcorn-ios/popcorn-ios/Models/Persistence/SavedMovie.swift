import Foundation
import SwiftData

@Model
final class SavedMovie {
    @Attribute(.unique) var id: Int
    var title: String
    var overview: String?
    var posterPath: String?
    var backdropPath: String?
    var voteAverage: Double
    var savedAt: Date
    var mainGenre: String?
    var releaseDate: String?

    init(
        id: Int,
        title: String,
        overview: String? = nil,
        posterPath: String? = nil,
        backdropPath: String? = nil,
        voteAverage: Double,
        savedAt: Date = .now,
        mainGenre: String? = nil,
        releaseDate: String? = nil
    ) {
        self.id = id
        self.title = title
        self.overview = overview
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.voteAverage = voteAverage
        self.savedAt = savedAt
        self.mainGenre = mainGenre
        self.releaseDate = releaseDate
    }
}

extension SavedMovie {
    var posterUrl: URL? {
        guard let posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }

    var releaseYear: String? {
        guard let releaseDate, releaseDate.count >= 4 else { return nil }
        return String(releaseDate.prefix(4))
    }

    func toMovie() -> Movie {
        Movie(
            id: id,
            title: title,
            overview: overview ?? "",
            posterPath: posterPath,
            backdropPath: backdropPath,
            voteAverage: voteAverage,
            voteCount: 0,
            releaseDate: releaseDate,
            genreIds: nil
        )
    }
}
