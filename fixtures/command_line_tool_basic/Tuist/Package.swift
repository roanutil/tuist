// swift-tools-version:5.10

import PackageDescription

let package = Package(
    name: "workspace-dependencies",
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-system.git",
            exact: "1.2.1"
        ),
    ]
)
