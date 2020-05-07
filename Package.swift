// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "ConcurrentDictionary",
    platforms: [
        .macOS(.v10_14),
        .iOS(.v12),
        .watchOS(.v5),
        .tvOS(.v12)
    ],
    products: [
        .library(
            name: "ConcurrentDictionary",
            targets: ["ConcurrentDictionary"]
        ),
    ],
    targets: [
        .target(
            name: "ConcurrentDictionary",
            dependencies: []
        ),
        .testTarget(
            name: "ConcurrentDictionaryTests",
            dependencies: ["ConcurrentDictionary"]
        ),
    ]
)