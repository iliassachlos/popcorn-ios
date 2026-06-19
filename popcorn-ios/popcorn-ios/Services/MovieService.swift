struct MovieService {
    func fetchTrending() async throws -> [Movie] {
        let response: PagedResponse<Movie> = try await APIClient.fetch(Endpoint(path: "/trending/movie/week", queryItems: []))
        
        return response.results
    }
    
    func fetchNowPlaying() async throws -> [Movie] {
        let response: PagedResponse<Movie> = try await APIClient.fetch(Endpoint(path: "/movie/now_playing", queryItems: []))
        
        return response.results
    }
}
