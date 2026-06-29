import SwiftUI
import SwiftData

@main
struct popcorn_iosApp: App {
    @AppStorage("theme") private var theme: AppearanceMode = .light

    var body: some Scene {
        WindowGroup {
            RootView()
                .preferredColorScheme(theme.colorScheme)
        }
        .modelContainer(.appContainer)
    }
}
