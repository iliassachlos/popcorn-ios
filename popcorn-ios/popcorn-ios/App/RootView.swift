import SwiftUI
import SwiftData

struct RootView: View {
    var body: some View {
        TabView {
            DiscoverView()
                .tabItem {
                    Label(
                        "Discover",
                        systemImage: "film"
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
