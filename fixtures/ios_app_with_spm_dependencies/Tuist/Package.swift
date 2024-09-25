// swift-tools-version: 6.0
@preconcurrency import PackageDescription

let package = Package(
    name: "PackageName",
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", from: "1.15.0"),
    ]
)
