import Foundation

struct MovieService {
    func fetchTrending(page: Int) async throws -> PagedResponse<Movie> {
        let response: PagedResponse<Movie> = try await APIClient.fetch(
            Endpoint(path: "/trending/movie/week", queryItems: [
                URLQueryItem(name: "page", value:"\(page)")
            ])
        )

        return response
    }

    func fetchNowPlaying(page: Int) async throws -> PagedResponse<Movie>  {
        let response: PagedResponse<Movie> = try await APIClient.fetch(
            Endpoint(path: "/movie/now_playing", queryItems: [
                URLQueryItem(name: "page", value:"\(page)")
            ])
        )

        return response
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
