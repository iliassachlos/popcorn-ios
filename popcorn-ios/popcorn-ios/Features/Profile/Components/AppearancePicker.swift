import SwiftUI

struct AppearancePicker: View {
    @Binding var selection: AppearanceMode
    
    var body: some View {
        List {
            ForEach(AppearanceMode.allCases) { mode in
                Button {
                    selection = mode
                } label: {
                    HStack {
                        Text(mode.label).foregroundStyle(.primary)
                        Spacer()
                        if mode == selection {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.accent)
                        }
                    }
                }
            }
        }
        .foregroundStyle(Color.textPrimary)
        .navigationTitle("Appearance")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    @Previewable @AppStorage("theme") var theme: AppearanceMode = .light
    ProfileView()
        .preferredColorScheme(theme.colorScheme)
}
