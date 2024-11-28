// Workspace.swift
// App

import ProjectDescription
import ProjectDescriptionHelpers

let workspace = Workspace(
    name: "repro-build-setting-per-sdk",
    projects: [
        ProjectDescription.Path.relativeToRoot("iOS"),
        ProjectDescription.Path.relativeToRoot("iOSAndMac"),
        ProjectDescription.Path.relativeToRoot("Mac"),
    ]
)
