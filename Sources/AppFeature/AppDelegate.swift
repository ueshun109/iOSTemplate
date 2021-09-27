import Combine
import Firebase
import UIKit
@_exported import UserNotificationClient

public final class AppDelegate: NSObject, UIApplicationDelegate {
  private var cancellables: [AnyCancellable] = []
  private let userNotification: UserNotificationClient = .live

  // MARK: - UIApplicationDelegate
  public func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
  ) -> Bool {
    // Firebase initialize.
    FirebaseApp.configure()

    userNotification.delegate
      .sink { _ in
        print("complete")
      } receiveValue: { event in
        switch event {
        case let .didReceiveResponse(_, completion):
          completion()
        case let .willPresentNotification(_, completion):
          completion([.banner])
        }
      }
      .store(in: &self.cancellables)
    return true
  }
}
