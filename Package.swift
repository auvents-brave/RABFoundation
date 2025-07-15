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
            targets: ["RABFoundation"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "RABFoundation"),
        .testTarget(
            name: "RABFoundationTests",
            dependencies: ["RABFoundation"]
        ),
    ],
    swiftLanguageModes: [ .v6 ],
)
