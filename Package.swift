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
    ],
    targets: [
        .executableTarget(
            name: "LordOfTheWings",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
        .testTarget(
            name: "LordOfTheWingsTests",
            dependencies: ["LordOfTheWings"]
        ),
    ]
)
