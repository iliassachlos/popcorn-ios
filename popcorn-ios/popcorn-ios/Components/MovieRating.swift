import SwiftUI

 enum RatingFontWeight {
    case light
    case bold
}

struct MovieRating: View {
    let rating: Double
    var style: RatingFontWeight = .light
    
    var body: some View {
        HStack(spacing: Spacing.sm) {
            Image(systemName: "star.fill")
                .font(Font.caption)
                .foregroundStyle(Color.warning)
            Text(String(format: "%.1f", rating))
                .font(Font.body)
                .fontWeight(style == .light ? .light : .bold)
        }
    }
}

#Preview {
    MovieRating(rating: 4.8)
}
