import Foundation

enum MoviesFeed {
    case trending
    case nowPlaying

    var title: String {
        switch self {
        case .trending: "Trending"
        case .nowPlaying: "New Releases"
        }
    }
}
