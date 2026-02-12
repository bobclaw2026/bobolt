// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "BoboltKit",
    platforms: [
        .iOS(.v18),
        .macOS(.v15),
    ],
    products: [
        .library(name: "BoboltProtocol", targets: ["BoboltProtocol"]),
        .library(name: "BoboltKit", targets: ["BoboltKit"]),
        .library(name: "BoboltChatUI", targets: ["BoboltChatUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/steipete/ElevenLabsKit", exact: "0.1.0"),
        .package(url: "https://github.com/gonzalezreal/textual", exact: "0.3.1"),
    ],
    targets: [
        .target(
            name: "BoboltProtocol",
            path: "Sources/BoboltProtocol",
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency"),
            ]),
        .target(
            name: "BoboltKit",
            dependencies: [
                "BoboltProtocol",
                .product(name: "ElevenLabsKit", package: "ElevenLabsKit"),
            ],
            path: "Sources/BoboltKit",
            resources: [
                .process("Resources"),
            ],
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency"),
            ]),
        .target(
            name: "BoboltChatUI",
            dependencies: [
                "BoboltKit",
                .product(
                    name: "Textual",
                    package: "textual",
                    condition: .when(platforms: [.macOS, .iOS])),
            ],
            path: "Sources/BoboltChatUI",
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency"),
            ]),
        .testTarget(
            name: "BoboltKitTests",
            dependencies: ["BoboltKit", "BoboltChatUI"],
            path: "Tests/BoboltKitTests",
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency"),
                .enableExperimentalFeature("SwiftTesting"),
            ]),
    ])
