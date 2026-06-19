import Foundation

@Observable
class DiscoverViewModel {
    var trending: Loadable<[Movie]> = .idle
    var nowPlaying: Loadable<[Movie]> = .idle
    
    private let service = MovieService()
    
    func loadAll() async {
        async let trendingFetch = loadTrending()
        async let nowPlayingFetch = loadNowPlaying()
        _ = await (trendingFetch, nowPlayingFetch)
    }
    
    func loadTrending() async {
        trending = .loading
        
        do{
            let results = try await service.fetchTrending()
            
            trending = .loaded(results)
        } catch {
            trending = .failed(error)
        }
    }
    
    func loadNowPlaying() async {
        nowPlaying = .loading
        
        do {
            let results = try await service.fetchNowPlaying()
            
            nowPlaying = .loaded(results)
        }catch {
            nowPlaying = .failed(error)
        }
    }
    
}
