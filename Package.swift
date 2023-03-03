// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "SudokuTools",
    platforms: [
        .macOS(.v10_13),
        .macCatalyst(.v13),
        .iOS(.v13),
        .watchOS(.v6),
        .tvOS(.v13)
    ],
    products: [
        .library(
            name: "SudokuTools",
            targets: ["SudokuTools"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "11.2.1"))
    ],
    targets: [
        .target(
            name: "SudokuTools",
            dependencies: []),
        .testTarget(
            name: "SudokuToolsTests",
            dependencies: ["SudokuTools", "Nimble"]),
    ]
)
