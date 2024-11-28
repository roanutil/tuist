// Project+Templates.swift
// App

import ProjectDescription

extension Project {
    static let library: Options = .options(
        automaticSchemesOptions: .disabled,
        developmentRegion: nil,
        disableBundleAccessors: false,
        disableShowEnvironmentVarsInScriptPhases: false,
        disableSynthesizedResourceAccessors: true,
        textSettings: .textSettings(usesTabs: false, indentWidth: 4, tabWidth: 4, wrapsLines: nil),
        xcodeProjectName: nil
    )
}
