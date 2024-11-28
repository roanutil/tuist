// Environment+Helpers.swift
// App

import Foundation
import ProjectDescription

extension Environment {
    static let releaseBuildEnabled: Bool = {
        guard let stringValue = ProcessInfo.processInfo.environment["TUIST_RELEASE_BUILD_ENABLED"] else {
            return false
        }
        if ["1", "true", "TRUE", "yes", "YES"].contains(stringValue) {
            return true
        } else if ["0", "false", "FALSE", "no", "NO"].contains(stringValue) {
            return false
        } else {
            fatalError("TUIST_RELEASE_BUILD_ENABLED set with invalid value: \(stringValue)")
        }
    }()
}
