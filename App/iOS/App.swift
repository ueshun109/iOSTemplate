import AppFeature
import SwiftUI

@main
struct TemplateApp: App {
  private let userNotifications: UserNotificationClient = .live

  @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
  var body: some Scene {
    WindowGroup {
      AppView(userNotifications: userNotifications)
    }
  }
}
