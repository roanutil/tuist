import ProjectDescription

let project = Project(
    name: "App",
    targets: [
        .target(
            name: "App",
            destinations: [.iPad],
            product: .app,
            bundleId: "dev.tuist.app",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: "App/Sources/**",
            resources: "App/Resources/**",
            dependencies: [
                .target(name: "Lib"),
            ]
        ),
        .target(
            name: "Lib",
            destinations: [.iPad, .mac],
            product: .staticFramework,
            bundleId: "dev.tuist.app.lib",
            deploymentTargets: .iOS("16.0"),
            sources: "Lib/**",
            dependencies: [
                .external(name: "Parsing"),
                .external(name: "URLRouting"),
            ]
        )
    ]
)
