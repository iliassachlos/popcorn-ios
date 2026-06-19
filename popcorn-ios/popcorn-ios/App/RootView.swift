import SwiftUI
import SwiftData

struct RootView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView {
            DiscoverView()
                .tabItem {
                    Label(
                        "Discover",
                        systemImage: selectedTab == 0 ? "film.fill" : "film"
                    )
                }
            WatchlistView()
                .tabItem {
                    Label("Watchlist", systemImage: "bookmark")
                }
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}

#Preview {
    RootView()
}
