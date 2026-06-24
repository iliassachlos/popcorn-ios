import Foundation

struct MovieService {
    func fetchTrending() async throws -> [Movie] {
        let response: PagedResponse<Movie> = try await APIClient.fetch(
            Endpoint(path: "/trending/movie/week", queryItems: [])
        )
        
        print("🎬 service got \(response.results.count) movies, unique ids: \(Set(response.results.map(\.id)).count)")

        return response.results
    }

    func fetchNowPlaying() async throws -> [Movie] {
        let response: PagedResponse<Movie> = try await APIClient.fetch(
            Endpoint(path: "/movie/now_playing", queryItems: [])
        )

        return response.results
    }

    func fetchDetail(id: Int) async throws -> MovieDetail {
        let response: MovieDetail = try await APIClient.fetch(
            Endpoint(
                path: "/movie/\(id)",
                queryItems: [URLQueryItem(
                    name: "append_to_response",
                    value: "videos"
                )]
            )
        )
        
        return response
    }
}
