// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RUIComponents",
    platforms: [.iOS(.v15)],
    products:  [
        .library(
            name: "RToastView",
            targets: ["RToastView"]
        ),
        .library(
            name: "RGridIconView",
            targets: ["RGridIconView"]
        ),
        .library(
            name: "ROverlappingCirclesStack",
            targets: ["ROverlappingCirclesStack"]
        ),
        .library(
            name: "RWaterfallGrid",
            targets: ["RWaterfallGrid"]
        )
    ],
    dependencies: [],
    targets: [
        .target(name: "RToastView", dependencies: []),
        .target(name: "RGridIconView", dependencies: []),
        .target(name: "ROverlappingCirclesStack", dependencies: []),
        .target(
            name: "RWaterfallGrid",
            dependencies: [.target(name: "RGridIconView")]
        )
    ]
)
