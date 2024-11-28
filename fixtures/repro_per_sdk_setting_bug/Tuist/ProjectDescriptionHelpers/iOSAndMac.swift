// iOSAndMac.swift
// App

import ProjectDescription

/// Referenced in `public` declarations
public enum iOSAndMacTarget: String, CaseIterable {
    case iOSAndMacFeature = "iOSAndMacFeature"
}

extension iOSAndMacTarget {
    /// Referenced in Workspace
    public var libraryTarget: LibraryTarget {
        switch self {
        case .iOSAndMacFeature:
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
    fileprivate static func iOSAndMacLocal(_ target: iOSAndMacTarget) -> Self {
        Self.target(name: target.rawValue)
    }

    static func iOSAndMac(_ target: iOSAndMacTarget) -> Self {
        project(target: target.rawValue, path: Path.relativeToRoot("iOSAndMac"))
    }
}

extension Project {
    /// Referenced in iOSAndMac/Project
    public static let iOSAndMac = Project(
        name: "iOSAndMac",
        organizationName: .organizationName,
        options: library,
        settings: .project(
            configurations: Configuration.library()
        ),
        targets: iOSAndMacTarget.allCases.flatMap(Target.iOSAndMacWithTests(_:)),
        schemes: iOSAndMacTarget.allCases.map(Scheme.iOSAndMac(_:))
    )
}

extension Target {
    fileprivate static func iOSAndMacWithTests(_ target: iOSAndMacTarget) -> [Self] {
        let _target = target.libraryTarget
        if let _testTarget = _target.unitTestTarget {
            return [
                iOSAndMac(_target),
                iOSAndMacTest(_testTarget),
            ]
        } else {
            return [iOSAndMac(_target)]
        }
    }

    fileprivate static func iOSAndMac(_ target: LibraryTarget) -> Self {
        Target.target(
            name: target.name,
            destinations: [.iPad, .mac],
            product: .staticFramework,
            bundleId: "com.company.app.iOSAndMac.\(target.name)",
            deploymentTargets: defaultIosAndMacosDeploymentTarget,
            infoPlist: .iOSAndMac(target),
            sources: [
                .glob(.relativeToManifest("\(target.name)/**/*.swift")),
            ],
            resources: target.resources,
            dependencies: target.dependencies,
            settings: .makeFrameworkSettings(
                configurations: Configuration.library()
            ),
            coreDataModels: CoreDataModel.iOSAndMac(target),
            additionalFiles: target.additionalFiles ?? []
        )
    }

    fileprivate static func iOSAndMacTest(_ target: LibraryUnitTestTarget) -> Self {
        Target.target(
            name: target.name,
            destinations: [.iPad, .mac],
            product: .unitTests,
            bundleId: "com.company.app.iOSAndMac.\(target.name)",
            deploymentTargets: defaultIosAndMacosDeploymentTarget,
            infoPlist: .iOSAndMacTest(target),
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

extension CoreDataModel {
    fileprivate static func iOSAndMac(_ target: LibraryTarget) -> [Self] {
        []
    }
}

extension Scheme {
    fileprivate static func iOSAndMac(_ target: iOSAndMacTarget) -> Scheme {
        .scheme(
            name: target.rawValue,
            shared: true,
            hidden: false,
            buildAction: BuildAction.buildAction(targets: [TargetReference(stringLiteral: target.rawValue)]),
            testAction: .iOSAndMac(target: target),
            runAction: nil,
            archiveAction: nil,
            profileAction: nil,
            analyzeAction: nil
        )
    }
}

extension TestAction {
    fileprivate static func iOSAndMac(target: iOSAndMacTarget) -> Self? {
        guard let testTarget = target.libraryTarget.unitTestTarget else {
            return nil
        }
        return TestAction.targets(
            [TestableTarget(stringLiteral: testTarget.name)],
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
}

extension InfoPlist {
    fileprivate static func iOSAndMac(_ target: LibraryTarget) -> Self {
        if let testTarget = target.unitTestTarget {
            // For some reason the Info.plist for the test target isn't successfully
            // customized unless the base target's Info.plist is customized too.
            iOSAndMacTest(testTarget)
        } else {
            InfoPlist.default
        }
    }

    fileprivate static func iOSAndMacTest(_ target: LibraryUnitTestTarget) -> Self {
        InfoPlist.default
    }
}
