// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "ConcurrentDictionary",
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
