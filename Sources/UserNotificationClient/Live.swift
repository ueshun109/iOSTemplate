import Combine
import Foundation
import UserNotifications

public extension UserNotificationClient {
  static let live = Self(
    add: { request in
      Future { completion in
        UNUserNotificationCenter.current().add(request) { error in
          if let error = error {
            completion(.failure(error))
          } else {
            completion(.success(()))
          }
        }
      }
      .eraseToAnyPublisher()
    },
    delegate:
      Deferred { () -> AnyPublisher<Event, Never> in
        let passthrough = PassthroughSubject<Event, Never>()
        let delegate: Optional = Delegate(subscriber: passthrough)
        UNUserNotificationCenter.current().delegate = delegate
        return passthrough.eraseToAnyPublisher()
      }
      .eraseToAnyPublisher(),
    getNotificationSettings: {
      Future { completion in
        UNUserNotificationCenter.current().getNotificationSettings { settings in
          completion(.success(settings))
        }
      }
      .eraseToAnyPublisher()
    },
    requestAuthorization: { options in
      Future { completion in
        UNUserNotificationCenter.current().requestAuthorization(options: options) { granted, error in
          if let error = error {
            completion(.failure(error))
          } else {
            completion(.success(granted))
          }
        }
      }
      .eraseToAnyPublisher()
    }
  )
}

public extension UserNotificationClient {
  fileprivate class Delegate: NSObject, UNUserNotificationCenterDelegate {
    let subscriber: PassthroughSubject<Event, Never>

    init(subscriber: PassthroughSubject<Event, Never>) {
      self.subscriber = subscriber
    }

    func userNotificationCenter(
      _ center: UNUserNotificationCenter,
      didReceive response: UNNotificationResponse,
      withCompletionHandler completionHandler: @escaping () -> Void
    ) {
      subscriber.send(.didReceiveResponse(response, completionHandler: completionHandler))
//      subscriber(.success(.didReceiveResponse(response, completionHandler: completionHandler)))
    }

    func userNotificationCenter(
      _ center: UNUserNotificationCenter,
      willPresent notification: UNNotification,
      withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
      subscriber.send(.willPresentNotification(notification, completionHandler: completionHandler))
//      subscriber(.success(.willPresentNotification(notification, completionHandler: completionHandler)))
    }
  }
}
