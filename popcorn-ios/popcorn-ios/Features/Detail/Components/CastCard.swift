import SwiftUI

struct CastCard: View {
    static let imageSize: CGFloat = 80
    static let cardWidth: CGFloat = 90

    let member: CastMember

    var body: some View {
        VStack(spacing: Spacing.xs) {
            profileImage
            name
            character
        }
        .frame(width: Self.cardWidth)
    }
}

extension CastCard {
    static var skeleton: some View {
        VStack(spacing: Spacing.xs) {
            Circle()
                .fill(.surfaceMuted)
                .frame(width: imageSize, height: imageSize)

            RoundedRectangle(cornerRadius: 4)
                .fill(.surfaceMuted)
                .frame(width: 70, height: 12)

            RoundedRectangle(cornerRadius: 4)
                .fill(.surfaceMuted)
                .frame(width: 50, height: 10)
        }
        .frame(width: cardWidth)
    }
}

private extension CastCard {
    var profileImage: some View {
        AsyncImage(url: member.profileURL) { image in
            image.resizable().scaledToFill()
        } placeholder: {
            Rectangle()
                .fill(.surfaceMuted)
                .overlay {
                    Image(systemName: "person.fill")
                        .foregroundStyle(.textMuted)
                }
        }
        .frame(width: Self.imageSize, height: Self.imageSize)
        .clipShape(.circle)
    }

    var name: some View {
        Text(member.name)
            .font(Font.footnote)
            .foregroundStyle(Color.primary)
            .lineLimit(2)
            .multilineTextAlignment(.center)
    }

    @ViewBuilder
    var character: some View {
        if let character = member.character {
            Text(character)
                .font(Font.caption)
                .foregroundStyle(Color.textMuted)
                .lineLimit(1)
        }
    }
}

#Preview {
    HStack(alignment: .top) {
        CastCard(member: .preview)
        CastCard.skeleton
    }
    .padding()
}
