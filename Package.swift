// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "RABNmea",
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
            name: "RABNmea",
            targets: ["RABNmea"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "RABNmea"),
        .testTarget(
            name: "RABNmeaests",
            dependencies: ["RABNmea"]
        ),
    ],
    swiftLanguageModes: [ .v6 ],
)
