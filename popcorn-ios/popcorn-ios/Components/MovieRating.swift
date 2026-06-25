import SwiftUI

struct MovieRating: View {
    let rating: Double
    
    var body: some View {
        HStack(spacing: Spacing.xs) {
            Image(systemName: "star.fill")
                .font(Font.caption)
                .foregroundStyle(Color.warning)
            Text(String(format: "%.1f", rating))
                .font(Font.body)
                .fontWeight(.bold)
        }
    }
}

#Preview {
    MovieRating(rating: 4.8)
}
