// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "RABFoundation",
    platforms: [
        .macOS(.v11),
        .macCatalyst(.v14),
        .iOS(.v14),
        .tvOS(.v14),
        .watchOS(.v5),
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
