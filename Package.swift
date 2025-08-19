// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "rab-foundation",
    platforms: [
        .macOS(.v10_15),
        .macCatalyst(.v13),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6),
        .visionOS(.v1),
    ],
    products: [
        .library( name: "RabFoundation", targets: ["RabFoundation"],),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log", from: "1.6.0"),
        .package(url: "https://github.com/neallester/swift-log-testing", from: "0.0.0"),
    ],
    targets: [
        .target(
            name: "RabFoundation",
            dependencies: [
                .product(name: "Logging", package: "swift-log"),
                ]
        ),
        .testTarget(
            name: "RabFoundationTests",
            dependencies: [
                "RabFoundation",
                .product(name: "SwiftLogTesting", package: "swift-log-testing"),
                ],
            resources: [
                .process("TestInfo.plist"),
            ]
        ),
    ],
    swiftLanguageModes: [ .v6 ],
)

