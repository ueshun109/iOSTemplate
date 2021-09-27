// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "SamplePackage",
  platforms: [.iOS(.v14)],
  products: [
    .library(name: "AppFeature", targets: ["AppFeature"]),
  ],
  dependencies: [
    .package(name: "Firebase", url: "https://github.com/firebase/firebase-ios-sdk.git", from: "8.0.0"),
  ],
  targets: [
    .target(
      name: "AppFeature",
      dependencies: [
        "UserNotificationClient",
        .product(name: "FirebaseAnalytics", package: "Firebase"),
        .product(name: "FirebaseCrashlytics", package: "Firebase"),
        .product(name: "FirebaseMessaging", package: "Firebase"),
      ]
    ),
    .testTarget(name: "AppFeatureTest", dependencies: ["AppFeature"]),
    .target(name: "UserNotificationClient"),
  ]
)
