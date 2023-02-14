// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "SudokuTools",
    platforms: [
        .macOS(.v10_13),
        .macCatalyst(.v13),
        .iOS(.v11),
        .watchOS(.v4),
        .tvOS(.v11),
        .driverKit(.v19)
    ],
    products: [
        .library(
            name: "SudokuTools",
            targets: ["SudokuTools"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "11.2.1")),
        .package(url: "https://github.com/Quick/Quick.git", .upToNextMajor(from: "6.1.0"))
    ],
    targets: [
        .target(
            name: "SudokuTools",
            dependencies: []),
        .testTarget(
            name: "SudokuToolsTests",
            dependencies: ["SudokuTools", "Nimble", "Quick"]),
    ]
)
