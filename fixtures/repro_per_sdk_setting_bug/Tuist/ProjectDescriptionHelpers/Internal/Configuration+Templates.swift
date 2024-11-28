// Configuration+Templates.swift
// App

import ProjectDescription

extension Configuration {
    static func library(
        overriding: SettingsDictionary = [:],
        forceRelease: Bool = false
    ) -> [Self] {
        if Environment.releaseBuildEnabled || forceRelease {
            [
                .debug(
                    name: .debug,
                    settings: .library(overriding: overriding)
                ),
                .release(
                    name: .release,
                    settings: .library(overriding: overriding)
                ),
            ]
        } else {
            [
                .debug(
                    name: .debug,
                    settings: .library(overriding: overriding)
                ),
            ]
        }
    }
}
