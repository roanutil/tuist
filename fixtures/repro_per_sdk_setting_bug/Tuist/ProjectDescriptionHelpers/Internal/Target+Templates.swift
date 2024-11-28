// Target+Templates.swift
// App

import ProjectDescription

extension Target {
    static let defaultIosDeploymentTarget = DeploymentTargets.multiplatform(iOS: .iosDeploymentTarget)

    static let defaultMacosDeploymentTarget = DeploymentTargets.multiplatform(macOS: .macosDeploymentTarget)

    static let defaultIosAndMacosDeploymentTarget = DeploymentTargets.multiplatform(
        iOS: .iosDeploymentTarget,
        macOS: .macosDeploymentTarget
    )
}
