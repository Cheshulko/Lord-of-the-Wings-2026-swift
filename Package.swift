// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "LordOfTheWings",
    platforms: [.macOS(.v13)],
    products: [
        .executable(name: "LordOfTheWings", targets: ["LordOfTheWings"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.5.0"),
        .package(url: "https://github.com/apple/swift-collections", from: "1.1.0"),
        .package(url: "https://github.com/apple/swift-algorithms", from: "1.2.0"),
    ],
    targets: [
        .executableTarget(
            name: "LordOfTheWings",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Collections", package: "swift-collections"),
                .product(name: "Algorithms", package: "swift-algorithms"),
            ]
        ),
        .testTarget(
            name: "LordOfTheWingsTests",
            dependencies: ["LordOfTheWings"]
        ),
    ]
)
