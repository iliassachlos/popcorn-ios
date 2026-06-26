import SwiftUI
import SwiftData

@main
struct popcorn_iosApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(.appContainer)
    }
}
