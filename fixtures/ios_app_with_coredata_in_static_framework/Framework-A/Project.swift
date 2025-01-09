import ProjectDescription

let project = Project(
    name: "Framework-A",
    targets: [
        .target(
            name: "Framework-A",
            destinations: .iOS,
            product: .staticFramework,
            bundleId: "io.tuist.framework-a",
            infoPlist: .default,
            sources: ["Sources/**"],
            coreDataModels: [
                .coreDataModel("CoreData/Users.xcdatamodeld"),
            ]
        ),
    ]
)
