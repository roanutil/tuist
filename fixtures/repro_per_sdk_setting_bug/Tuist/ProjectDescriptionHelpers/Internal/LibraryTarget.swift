// LibraryTarget.swift
// App

import ProjectDescription

/// Referenced in `public` declarations
public struct LibraryTarget: Equatable {
    public let name: String
    public let resources: ResourceFileElements
    public let dependencies: [TargetDependency]
    public let unitTestTarget: LibraryUnitTestTarget?
    public let additionalFiles: [FileElement]?

    public init(
        name: String,
        resources: ResourceFileElements,
        dependencies: Set<TargetDependency>,
        hasTests: Bool,
        extraTestDependencies: Set<TargetDependency> = [],
        testResources: ResourceFileElements = [],
        additionalFiles: [FileElement]? = nil
    ) {
        self.name = name
        self.resources = resources
        self.dependencies = Array(dependencies)
        self.additionalFiles = additionalFiles
        if hasTests {
            unitTestTarget = LibraryUnitTestTarget(
                name: "\(name)Tests",
                resources: testResources,
                dependencies: dependencies.union(extraTestDependencies).union([.target(name: name)])
            )
        } else {
            unitTestTarget = nil
        }
    }
}
