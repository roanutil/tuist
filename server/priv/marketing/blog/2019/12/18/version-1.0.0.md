---
title: Tuist turns 1.0
category: "product"
tags: [tuist, release, swift, 1.0.0]
excerpt: Today we are pleased the first major release of Tuist, 1.0. We have achieved an important milestone in helping teams scale up their projects, making defining projects easy, and for that reason we are releasing this one as major. This blog post describes what that has been for the project, and what are our ambitions for Tuist 2.0.
author: pepicrft
type: release
---

Today is an essential day in the history of Tuist; we just cut the first major release of the project, 1.0.0.
I started it with the motivation of **making defining Xcode projects an easy task** regardless of their size,
so easy that anyone in the team could participate in scaling up projects.
I was a bit irritated by having to translate dependencies into build settings and build phases with the risk of breaking things if I did something wrong. Not to talk about the number of **git conflicts** that we often saw in developers’ PRs.
That had a significant impact on developers' productivity because PRs took longer to merge.

I remember talking in conferences about a frameworks' architecture that we came up with at [SoundCloud](https://soundcloud.com) and that I ended up calling **uFeatures**.
In hindsight,
it was a great idea but were starting to suffer from the maintenance burden.
None of the tools out there allowed me to define my projects easily,
in plain language,
and with the option to describe the structure in such a way that is reusable.
[CocoaPods](https://cocoapods.org) was the closest option but is opinionated about the structure of the Pods and how they integrate into the projects.
_Why not building something to solve this problem that I have?_ I wanted to write it in Swift,
but unlike in Ruby,
there was no [XcodeProj](https://github.com/cocoapods/xcodeproj) library to generate Xcode projects following Xcode’s convention.
For that reason, I had to spend some time developing XcodeProj,
a library to read,
update,
and write Xcode projects.
Nowadays, it’s being used by many projects, and we keep updating it to support features introduces by new Xcode versions.

**Tuist has matured a lot** since I coded the first line right after finishing with XcodeProj. Conversely to what many people think,
Tuist **is more than just a project generation tool**;
it's a tool that enables teams to scale up their projects,
To do so,
We designed it based upon a simple,
yet powerful idea: _keep it simple_.
We conceptually compressed ideas from Xcode to make the projects easier to reason about. We default to conventions yet allow developers to define theirs. Furthermore, we understand that one of the maintenance difficulties comes from barely being able to reuse bits across projects, so we made it super easy.

We have achieved the first milestone for the project,
**simplifying the definition of projects of any size**,
and for that reason we decided to cut this as a major release.
In this blog post,
I’d like to dive into some important features that we bundled in this release,
and I’ll spoil what will be our focus for version 2.0.

> If you already have Tuist installed, run `tuist update` to get the latest version. Otherwise you can execute `bash <(curl -Ls https://install.tuist.io)` to install it.

## What’s new in 1.0.0

### Project description helpers

While Tuist supported defining workspaces that are,
in essence,
projects organized in multiple Xcode projects,
it was not possible to extract content from the manifest files _(e.g Project.swift)_ to be reused by other files.
In **modular projects**, this becomes very handy because most of the projects follow a similar structure with minor differences.
Unfortunately, neither Xcode nor existing Swift tooling allows that.

Let me tell you that Tuist 1.0.0 makes that super easy using **project description helpers**.
They are a group of Swift files that get compiled under a `ProjectDescriptionHelpers` module that can be imported by your manifest files.
Tuist is not opinionated about the content and the structure of those files,
so it’s really up to you to define how you want to use them.

Helpers are a powerful tool to **codify conventions.**
You can define a function that acts as a factory of projects;
it can take the name a list of dependencies and returns a project.
They are also handy to **simplify the definition of projects**.
You can take the definition of projects down to a line of code.
_Can you imagine the number of git conflicts that you are cutting?_

> Change it in one place, get it everywhere.

The example below shows how we can use helpers to define the structure of a feature framework project:

```swift
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.featureFramework(
  name: "Home",
  dependencies: [
    .project(target: "Features", path: "../Features"),
    .framework(path: "Carthage/Build/iOS/SnapKit.framework")
    .package(product: "KeychainSwift")
  ]
)
```

### Editing manifests

As you might know, in Tuist, **manifests are defined in Swift.**
Using Swift has proven to be a great idea because it allows editing the file in Xcode and leveraging features such as **code autocompletion and inline documentation.**
_Handy, isn’t it?_
Before this version,
we generated targets to edit the manifest files as part of the generated projects.
While that worked,
we believe it's not the right approach because the generated projects would have a dependency on Tuist.
That’s something we'd like to avoid,
and for that reason,
we introduced a new command: `tuist edit`.

Tuist edit creates a temporary Xcode project to edit the manifests in the current directory and its dependencies _(e.g Project description helpers)_.
Once users are done with editing, the project is destroyed automatically.
The generated project supports the project description helpers mentioned above.
Those are placed in another target that can be imported from the manifest files.

### New website

_Did you notice the fresh design we shipped with this major version?_
Our previous design did not accurately **convey the values of Tuist**,
and did an abysmal job at explaining developers why a tool like Tuist is crucial for a sustainable scale of projects.
Moreover,
the documentation was generated using a different tool and with a different design that made it feel detached and inconsistent with the website.
Now documentation is generated as part of the website and follows the same style guidelines.

We have made sure that all pages contain semantically-correct HTML, and structured data and meta elements to help search engines like Google index the content and make it easily browsable.

For those of you interested in knowing how we made it happen, we got a lot of inspiration from [Dribbble](https://dribbble.com/), and did the whole design using [Figma](https://dribbble.com/). The website is part of the Tuist’s monorepo under `/website` and statically generated using Gatsby in combination with powerful libraries like Gatsby.

We believe that poor user experiences diminish the value of the software,
and for that reason,
**we pay attention to every detail of crafting Tuist**.

## The journey towards 2.0

So having achieved this important milestone, one might wonder **what’s next?**

Project generation is not done yet. We don’t fully support all types of products, so we’d like to add support for some of them _(e.g intent extensions)_. We could map Xcode concepts 1-to-1 and have support very quickly,
but we follow a different approach.
We thoroughly study Xcode concepts with the aim of finding simplification opportunities.
We believe the key to scale is simpler concepts, not concepts in other languages.

The project has a substantial and well-architected foundation with an easy-to-extend generation logic.
We’ll continue iterating on it because we believe it can pave the way for other tools to come up with **new workflows for developers**.
Like we did with [XcodeProj](https://github.com/tuist/xcodeproj),
we are not only giving tools to the community but libraries that they can reuse as they wish.

The focus for Tuist 2.0 we’ll be placed in two areas: **automation and productivity.**

### Productivity

The most significant challenge companies face when scaling up projects is **build times.**
Incremental builds are not enough,
and Apple is not doing things better but worse with every Xcode & macOS update.
Only large companies like [Pinterest](https://pinterest.com),
[Lyft](https://lyft.com),
[Uber](https://uber.com),
or [Airbnb](https://airbnb.com) can invest in replacing Xcode’s build system with alternatives like [Buck](https://buck.build/) or [Bazel](https://bazel.build/).
Even with that,
they have to reverse-engineer Xcode’s functionality,
and put a lot of effort into making builds fast without taking developers away from Xcode.

Not everyone is a large company, so I’d like **Tuist to be the tool that speeds up the builds for the rest of us.**
I might be going down a rabbit hole,
but based on some tests I’ve done,
I think it’s feasible.
The idea is leveraging the generation logic to replace dependencies with their precompiled version that is pulled from a remote cache.
Tuist has already all the elements in place to make this possible,
so we just need to implement it,
and make sure it’s incredibly efficient.

Speaking about **efficiency**,
we’ll revisit the generation of projects to make sure it works as fast as possible.

### Automation

When we talk about automation in mobile,
the first thing that pops up in developer minds is [Fastlane](https://fastlane.tools/).
These days,
defining a CLI for your mobile projects without Fastlane is inconceivable.

Fastlane is great;
it saved a lot of time to companies and gave a lot of useful libraries to the community.
However, when used at scale,
it often results in complex and unmaintainable `Fastfiles`.
It’s not Fastlane’s fault.
It just happens,
and it’s hard to prevent unless you are more opinionated and provide simple conventions that developers stick to.

I still remember when I landed on a project, and I had to spend some time figuring out the name of the task that I wanted to execute.
Is it `build_app_debug`? `debug_app_build`? Or perhaps `app_debug_build`?

Imagine you didn’t have to add a `Fastfile`.
Imagine you had a simple CLI that you could memorize and use in any directory with a `Project.swift` file.
That’s what the [Swift Package manager](https://swift.org/package-manager/) and [Cargo](https://crates.io/),
Rust’s dependency manager, do.
Do you want to build the app,
just pass the `build` argument.
_What if you want to test it?_
In that case,
you need to pass the `test` argument.

Having a **conventional** interface in the CLI removes an unnecessary point of friction when developers interact with the projects.
They don’t have to remember all possible combination of arguments that need to be passed to compile an app.
If you take iOS,
for instance,
you probably know that getting `xcodebuild build` to succeed is a hard task because you have to remember all the arguments that are required, like the `destination`, or the right build settings to disable the signing.

I want Tuist to port the Swift Package Manager and Cargo’s approach to any Xcode project defined with Tuist.
The commands should work **without any extra arguments** but have the option to pass those when necessary.

We’ll start with the most common ones, build and test,
and then move to some not-so-common yet useful for developers,
`run`,
and `docs`.
The latter would generate and open in the browser documentation for the project in the current directory.

## One more thing

Automation and productivity will be our focus,
but there are some other ideas in the **backlog** that might end up landing on Tuist 2.0 too:
management of certificates and provisioning profiles, support for static libraries with resources, selective builds based on the file changes, publishing of apps, linting of code.
It's been years of weakly integrated tooling that is turning brittle as projects get more complicated.
Therefore,
we'd like Tuist to be a **platform** to streamline the processes for building, testing, and releasing Xcode apps into a simple, conventional, and unified solution.

## Some final words

Tuist is **the most exciting project I’ve worked on in the open**.
We explore ways of scaling Xcode projects without constraining our ideas and solutions to what the developers are used to or have seen in other tools. We craft what we believe brings joy to working with Xcode.
I know this sounds very Marie Kondo,
but programming should not be complex,
and that's where we are seeing Xcode going towards.

I'd like to take the opportunity to thank **maintainers and contributors** that trust the project,
and without whom,
Tuist would not have been possible.
Thanks,
[Kas](https://github.com/kwridan), [Marcin](https://github.com/marciniwanicki), [Ollie](https://github.com/ollieatkinson), [Marek](https://github.com/fortmarek), [Adam](https://github.com/adamkhazi), [Lakpa](https://github.com/lakpa),
and the [large list of contributors](https://github.com/orgs/tuist/people) of the organization.
We should not disregard that Tuist's is the result of a shared effort of very talented people like them that devote part of their time to help others.

I hope you have a wonderful Christmas with the family and friends ❄️.
Remember that Christmas is time for disconnecting,
put our laptops aside,
and recharging our batteries that have gone through an intense ride this year.
