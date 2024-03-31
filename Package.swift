// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CustomAlertKit",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "CustomAlertKit",
            targets: ["CustomAlertKit"]),
    ],
    targets: [
        .target(
            name: "CustomAlertKit"),
        .testTarget(
            name: "CustomAlertKitTests",
            dependencies: ["CustomAlertKit"]),
    ],
    swiftLanguageVersions: [.v5]
)
