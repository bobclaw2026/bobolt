// swift-tools-version: 6.2
// Package manifest for the Bobolt macOS companion (menu bar app + IPC library).

import PackageDescription

let package = Package(
    name: "Bobolt",
    platforms: [
        .macOS(.v15),
    ],
    products: [
        .library(name: "BoboltIPC", targets: ["BoboltIPC"]),
        .library(name: "BoboltDiscovery", targets: ["BoboltDiscovery"]),
        .executable(name: "Bobolt", targets: ["Bobolt"]),
        .executable(name: "bobolt-mac", targets: ["BoboltMacCLI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/orchetect/MenuBarExtraAccess", exact: "1.2.2"),
        .package(url: "https://github.com/swiftlang/swift-subprocess.git", from: "0.1.0"),
        .package(url: "https://github.com/apple/swift-log.git", from: "1.8.0"),
        .package(url: "https://github.com/sparkle-project/Sparkle", from: "2.8.1"),
        .package(url: "https://github.com/steipete/Peekaboo.git", branch: "main"),
        .package(path: "../shared/BoboltKit"),
        .package(path: "../../Swabble"),
    ],
    targets: [
        .target(
            name: "BoboltIPC",
            dependencies: [],
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency"),
            ]),
        .target(
            name: "BoboltDiscovery",
            dependencies: [
                .product(name: "BoboltKit", package: "BoboltKit"),
            ],
            path: "Sources/BoboltDiscovery",
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency"),
            ]),
        .executableTarget(
            name: "Bobolt",
            dependencies: [
                "BoboltIPC",
                "BoboltDiscovery",
                .product(name: "BoboltKit", package: "BoboltKit"),
                .product(name: "BoboltChatUI", package: "BoboltKit"),
                .product(name: "BoboltProtocol", package: "BoboltKit"),
                .product(name: "SwabbleKit", package: "swabble"),
                .product(name: "MenuBarExtraAccess", package: "MenuBarExtraAccess"),
                .product(name: "Subprocess", package: "swift-subprocess"),
                .product(name: "Logging", package: "swift-log"),
                .product(name: "Sparkle", package: "Sparkle"),
                .product(name: "PeekabooBridge", package: "Peekaboo"),
                .product(name: "PeekabooAutomationKit", package: "Peekaboo"),
            ],
            exclude: [
                "Resources/Info.plist",
            ],
            resources: [
                .copy("Resources/Bobolt.icns"),
                .copy("Resources/DeviceModels"),
            ],
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency"),
            ]),
        .executableTarget(
            name: "BoboltMacCLI",
            dependencies: [
                "BoboltDiscovery",
                .product(name: "BoboltKit", package: "BoboltKit"),
                .product(name: "BoboltProtocol", package: "BoboltKit"),
            ],
            path: "Sources/BoboltMacCLI",
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency"),
            ]),
        .testTarget(
            name: "BoboltIPCTests",
            dependencies: [
                "BoboltIPC",
                "Bobolt",
                "BoboltDiscovery",
                .product(name: "BoboltProtocol", package: "BoboltKit"),
                .product(name: "SwabbleKit", package: "swabble"),
            ],
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency"),
                .enableExperimentalFeature("SwiftTesting"),
            ]),
    ])
