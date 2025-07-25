---
title: "Interview with Donal O'Brien - We measure developer build times so that we can measure improvements and regressions"
category: "community"
tags:
  [Tuist, donal, soundcloud, app development at scale, xcodeproj, xcode, swift]
type: interview
excerpt: "In this interview, we talk with Donal O'Brien from the core clients team at SoundCloud. He shares how they leveraged modularization, Tuist, and tools like Sourcery to overcome the challenges they faced while scaling the app. Moreover, he touches on some present challenges like developer awareness and the maintenance of the tools around the project."
interviewee_name: "Donal O'Brien"
interviewee_role: "iOS developer at SoundCloud"
interviewee_avatar: https://media-exp1.licdn.com/dms/image/C5603AQGNh8pYgOuxEg/profile-displayphoto-shrink_400_400/0?e=1597881600&v=beta&t=yqVfJ5mFbSg3Wm0KV9NqBEOrELAA43380hvxvLy6siw
---

This week we are interviewing Donal. He's currently part of the core clients team at [SoundCloud](https://soundcloud.com) where his role is to provide support for their engineers to be productive in their day to day work. The motivation for building Tuist came from the challenges SoundCloud was facing so we are pleased to have Donal sharing more about them in his interview.

## Team structure

### How are teams structured at SoundCloud?

Teams are typically structured in a cross disciplinary fashion with a well defined focus on some particular part of the business, e.g. listeners, creators, ads, growth etc. There are typically a mix of engineers from different disciplines, e.g. there might be two iOS, two Android and two backend on a single team. Of course, most teams also have an engineering manager, product manager and design / UX representative.

### How many engineers work on features and how many take care of the infrastructure of your projects?

There are currently **16 iOS engineers** working on features and two dedicated to infrastructure / tooling, i.e. the Core Clients engineers.

## Project and code architecture

### Could you describe the architecture of your project?

The project was originally a monolith, which was gradually migrated to a modularised setup over a few years. We still have quite a lot of code in the main app but most developers no longer need to touch this part on a frequent basis.

There are currently **27 modules / subprojects**, which are dedicated to some business concerns in particular (e.g. `Ads` or `Discovery`). Most of these modules actually expose more than one framework. Some of these additional frameworks are used for testing, e.g. in order to share mocks with other parts of the codebase and some are used to run “example apps” that enable developers to work on features without the compile times of the main app.

### What code paradigms and architectures do you follow?

Typically new features are developed using clean architecture such as [VIPER](https://www.objc.io/issues/13-architecture/viper/).

### If you have multiple apps, how do you share code between them and how do you use internal tools to automate repetitive processes?

We use some code generation techniques such as [Sourcery](https://github.com/krzysztofzablocki/Sourcery) for mock and test data generation. There’s a central collection of user scripts that we commit to the app’s repo for all sorts of repetitive tasks such as generating feature flag code and running common commands.

### What are the main challenges on your architecture when scaling?

Before Tuist there were some concerns around the length of time it would take to generate a new module. In certain circumstances this could take up to a few days. Also, with developers relying on relatively verbose and sometimes outdated documentation to create the frameworks, inevitable inconsistencies in project structure and settings emerged.

## Dependencies

### How do you manage your third-party dependencies?

Mainly [CocoaPods](https://cocoapods.org) but also some [Carthage](https://github.com/carthage/carthage).

### What’s a third-party dependency your project heavily depends on?

We don’t rely too heavily on any one external dependency but there are a few, which were introduced at the beginning and managed to spread throughout the codebase _(i.e. an early version of [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa) or the [Specta](https://github.com/specta/specta) unit test framework)_. However, it’s highly discouraged to use these frameworks currently for some well documented reasons. In that way we no longer rely on them but it’s hard to get rid of them!

### What’s your take on external dependencies?

Generally I think a thorough cost / benefit analysis should be carried out before committing to any third party dependency that might lead to negative business impact in the future such as the emergence of app instability or lower developer productivity.

## Testing

### What’s your testing strategy?

There’s a strong emphasis on unit testing, with a much lower number of UI tests.

### Do you use third-party frameworks for testing?

Yes, but only for legacy reasons. Developers are now encouraged to use [XCTest](https://developer.apple.com/documentation/xctest) directly, with the addition of some in-house conveniences on top.

### How many tests do you have and how are they split between unit/integration/ui. Which ones give you more confidence?

We currently have over **16,000 unit tests**. These are split roughly half and half between the modules and the main app. We have far fewer UI tests.

## Tooling

### What internal tools did you build that you are proud of?

Some tooling around code and framework generation using Sourcery and Tuist’s scaffold command are some things that come to mind.

### What are your main challenges on tooling when scaling?

- **Developer awareness:** some developers are just unaware of the existence of tooling or correct usage. Documentation goes some way to alleviating this but discoverability / maintenance of this documentation can also be an issue.
- **Maintenance:** sometimes tooling goes flaky due to lack of love or the lack of a dedicated owner whose responsibility it is to maintain them.
- **System inconsistencies:** even though we use tools such as Bundler, sometimes some developers can experience issues that are hard to reproduce for others.

### What are some challenges you are facing scaling up your project?

Deciding upon the correct hierarchical framework structure can be a tough call. Should you go with a single base layer to enable communication between frameworks or should there be multiple shared frameworks?

## Build times

### What’s your cold start build time, and what are your plans to improve it

A clean build can take up to seven or eight minutes. There are constant ideas and initiatives to monitor and improve build times. Firstly we measure developer build times so that we can measure improvements and regressions. However, we want to improve on this further. We intend to continue modularising the app by creating new modules and extracting functionality from the main app into other existing ones. We intend to implement tooling that can relieve some of the burden on developers during modularisation. We’re also interested in the potential of build artefact caching and having the ability to dynamically link frameworks in development but statically for release. We’ve also identified some optimisations that could be possible around some of the build phases of the app that we intend to tackle in the future.

## Tuist

### What’s the feature that you like the most from Tuist and why?

`tuist generate` 😃. Aside from that I also like the scaffold feature. We use that for templating new frameworks, which speeds things up quite a bit. I use tuist edit all the time to get code completion and all the other goodies that come with the IDE.

### Do you use project description helpers? If so, how?

Yes, our entire setup is done using the `ProjectDescriptionHelpers`. In some cases, the manifest for a framework is **a single line of code** due to the use of `ProjectDescriptionHelpers`.
