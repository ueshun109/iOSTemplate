import SwiftUI
import UserNotificationClient

public struct AppView: View {
  private let viewModel: AppViewModel

  public init(userNotifications: UserNotificationClient) {
    self.viewModel = AppViewModel(userNotifications: userNotifications)
  }

  public var body: some View {
    Button("Crash") {
      fatalError()
    }
  }
}

import Combine

final class AppViewModel: ObservableObject {
  private let userNotifications: UserNotificationClient
  private var cancellables: Set<AnyCancellable> = []

  init(userNotifications: UserNotificationClient) {
    self.userNotifications = userNotifications

    self.userNotifications.requestAuthorization([.alert, .badge, .sound])
      .receive(on: DispatchQueue.main)
      .sink { response in
      } receiveValue: { result in
        guard result else { return }
        UIApplication.shared.registerForRemoteNotifications()
      }
      .store(in: &self.cancellables)
  }
}
