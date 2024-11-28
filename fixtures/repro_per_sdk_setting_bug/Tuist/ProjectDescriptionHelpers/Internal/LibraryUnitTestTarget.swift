// LibraryUnitTestTarget.swift
// App

import ProjectDescription

/// Referenced in `public` declarations
public struct LibraryUnitTestTarget: Equatable {
    public let name: String
    public var resources: ResourceFileElements
    public let dependencies: [TargetDependency]

    public init(
        name: String,
        resources: ResourceFileElements,
        dependencies: Set<TargetDependency>
    ) {
        self.name = name
        self.resources = resources
        self.dependencies = Array(dependencies)
    }
}
