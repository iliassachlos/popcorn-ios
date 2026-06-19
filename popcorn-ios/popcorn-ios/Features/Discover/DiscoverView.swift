import SwiftUI

struct DiscoverView: View {
    @State private var viewModel = DiscoverViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: Spacing.xl) {
                   featuredSection
                }
                .padding(.bottom, Spacing.xs)
                
            }
            .navigationTitle("Discover")
        }
        .task {
            await viewModel.loadAll()
        }
    }
}

private extension DiscoverView {
    @ViewBuilder
    var featuredSection: some View {
        switch viewModel.trending {
        case .idle, .loading:
            FeaturedCard.placeholder
        case .loaded(let movies):
            if let featured = movies.first {
                FeaturedCard(movie: featured)
                    .padding(.horizontal, Spacing.md)
            }
        case .failed:
            EmptyView()
        }
    }
}


#Preview {
    DiscoverView()
}
