// SettingsDictionary+SettingKey.swift
// App

import ProjectDescription

extension SettingsDictionary {
    struct SettingKey: RawRepresentable, Hashable, Sendable {
        let rawValue: String

        init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
}

extension SettingsDictionary.SettingKey: ExpressibleByStringLiteral {
    init(stringLiteral value: String) {
        self.init(rawValue: value)
    }
}

extension SettingsDictionary.SettingKey: ExpressibleByStringInterpolation {
    init(stringInterpolation: DefaultStringInterpolation) {
        self.init(stringLiteral: stringInterpolation.description)
    }
}

extension SettingsDictionary {
    static func keyed(_ dictionary: [SettingKey: SettingValue]) -> Self {
        dictionary.mapKeys(transform: \SettingKey.rawValue)
    }
}

extension DefaultSettings {
    static func essential(excluding: Set<SettingsDictionary.SettingKey>) -> Self {
        .essential(excluding: Set(excluding.map(\.rawValue)))
    }

    static func recommended(excluding: Set<SettingsDictionary.SettingKey>) -> Self {
        .recommended(excluding: Set(excluding.map(\.rawValue)))
    }
}

extension SettingsDictionary.SettingKey {
    // MARK: Existing

    static let assetCatalogCompilerAppIconName: Self = "ASSETCATALOG_COMPILER_APPICON_NAME"
    static let productName: Self = "PRODUCT_NAME"
    static let productBundleIdentifier: Self = "PRODUCT_BUNDLE_IDENTIFIER"
    static let embeddedContentContainsSwift: Self =
        "EMBEDDED_CONTENT_CONTAINS_SWIFT" // Old, replaced by `alwaysEmbedSwiftStandardLibraries
    static let frameworkSearchPaths: Self = "FRAMEWORK_SEARCH_PATHS"
    static let infoPlistKeyUiLaunchScreenGeneration: Self = "INFOPLIST_KEY_UILaunchScreen_Generation"
    static let infoPlistKeyUiLaunchStoryboardName: Self = "INFOPLIST_KEY_UILaunchStoryboardName"
    static let enablePreviews: Self = "ENABLE_PREVIEWS"
    static let currentProjectVersion: Self = "CURRENT_PROJECT_VERSION"
    static let marketingVersion: Self = "MARKETING_VERSION"
    static let targetedDeviceFamily: Self = "TARGETED_DEVICE_FAMILY"
    static let sdkRoot: Self = "SDKROOT"
    static let supportedPlatforms: Self = "SUPPORTED_PLATFORMS"
    static let supportsMacCatalyst: Self = "SUPPORTS_MACCATALYST"
    static let generateInfoPlistFile: Self = "GENERATE_INFOPLIST_FILE"
    static let supportsMacDesignedForIphoneIpad: Self = "SUPPORTS_MAC_DESIGNED_FOR_IPHONE_IPAD"
    static let developmentAssetPaths: Self = "DEVELOPMENT_ASSET_PATHS"
    static let enableBitcode: Self = "ENABLE_BITCODE"
    static let entitlementsRequired: Self = "ENTITLEMENTS_REQUIRED"
    static let bundleVersion: Self = "BUNDLE_VERSION"
    static let codeSignEntitlements: Self = "CODE_SIGN_ENTITLEMENTS"
    static let headerSearchPaths: Self = "HEADER_SEARCH_PATHS"
    static let developmentTeam: Self = "DEVELOPMENT_TEAM"
    static let provisioningProfileSpecifier: Self = "PROVISIONING_PROFILE_SPECIFIER"
    static let currentArch: Self = "CURRENT_ARCH"
    static let projectDir: Self = "PROJECT_DIR"
    static let symRoot: Self = "SYMROOT"
    static let effectivePlatformName: Self = "EFFECTIVE_PLATFORM_NAME"
    static let alwaysEmbedSwiftStandardLibraries: Self = "ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES"
    static let codeSignStyle: Self = "CODE_SIGN_STYLE"
    static let clangAllowNonModularIncludesInFrameworkModules: Self =
        "CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES"
    static let validateWorkspace: Self = "VALIDATE_WORKSPACE"
    static let swiftStrictConcurrency: Self = "SWIFT_STRICT_CONCURRENCY"
    static let developmentLanguage: Self = "DEVELOPMENT_LANGUAGE"
    static let executableName: Self = "EXECUTABLE_NAME"
    static let productBundlePackageType: Self = "PRODUCT_BUNDLE_PACKAGE_TYPE"
    static let stripSwiftSymbols: Self = "STRIP_SWIFT_SYMBOLS"
    static let debugInformationFormat: Self = "DEBUG_INFORMATION_FORMAT"
    static let swiftActiveCompilationConditions: Self = "SWIFT_ACTIVE_COMPILATION_CONDITIONS"
    static let codeSignIdentity: Self = "CODE_SIGN_IDENTITY"
    static let codeSigningRequired: Self = "CODE_SIGNING_REQUIRED"
    static let codeSigningAllowed: Self = "CODE_SIGNING_ALLOWED"
    static let srcRoot: Self = "SRCROOT"
    static let enableUserScriptSandboxing: Self = "ENABLE_USER_SCRIPT_SANDBOXING"
    static let assetCatalogCompilerGenerateSwiftAssetSymbolExtensions: Self =
        "ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS"
    static let assetCatalogCompilerGenerateAssetSymbolFrameworks: Self =
        "ASSETCATALOG_COMPILER_GENERATE_ASSET_SYMBOL_FRAMEWORKS"
    static let deadCodeStripping: Self = "DEAD_CODE_STRIPPING"
    static let definesModule: Self = "DEFINES_MODULE"
    static let gccDynamicNoPic: Self = "GCC_DYNAMIC_NO_PIC"
    static let installPath: Self = "INSTALL_PATH"
    static let ldDylibInstallName: Self = "LD_DYLIB_INSTALL_NAME"
    static let skipInstall: Self = "SKIP_INSTALL"
    static let ldRunpathSearchPaths: Self = "LD_RUNPATH_SEARCH_PATHS"
    static let iphoneosDeploymentTarget: Self = "IPHONEOS_DEPLOYMENT_TARGET"
    static let macosxDeploymentTarget: Self = "MACOSX_DEPLOYMENT_TARGET"
    static let enableModuleVerifier: Self = "ENABLE_MODULE_VERIFIER"
    static let moduleVerifierSupportedLanguage: Self = "MODULE_VERIFIER_SUPPORTED_LANGUAGE"
    static let moduleVerifierSupportedLanguageStandards: Self = "MODULE_VERIFIER_SUPPORTED_LANGUAGE_STANDARDS"
    /// Typically `s` for release builds and `none` for debug builds
    static let gccOptimizationLevel: Self = "GCC_OPTIMIZATION_LEVEL"
    /// Typically `-O` for release builds and `none` for debug builds
    static let swiftOptimizationLevel: Self = "SWIFT_OPTIMIZATION_LEVEL"
    /// Typically `wholemodule` for release builds and `incremental` for debug builds
    static let swiftCompilationMode: Self = "SWIFT_COMPILATION_MODE"
    static let swiftVersion: Self = "SWIFT_VERSION"
    static let swiftEnableBareSlashRegex: Self = "SWIFT_ENABLE_BARE_SLASH_REGEX"
    static let swiftUpcomingFeatureConciseMagicFile: Self = "SWIFT_UPCOMING_FEATURE_CONCISE_MAGIC_FILE"
    static let swiftUpcomingFeatureInternalImportsByDefault: Self =
        "SWIFT_UPCOMING_FEATURE_INTERNAL_IMPORTS_BY_DEFAULT"
    static let swiftUpcomingFeatureDeprecateApplicationMain: Self =
        "SWIFT_UPCOMING_FEATURE_DEPRECATE_APPLICATION_MAIN"
    static let swiftUpcomingFeatureDisableOutwardActorIsolation: Self =
        "SWIFT_UPCOMING_FEATURE_DISABLE_OUTWARD_ACTOR_ISOLATION"
    static let swiftUpcomingFeatureForwardTrailingClosures: Self =
        "SWIFT_UPCOMING_FEATURE_FORWARD_TRAILING_CLOSURES"
    static let swiftUpcomingFeatureImplicitOpenExistentials: Self =
        "SWIFT_UPCOMING_FEATURE_IMPLICIT_OPEN_EXISTENTIALS"
    static let swiftUpcomingFeatureImportObjecForwardDecls: Self =
        "SWIFT_UPCOMING_FEATURE_IMPORT_OBJC_FORWARD_DECLS"
    static let swiftUpcomingFeatureInferSendableFromCaptures: Self =
        "SWIFT_UPCOMING_FEATURE_INFER_SENDABLE_FROM_CAPTURES"
    static let swiftUpcomingFeatureIsolatedDefaultValues: Self = "SWIFT_UPCOMING_FEATURE_ISOLATED_DEFAULT_VALUES"
    static let swiftUpcomingFeatureGlobalConcurrency: Self = "SWIFT_UPCOMING_FEATURE_GLOBAL_CONCURRENCY"
    static let swiftUpcomingFeatureRegionBasedIsolation: Self = "SWIFT_UPCOMING_FEATURE_REGION_BASED_ISOLATION"
    static let swiftUpcomingFeatureExistentialAny: Self = "SWIFT_UPCOMING_FEATURE_EXISTENTIAL_ANY"
}
