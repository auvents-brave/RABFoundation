// swift-tools-version: 6.1

import PackageDescription
import Foundation

var prods: [Product] = [
    .library(
        name: "RABFoundation",
        targets: ["RabFoundation"]
    ),
]

var deps: [Package.Dependency] = [
    .package(
        url: "https://github.com/apple/swift-log",
        from: "1.6.0"
    ),
    .package(
        url: "https://github.com/neallester/swift-log-testing",
        from: "0.0.1"
    ),
]

#if false // (os(Linux) || os(Android))
prods.append(
    .library(
        name: "swift-doc",
        targets: ["RabFoundation"]
    ))
deps.append(
    .package(
        url: "https://github.com/apple/swift-docc-plugin",
        from: "1.4.0"
    ))
#endif

let package = Package(
    name: "rab-foundation",
    platforms: [
        .macOS(.v11),
        .macCatalyst(.v13),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6),
        .visionOS(.v1),
    ],

    products: prods,

    dependencies: deps,

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

