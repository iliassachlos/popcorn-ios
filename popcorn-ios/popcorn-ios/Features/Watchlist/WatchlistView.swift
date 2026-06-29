import SwiftUI
import SwiftData

struct WatchlistView: View {
    @Query(sort: \SavedMovie.savedAt, order: .reverse)
    private var savedMovies: [SavedMovie]

    @Environment(\.modelContext) private var modelContext

    var body: some View {
        NavigationStack {
            Group {
                if savedMovies.isEmpty {
                    emptyState
                } else {
                    list
                }
            }
            .navigationTitle("Watchlist")
        }
    }
}

private extension WatchlistView {
    var emptyState: some View {
        ContentUnavailableView(
            "No movies saved",
            systemImage: "bookmark.fill",
            description: Text("Movies you bookmark will appear here.")
        )
    }

    var list: some View {
        List(savedMovies) { saved in
            NavigationLink {
                MovieDetailView(movie: saved.toMovie())
            } label: {
                WatchlistRow(movie: saved)
            }
            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                Button(role: .destructive) {
                    modelContext.delete(saved)
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    WatchlistView()
}
