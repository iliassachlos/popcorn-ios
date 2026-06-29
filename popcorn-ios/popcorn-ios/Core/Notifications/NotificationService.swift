import UserNotifications

enum NotificationService {
    private static let dailyReminderID = "daily-new-releases"

    enum AuthorizationOutcome {
        case granted
        case denied
        case needsSettings
    }

    static func ensureAuthorization() async -> AuthorizationOutcome {
        let settings = await UNUserNotificationCenter.current().notificationSettings()

        switch settings.authorizationStatus {
        case .authorized, .provisional, .ephemeral:
            return .granted
        case .denied:
            return .needsSettings
        case .notDetermined:
            let granted = (try? await UNUserNotificationCenter.current()
                .requestAuthorization(options: [.alert, .badge, .sound])) ?? false
            
            return granted ? .granted : .denied
        @unknown default:
            return .denied
        }
    }

    static func scheduleDailyNewReleasesReminder() {
        let content = UNMutableNotificationContent()
        content.title = "New releases on Popcorn"
        content.body = "See what's trending and just out today."
        content.sound = .default

        var components = DateComponents()
        components.hour = 18

        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(
            identifier: dailyReminderID,
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request)
    }

    static func cancelDailyReminder() {
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: [dailyReminderID])
    }
}
