// SettingsDictionary+Templates.swift
// App

import ProjectDescription

extension SettingsDictionary {
    static func library(overriding: Self = Self()) -> Self {
        let dict: Self = .keyed([
            .assetCatalogCompilerGenerateSwiftAssetSymbolExtensions: "NO",
            .assetCatalogCompilerGenerateAssetSymbolFrameworks: .array([]),
            .enableUserScriptSandboxing: "YES",
            .enableModuleVerifier: true,
            .moduleVerifierSupportedLanguage: ["objective-c", "objective-c++"],
            .moduleVerifierSupportedLanguageStandards: ["gnu11", "gnu++20"],
            .swiftVersion: "6",
            .swiftUpcomingFeatureConciseMagicFile: true,
            .swiftUpcomingFeatureDeprecateApplicationMain: true,
            .swiftUpcomingFeatureDisableOutwardActorIsolation: true,
            .swiftUpcomingFeatureForwardTrailingClosures: true,
            .swiftUpcomingFeatureImplicitOpenExistentials: true,
            .swiftUpcomingFeatureImportObjecForwardDecls: true,
            .swiftUpcomingFeatureInferSendableFromCaptures: true,
            .swiftUpcomingFeatureIsolatedDefaultValues: true,
            .swiftUpcomingFeatureGlobalConcurrency: true,
            .swiftUpcomingFeatureRegionBasedIsolation: true,
            .swiftStrictConcurrency: "complete",
        ])
        return dict.merging(overriding, uniquingKeysWith: mergeClosure)
    }

    static func merge(base: Self, overriding: Self) -> Self {
        base.merging(overriding, uniquingKeysWith: mergeClosure)
    }

    // Merge an array of `SettingsDictionary` ordered by priority. First in the array overrides all others. Last in the
    // array
    // is overridden by all.
    static func merge(_ settings: [Self]) -> Self {
        settings.reduce(SettingsDictionary()) { result, nextToMerge -> SettingsDictionary in
            nextToMerge.merging(result, uniquingKeysWith: mergeClosure)
        }
    }

    // Merge closure that uses the 'new' value for any duplicated keys
    static func mergeClosure<T>(_: T, _ new: T) -> T {
        new
    }

    func project() -> Self {
        otherSwiftFlags([
            "-cross-module-optimization",
            "-Xfrontend -warn-long-expression-type-checking=100",
            "-Xfrontend -warn-long-function-bodies=100",
        ])
    }
}
