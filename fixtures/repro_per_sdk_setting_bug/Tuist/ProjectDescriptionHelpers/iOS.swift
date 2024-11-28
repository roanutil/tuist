// iOS.swift
// App

import ProjectDescription

/// Referenced in `public` declarations
public enum iOSTarget: String, CaseIterable {
    case iOSFeature = "iOSFeature"
}

extension iOSTarget {
    /// Referenced in Workspace
    public var libraryTarget: LibraryTarget {
        switch self {
        case .iOSFeature:
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
    fileprivate static func iosLocal(_ target: iOSTarget) -> Self {
        Self.target(name: target.rawValue)
    }

    static func ios(_ target: iOSTarget) -> Self {
        project(target: target.rawValue, path: Path.relativeToRoot("iOS"))
    }
}

extension Project {
    /// Referenced in iOS/Project
    public static let ios = Project(
        name: "iOS",
        organizationName: .organizationName,
        options: library,
        settings: .project(
            configurations: Configuration.library()
        ),
        targets: iOSTarget.allCases.flatMap(Target.iosWithTests(_:)),
        schemes: iOSTarget.allCases.map(Scheme.ios(_:))
    )
}

extension Target {
    fileprivate static func iosWithTests(_ target: iOSTarget) -> [Self] {
        let _target = target.libraryTarget
        if let _testTarget = _target.unitTestTarget {
            return [
                ios(_target),
                iosTest(_testTarget),
            ]
        } else {
            return [ios(_target)]
        }
    }

    fileprivate static func ios(_ target: LibraryTarget) -> Self {
        Target.target(
            name: target.name,
            destinations: [.iPad],
            product: .staticFramework,
            bundleId: "com.company.app.ios.\(target.name)",
            deploymentTargets: defaultIosDeploymentTarget,
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

    fileprivate static func iosTest(_ target: LibraryUnitTestTarget) -> Self {
        Target.target(
            name: target.name,
            destinations: [.iPad],
            product: .unitTests,
            bundleId: "com.company.app.ios.\(target.name)",
            deploymentTargets: defaultIosDeploymentTarget,
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
    fileprivate static func ios(_ target: iOSTarget) -> Scheme {
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
