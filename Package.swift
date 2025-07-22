// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "RABFoundation",
    platforms: [
        .macOS(.v10_15),
        .macCatalyst(.v13),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6),
        .visionOS(.v1),
    ],
    products: [
        .library(
            name: "RABFoundation",
            targets: ["RABFoundation"],
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log", from: "1.6.0"),
        .package(url: "https://github.com/neallester/swift-log-testing", from: "0.0.0"),
    ],    targets: [
        .target(
            name: "RABFoundation",
            dependencies: [
                .product(name: "Logging", package: "swift-log"),
                ]
        ),
        .testTarget(
            name: "RABFoundationTests",
            dependencies: [
                "RABFoundation",
                .product(name: "SwiftLogTesting", package: "swift-log-testing"),
                ]
        ),
    ],
    swiftLanguageModes: [ .v6 ],
)
