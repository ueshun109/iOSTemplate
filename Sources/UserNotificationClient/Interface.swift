import Combine
import UserNotifications

public struct UserNotificationClient {
  public var add: (UNNotificationRequest) -> AnyPublisher<Void, Error>
  public var delegate: AnyPublisher<Event, Never>
  public var getNotificationSettings: () ->AnyPublisher<UNNotificationSettings, Never>
  public var requestAuthorization: (UNAuthorizationOptions) -> AnyPublisher<Bool, Error>

  public enum Event: Equatable {
    case didReceiveResponse(UNNotificationResponse, completionHandler: () -> Void)
    case willPresentNotification(UNNotification, completionHandler: (UNNotificationPresentationOptions) -> Void)

    public static func == (lhs: UserNotificationClient.Event, rhs: UserNotificationClient.Event) -> Bool {
      switch (lhs, rhs) {
      case let (.didReceiveResponse(lhs, _), .didReceiveResponse(rhs, _)):
        return lhs == rhs
      case let (.willPresentNotification(lhs, _), .willPresentNotification(rhs, _)):
        return lhs == rhs
      default:
        return false
      }
    }
  }
}
