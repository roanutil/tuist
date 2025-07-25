---
title: Dynamically generating Xcode projects
category: "learn"
tags: [tuist, xcode projects, dynamism, xcode, apple]
excerpt: In this blog post I talk about how Xcode's determinism and speed relates to the static nature of Xcode projects, and how Tuist leverages dynamism to help teams overcome the challenges of scaling up projects.
author: pepicrft
---

I’ve been thinking a lot lately about the static nature of Xcode projects.
I think it’s a design decision that makes Xcode behave **fast and deterministically**,
at least if the project is reasonably small.
In Android land,
things are dynamic.
[Gradle](https://gradle.org/) has a loading phase where all the tasks are evaluated, and only then can you build and run your apps.

Personally, **I think the dynamic approach at scale is terrible**. If the project is considerably large, it might take long and a lot of CPU power for Gradle to become responsive. The matter gets worse if we use tasks with side effects that might cause Gradle to yield different results in different environments.

For that reason,
if I were Apple, I would keep Xcode projects as static as possible. With Xcode 11,
they [added support](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app) for the Swift Package Manager,
which,
as you might have noticed,
added a bit of dynamism to resolve the packages at launch time.

Apple could introduce more subtle touches of dynamism to ease the maintenance of projects and minimize the likelihood of getting Git conflicts.
For example, the files that are part of a project could be defined using glob patterns like `Sources/**.swift`,
or even better,
following a convention for the directory structure like Android does.
They could be resolved at launch time like they are currently doing with Swift packages.

At this point, you may wonder how Tuist relates to this dynamism I'm talking about:
**Tuist brings dynamism through project generation to help teams overcome the challenges of scaling up projects.**

Here are some examples of things that we were able to provide by leveraging the dynamism of project generation:

- Having consistency across projects and targets by leveraging [project description helpers](https://docs.old.tuist.io/guides/helpers/).
- [Defining dependencies](https://docs.old.tuist.io/guides/dependencies) explicitly with a simple and unified DSL.
- [Setting up](https://docs.old.tuist.io/commands/up/) the environment deterministically to ensure Xcode behaviors and builds are reproducible.
- Throw errors early when projects have invalid configurations.
- Generating a [visual dependency tree](https:://docs.old.tuist.io/commands/graph/) to have an overview of the project.

And we are not done yet. We are streamlining more workflows like configuring the environment and the projects for signing and providing a standard CLI without having to mess around with script files or configure a Ruby environment properly.

Like [Rails](https://rubyonrails.org/) does in the Ruby community,
we are designing Tuist to spark joy when interacting with Xcode projects.
Over the past years,
we have seen a good amount of tools to help teams with all the different challenges that they face.
That's awesome,
but when combined together around Xcode projects,
teams end up with workflows that don't play well with each other and layers of indirection that add complexity and make the projects hard to reason about.

Here are some concrete examples to illustrate the above:

- Inconsistent [Swiftlint](https://github.com/realm/SwiftLint) errors because [Homebrew](https://brew.sh) installed different versions of Swiftlint.
- Fastlane lanes printing errors but exiting with a exit status 0.
- Xcode failing to sign the app because a developer changed one of the signing build settings by mistake and no one spot it in a large `project.pbxproj` diff.
- Invalid dependencies configuration that results in some artifacts being copied into the final product and then causing release validations to fail.
- Developers getting different results when running Fastlane because they are not familiar with setting up Ruby environments and end up running the global Fastlane instead of the one pinned by [Bundler](https://bundler.io/).
- Adding a new framework to the dependency tree causes compilation issues on CI.

Some teams might want to work in such a frustration-prone and complex environment.
It gives teams the freedom to customize every single bit of the way they work.
Still, it also leads them to waste time that they could otherwise spend building product features.
**Tuist takes care of those things, ensuring that we provide a consistent and easy experience that sparks joy.**

If you have been there and think it’s time to clean things up and make working with your project as enjoyable as it used to be when you first created the project with Xcode,
you can check out our [Get Started](https://docs.old.tuist.io/tutorial/get-started/) documentation.
