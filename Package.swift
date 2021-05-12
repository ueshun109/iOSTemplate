// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "SamplePackage",
  platforms: [
    .iOS(.v14), .watchOS(.v7)
  ],
  products: [
    .library(name: "Sample1", targets: ["Sample1"]),
  ],
  dependencies: [
    // .package(url: /* package url */, from: "1.0.0"),
  ],
  targets: [
    .target(name: "Sample1", dependencies: []),
    .testTarget(name: "Sample1Tests", dependencies: ["Sample1"]),
  ]
)
