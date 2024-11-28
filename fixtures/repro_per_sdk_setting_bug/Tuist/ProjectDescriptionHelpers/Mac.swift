// Mac.swift
// App

import ProjectDescription

private enum MacLibraryTarget: String, CaseIterable {
    case macFeature = "MacFeature"
}

extension MacLibraryTarget {
    fileprivate var libraryTarget: LibraryTarget {
        switch self {
        case .macFeature:
            LibraryTarget(
                name: rawValue,
                resources: [],
                dependencies: [
                    .composableArchitecture,
                ],
                hasTests: false
            )
        }
    }
}

extension TargetDependency {
    fileprivate static func macLocal(_ target: MacLibraryTarget) -> Self {
        .target(name: target.rawValue)
    }
}

extension Project {
    /// Referenced in Mac/Project
    public static let mac = Project(
        name: "Mac",
        organizationName: .organizationName,
        options: library,
        settings: .project(
            base: .keyed([
                .codeSignIdentity: "-",
            ]),
            configurations: Configuration.library()
        ),
        targets: MacLibraryTarget.allCases.flatMap(Target.macWithTests(_:)),
        schemes: MacLibraryTarget.allCases.map(Scheme.mac(_:))
    )
}

extension Target {

    fileprivate static func macWithTests(_ target: MacLibraryTarget) -> [Self] {
        let _target = target.libraryTarget
        if let _testTarget = _target.unitTestTarget {
            return [
                mac(_target),
                macTest(_testTarget),
            ]
        } else {
            return [mac(_target)]
        }
    }

    fileprivate static func mac(_ target: LibraryTarget) -> Self {
        Target.target(
            name: target.name,
            destinations: [.mac],
            product: .staticFramework,
            bundleId: "com.company.app.mac.\(target.name)",
            deploymentTargets: defaultMacosDeploymentTarget,
            infoPlist: .default,
            sources: [
                .glob(.relativeToManifest("\(target.name)/**/*.swift")),
            ],
            resources: target.resources,
            dependencies: target.dependencies,
            settings: .makeFrameworkSettings(
                configurations: Configuration.library()
            ),
            additionalFiles: target.additionalFiles ?? []
        )
    }

    fileprivate static func macTest(_ target: LibraryUnitTestTarget) -> Self {
        Target.target(
            name: target.name,
            destinations: [.mac],
            product: .unitTests,
            bundleId: "com.company.app.mac.\(target.name)",
            deploymentTargets: defaultMacosDeploymentTarget,
            infoPlist: .default,
            sources: [
                .glob(.relativeToManifest("\(target.name)/**/*.swift")),
            ],
            resources: target.resources,
            dependencies: target.dependencies,
            settings: .makeFrameworkSettings(
                configurations: Configuration.library()
            )
        )
    }
}

extension Scheme {
    fileprivate static func mac(_ target: MacLibraryTarget) -> Scheme {
        let _target = target.libraryTarget
        let buildAction = BuildAction.buildAction(targets: [TargetReference(stringLiteral: target.rawValue)])
        var testAction: TestAction?

        if let _testTarget = _target.unitTestTarget {
            testAction = TestAction.targets(
                [TestableTarget(stringLiteral: _testTarget.name)],
                arguments: nil,
                configuration: .debug,
                attachDebugger: true,
                expandVariableFromTarget: nil,
                options: .options(
                    coverage: true,
                    codeCoverageTargets: [TargetReference(stringLiteral: target.rawValue)]
                )
            )
        }
        return .scheme(
            name: target.rawValue,
            shared: true,
            hidden: false,
            buildAction: buildAction,
            testAction: testAction,
            runAction: nil,
            archiveAction: nil,
            profileAction: nil,
            analyzeAction: nil
        )
    }
}
