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

#if false
    deps.append(
        .package(
            url: "https://github.com/apple/swift-docc-plugin",
            from: "1.4.0"
        ))
#endif

let package = Package(
    name: "rab-foundation",
    platforms: [
        .macOS(.v12),
        .macCatalyst(.v14),
        .iOS(.v14),
        .tvOS(.v14),
        .watchOS(.v9),
        .visionOS(.v1),
    ],

    products: prods,

    dependencies: deps,

    targets: [
      .target(
        name: "RabFoundation",
        dependencies: [
          .product(name: "Logging", package: "swift-log"),
          .target(
            name: "RabFoundationApple",
            condition: .when(platforms: [.macOS, .macCatalyst, .iOS, .tvOS, .watchOS, .visionOS])
          )
        ],
      ),
      .target(
        name: "RabFoundationApple",
        dependencies: [
          .product(name: "Logging", package: "swift-log"),
        ],
        path: "Sources/Apple Only",
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
