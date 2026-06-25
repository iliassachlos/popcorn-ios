import SwiftUI

struct SearchView: View {
    @State private var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            results
                .navigationTitle("Search")
                .searchable(text: $viewModel.searchTerm)
                .onChange(of: viewModel.searchTerm) { _, _ in
                    viewModel.onSearchTermChanged()
                }
        }
    }
}

private extension SearchView {
    @ViewBuilder
    var results: some View {
        switch viewModel.movies {
        case .idle:
            ContentUnavailableView(
                "Start typing to search",
                systemImage: "magnifyingglass"
            )
        case .loading:
            ProgressView().frame(maxWidth: .infinity)
        case .loaded(let movies):
            if movies.isEmpty {
                ContentUnavailableView.search(text: viewModel.searchTerm)
            } else {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(movies) {movie in
                            NavigationLink {
                                MovieDetailView(movie: movie)
                            } label : {
                                MovieRow(movie: movie)
                                    .padding(.horizontal)
                                    .padding(.vertical, Spacing.sm)
                            }
                            .task {
                                if movie.id == movies.last?.id {
                                    await viewModel.loadMore()
                                }
                            }
                        }
                        
                        if viewModel.isLoadingMore {
                            ProgressView()
                                .frame(maxWidth: .infinity)
                                .padding()
                        }
                    }

                }
//                List {
//                    Section {
//                        ForEach(movies) { movie in
//                            NavigationLink {
//                                MovieDetailView(movie: movie)
//                            } label: {
//                                MovieRow(movie: movie)
//                            }
//                            .task {
//                                if movie.id == movies.last?.id {
//                                    await viewModel.loadMore()
//                                }
//                            }
//                        }
//                        
//                        if viewModel.isLoadingMore {
//                            ProgressView()
//                                .frame(maxWidth: .infinity)
//                                .listRowSeparator(.hidden)
//                        }
//                    }
//                }
//                .listStyle(.insetGrouped)
//                .scrollContentBackground(.hidden)
//                .background(.clear)
            }
        case .failed:
            ContentUnavailableView(
                "Search failed",
                systemImage: "exclamationmark.triangle"
            )
        }
    }
}

#Preview {
    SearchView()
}
