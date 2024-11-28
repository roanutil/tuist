// Settings+Templates.swift
// App

import ProjectDescription

extension Settings {
    static func makeFrameworkSettings(configurations: [Configuration]) -> Self {
        Settings.settings(
            base: SettingsDictionary.library(),
            configurations: configurations
        )
    }

    static func project(base: SettingsDictionary = [:], configurations: [Configuration]) -> Settings {
        .settings(
            base: base.project(),
            configurations: configurations,
            defaultSettings: .recommended(excluding: [.productBundleIdentifier, .productName])
        )
    }
}
