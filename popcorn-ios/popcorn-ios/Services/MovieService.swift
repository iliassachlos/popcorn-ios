import Foundation

struct MovieService {
    func fetchTrending() async throws -> [Movie] {
        let response: PagedResponse<Movie> = try await APIClient.fetch(
            Endpoint(path: "/trending/movie/week", queryItems: [])
        )


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
    
    func fetchSearch(searchTerm: String, page: Int) async throws -> PagedResponse<Movie> {
        print("Fetching for page: \(page)")
        
        let response: PagedResponse<Movie> = try await APIClient.fetch(
            Endpoint(
                path: "/search/movie",
                queryItems: [
                    URLQueryItem(name: "query", value: searchTerm),
                    URLQueryItem(name: "page", value: "\(page)")
                ]
            )
        )
        
        return response
    }
}
