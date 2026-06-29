import SwiftUI
import UIKit

struct ProfileView: View {
    @AppStorage("theme") private var theme: AppearanceMode = .light
    @AppStorage("newReleaseAlerts") private var newReleaseAlerts: Bool = false

    @Environment(\.openURL) private var openURL
    @State private var showSettingsAlert = false

    func handleAlertsChange(enabled: Bool) async {
        if enabled {
            switch await NotificationService.ensureAuthorization() {
            case .granted:
                NotificationService.scheduleDailyNewReleasesReminder()
            case .needsSettings:
                newReleaseAlerts = false
                showSettingsAlert = true
            case .denied:
                newReleaseAlerts = false
            }
        } else {
            NotificationService.cancelDailyReminder()
        }
    }

    var body: some View {
        NavigationStack {
            List {
                userSection
                preferenceSection
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Profile")
            .alert("Notifications are off", isPresented: $showSettingsAlert) {
                Button("Open Settings") {
                    if let url = URL(
                        string: UIApplication.openSettingsURLString
                    ) {
                        openURL(url)
                    }
                }
                Button("Not now", role: .cancel) { }
            } message: {
                Text(
                    "To get new release alerts, turn on notifications for Popcorn in Settings."
                )
            }
        }
    }
}

private extension ProfileView {
    var userSection: some View {
        Section {
            HStack(spacing: Spacing.md) {
                Circle()
                    .fill(.teal)
                    .frame(width: 56, height: 56)
                    .overlay {
                        Text("TU")
                            .font(.title3.bold())
                            .foregroundStyle(.white)
                    }
                
                VStack(alignment: .leading) {
                    Text("Test User")
                        .font(Font.headline)
                    Text(verbatim: "testUser@mail.com")
                        .font(Font.subheadline)
                        .foregroundStyle(Color.textMuted)
                }
                
                Spacer()
            }
        }
    }
    
    var preferenceSection: some View {
    
        Section("Preferences") {
            NavigationLink {
                AppearancePicker(selection: $theme)
            } label: {
                Label {
                    Text("Appearance")
                } icon: {
                    IconBadge(image: "moon.fill", color: .purple)
                }
            }

            Toggle(isOn: $newReleaseAlerts) {
                Label {
                    Text("New Release Alerts")
                } icon: {
                    IconBadge(image: "bell.fill", color: .red)
                }
            }
            .onChange(of: newReleaseAlerts) { _, newValue in
                Task { await handleAlertsChange(enabled: newValue) }
            }
        }
    }
}

#Preview {
    ProfileView()
}
