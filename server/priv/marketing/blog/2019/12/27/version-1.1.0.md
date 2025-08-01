---
title: API for excluding files with Tuist 1.1.0
category: "product"
tags: [tuist, release, swift, 1.1.0, project generation, xcode, swift]
excerpt: The new version of Tuist ships with improvements in the API for defining files so that users can exclude files using glob patterns. Moreover, we made some changes in the architecture of the project and introduced two new targets to the family, TuistGalaxy and TuistAutomation.
author: pepicrft
---

Tuist 1.1.0 has been released and is shorter than usual because we have committed to a fixed biweekly.
In the past,
users were in situations where their projects were pointing to commits in main.
Although that's possible thanks to [Tuist's version management](https://docs.old.tuist.io/guides/version-management/), that's an undesirable state to be in.
We chose two weeks as the cadence because a week is to short as to be able to ship noticeable changes,
and more than two weeks likely leaves users waiting for improvements and bug fixes coming along with new versions.

Besides committing to a fixed release schedule,
this version also ships with support for [**excluding files**](https://github.com/tuist/tuist/pull/811) thanks to [Vytis's](https://github.com/vytis) first code-contribution to the project.
Some users reported that the current API was a bit limiting and that they could not express their project files _concisely_.
Although we firmly believe that we should aim to keep the files structure simple,
we also understand that users might come from complex setups that they might want to express in their manifests.

You can adopt the new API easily. In those places where you define glob patterns to match files,
you can use the constructor of the underlying type and pass the `excluding` argument:

```swift
let target = Target(sources: [.init("Sources/**/*.swift", excluding: "**/Excluded.swift")])
```

In case one was not enough,
Vytis made another great contribution to the project.
He improved the [generation of schemes](https://github.com/tuist/tuist/pull/811) so that the autogenerated schemes from targets that have dependant testables, have test actions too.
In other words, the scheme `MyFramework` that is generated for the framework `MyFramework`,
which has an associated `MyFrameworkTests`,
has a test action defined to run tests.

### Internal improvements

To ensure a healthy and sustainable growth of the project,
in this version,
we are also shipping some internal improvements.
We created [two new frameworks](https://github.com/tuist/tuist/pull/817).
The first one will contain all the logic for caching output artifacts to speed up builds, something that we have already started working on.
The latter will contain the logic for commands such as `tuist build`, or `tuist test` that will define an standard CLI to interact with the projects.

### How to update

As always, updating Tuist is as simple as running the following command:

```bash
tuist update
```

### Happy holidays

We hope you are having a wonderful time with family and friends and using this time to recharge the batteries and plan 2020.
