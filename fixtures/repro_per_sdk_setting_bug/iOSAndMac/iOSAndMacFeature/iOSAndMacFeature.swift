// AlertState+ApiError.swift
// Align
//
// Copyright © 2024 MFB Technologies, Inc. All rights reserved.

import ComposableArchitecture

@Reducer
public struct iOSAndMacFeature: Sendable {
    public struct State: Equatable, Sendable {
        public var message = "Hello World! -- iOS and macOS"
    }

    public enum Action: Equatable, Sendable {
        case noop
    }

    public var body: some ReducerOf<Self> {
        EmptyReducer()
    }

    public init() {
        // empty
    }
}
