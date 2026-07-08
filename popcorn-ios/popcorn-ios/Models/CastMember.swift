import Foundation

struct CastMember: Decodable, Identifiable {
    let id: Int
    let name: String
    let character: String?
    let profilePath: String?
    let order: Int?

    var profileURL: URL? {
        guard let profilePath else { return nil }

        return URL(string: "https://image.tmdb.org/t/p/w185\(profilePath)")
    }
}

extension CastMember {
    static let preview = CastMember(
        id: 505710,
        name: "Timothée Chalamet",
        character: "Paul Atreides",
        profilePath: "/BE2sdjpgsa2rNTFa66f7upkaOP.jpg",
        order: 0
    )
}
