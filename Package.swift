// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WSOnBoarding",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "WSOnBoarding",
            targets: ["WSOnBoarding"]),
    ],
    dependencies: [
        // 无外部依赖
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        .target(
            name: "WSOnBoarding",
            dependencies: [],
            path: "Sources"),
        .testTarget(
            name: "WSOnBoardingTests",
            dependencies: ["WSOnBoarding"],
            path: "Tests"),
    ]
)
