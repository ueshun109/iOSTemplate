// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BuildTools",
    platforms: [.macOS(.v10_14)],
    dependencies: [
        .package(url: "https://github.com/peripheryapp/periphery", from: "2.0.0"),
        .package(url: "https://github.com/mono0926/LicensePlist", from: "3.0.0"),
    ],
    targets: [.target(name: "BuildTools", path: "")]
)
