import SwiftUI

struct IconBadge: View {
    let image: String
    let color: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(color)
            .frame(width: 30, height: 30)
            .overlay {
                Image(systemName: image)
                    .font(.system(size: 15))
                    .foregroundStyle(.white)
            }
    }
}
