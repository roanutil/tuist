// swift-tools-version: 5.10
@preconcurrency import PackageDescription

let package = Package(
    name: "PackageName",
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-url-routing.git", from: "0.1.0"),
    ]
)
