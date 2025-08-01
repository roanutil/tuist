---
title: 'Interview with Angry Nerds - Project description helpers are a game changer for modular apps'
category: "community"
tags: [Tuist, Angry Nerds, Swift, XcodeProj]
excerpt: 'In this blog post we interview Marcel from Angry Nerds, a custom software development company based in Wrocław, Poland. Marcel talks about a wide range of topics which includes their workflows, preferred code patterns and architecture, and their testing strategy.'
interviewee_name: 'Angry Nerds'
interviewee_role: "iOS developer at Angry Nerds"
interviewee_x_handle: 'angrynerds_soft'
interviewee_avatar: https://avatars1.githubusercontent.com/u/23309916?s=200&v=4
type: interview
---

In this post of our Apps at Scale series where we interview teams building apps at a large scale, we interview [Marcel](https://twitter.com/marcelstarczyk), iOS developer at [Angry Nerds](https://twitter.com/angrynerds_soft), a custom software development company based in Wrocław, Poland. Angry Nerds builds mobile apps for all kinds of industries, including education, entertainment, healthcare, transportation and more.

## Team structure

### Do you organize yourselves differently depending on the project? If so, what does it depend on?

Currently, the Angry Nerds iOS team consists of 7 developers, mostly mid- and senior-level. The number of team members engaged in a particular project usually depends on the client's requirements and the project's scope. Commonly, there's at least one iOS developer working in every mobile project. As for organizing the work, we run projects according to agile principles and best practices. We usually work in **1- or 2-week sprints** that allow us to be flexible towards changing requirements. [CI/CD](https://en.wikipedia.org/wiki/CI/CD), [GitFlow](https://datasift.github.io/gitflow/IntroducingGitFlow.html) and regular code reviews are fundamental processes we apply to every project.

### How do developers collaborate with designers and product stakeholders?

The collaboration with designers is practically seamless, as we have an in-house design team. We’re in constant communication and solve any issues almost instantly. Designers often consult their work with us, and the other way round, to assure consistency and make the teamwork more efficient. We also build close relationships with other stakeholders, including the clients. With daily communication and regular demos, we want to make the workflow and knowledge transfer as smooth as possible.

## Project and code architecture

### Could you name some traits that are common to every project and therefore you need them to be consistent?

First of all, our projects are open for the whole iOS team and code reviews across the projects are highly encouraged. The `yml` template definitions of our CI system pipelines are shared across projects. We have also CD definitions to reflect all changes made on the development branch that need to be tested by our QA team. As for pull requests, the template requirements are filled out by the developer who creates the particular PR. And of course, in all our projects we follow Xcode’s Clean Swift templates.

### How’s the process of creating new projects and ensuring consistency?

We are still in the process of finding the most effective way to create and manage our projects with consistency. We’ve tried using XcodeGen which has its definitions written in `yml`. It worked quite well but it didn’t feel native enough for us. After discovering Tuist and trying it on a sample project, we really appreciate the fact that the project definitions are written in an already known language, used by most iOS developers – Swift. We haven’t finished working on the process yet, but we are definitely getting closer to it everyday.

### What strategy do you follow to not duplicate efforts across projects?

We try to discover and extract common APIs / code parts into one accessible place for our iOS team to reuse (and possibly improve in time). For example, we did it with Networking Layer code or most common Foundation extensions.

### Do you have a fixed way to organise your project modules?

We do have modules that you could call our "core" modules, for example: the Design System module which encompases the app’s fonts, font styles and colors, the `CommonUI` module which contains all common views, assets etc. that other “feature” modules use, and the `Networking` module which includes the core of networking layer that other modules use. Other modules are created organically and based on particular features/requirements.

### What code architecture do you usually use in your apps?

Most of our projects are now written using Clean Swift architecture which is based on Uncle Bob’s [Clean Code paradigm](http://cleancoder.com/) of code separation. We also have some projects written using [RxSwift](https://github.com/ReactiveX/RxSwift) + [MVVM](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel).

### Why do you prefer reactive programming over other paradigms?

We did some projects using reactive programming in the past, however right now, as our recent projects are utilizing the Clean Swift architecture, we tend not to use reactive paradigms in those. Code separation and unidirectional communication between the entities in Clean Swift’s modules are sufficient and the usage of reactive paradigms would not be as beneficial. Still, we are not against those paradigms. Lately, we've been looking into [Swift Composable architecture](https://github.com/pointfreeco/swift-composable-architecture) - its usage of reactive paradigms is actually very promising. We would like to try it out in some of our future projects.

## Dependencies

### How do you manage your third-party dependencies?

In most cases, we use [Swift Package Manager](https://swift.org/package-manager/). As a fallback, we practice manual addition to a project, if a particular dependency does not support SPM.

### What’s a third-party dependency your project heavily depends on?

The key ones are: [RSwift](https://github.com/mac-cain13/R.swift) for resources management, [Needle](https://github.com/uber/needle) for Dependency Injection and [Alamofire](https://github.com/Alamofire/Alamofire) for Networking purposes.

### What’s your take on external dependencies?

We think that dependencies that solve the core problems of the app (like Networking layer, AutoLayout definitions, Resource management or Dependency Injection) are fine to incorporate into a project as they are mostly well written, tested and maintained. We tend not to add external dependencies that solve app-specific problems, are not up-to-date or are no longer maintained by their creators (or the open source community).

## Testing

### What’s your testing strategy?

In most projects, we try to cover core business logic with unit tests. We also add some [UI smoke tests](https://softwaretestingfundamentals.com/smoke-testing). Our goal is to cover as much as possible in Interactor and Presenter layers with unit tests. In some current projects we also use [Swift Vapor](https://vapor.codes/) server to mock network traffic.

### How do you balance between unit/integration/ui tests?

We follow a general principle that the number of unit tests should outweigh the number of integration tests.

### Which ones give you more confidence?

We think that confidence comes from somewhere in-between unit and integration tests, as integration tests depend on unit tests, but they are worthless without quality unit tests.

## Tooling

### What are the tools that you usually set up in your projects?

The essential ones are:

- [Rswift](https://github.com/mac-cain13/R.swift)
- [SwiftLint](https://github.com/realm/SwiftLint)
- [SwiftFormat](https://github.com/nicklockwood/SwiftFormat)
- [Needle](https://github.com/uber/needle) for DI
- [Swiftybeaver](https://github.com/SwiftyBeaver/SwiftyBeaver) for logging
- [Lottie](https://github.com/airbnb/lottie-ios)
- [Kingfisher](https://github.com/onevcat/Kingfisher)

## Tuist

### What led you to adopt Tuist?

As we’re constantly working on improving the way we build and manage our projects, we see Tuist as a great tool to support our efforts. To be more precise, we appreciate these particular things about Tuist and they were direct reasons why we decided to adopt the tool to our workflow:

- Project generation definitions written in Swift
- Less git conflicts when working on a single code base, thanks to pbxproj files non existent in the repository
- Clear and predictable CI pipelines based on Tuist API
- Less problems with bootstrapping projects (thanks to `Setup.swift` definitions and `tuist up` command)
- Explicit and clean project settings definitions which help us to clearly see new project’s modifications
- Easy dependency management of third party libraries, be it [Cocoapods](https://cocoapods.org), [Carthage](https://github.com/carthage), SPM or manual addition to project definition under one common API
- We were looking for a way to generate a new project (and its potential subprojects) quickly and effortlessly with one command and Tuist did just that for us.

### What is the Tuist feature that you like the most? Why?

[Tuist up](https://docs.old.tuist.io/commands/up/) command - we really like the fact that we can provide the project’s dependencies to other developers beforehand, so they don't need to waste time on the tools setup and just do it all by executing one command. We also appreciate [Tuist graph](https://docs.old.tuist.io/commands/graph/) command - because we can quickly show other developers the high level view of communication between all app’s modules.

### Do you use project description helpers? If so, for what? Would you mind sharing a code snippet?

Yes, we do! It’s a game changer for us while developing a project with separate modules. We have one common project definition with base settings and schemes which we use in a new module creation. It all comes down to new `Project.swift` file, e.g:

```swift
let project = Project.framework(name: "NewModule",
                                targets: [.framework],
                                packages: [
                                  .package(url: "https://github.com/airbnb/lottie-ios.git", from: "3.1.6")
                                ],
                                externalDependencies: [.package(product: "Lottie")],
                                internalDependencies: [
                                  "Core",
                                  "CommonUI",
                                  "DesignSystem",
                                  "Networking",
                                  "Map",
                                  "Rating",
                                  "Settings"
                                ],
                                resources: [
                                  .glob(pattern: "**/*.swift"),
                                  .glob(pattern: "Resources/**")
                                ])
```

And we have a new module ready for implementation!

### What’s something you would like Tuist to help you with?

To be honest, Tuist adds new features much faster than we are able to adopt them, so anytime we come up with an idea – it's there 😅 Still waiting for that run command though 🤞

## Other

### What were you most excited about this year’s WWDC?

[AppClips](https://developer.apple.com/app-clips/) look very promising. Also ARKit advancements are something we are looking forward to, as we have a project coming up in the pipeline, which will make extensive use of it.

### What is the project you are most proud of in terms of technical challenge?

Our recent favorite is [Cats and Dogs: The Weather App](https://angrynerds.co/projects/cats-and-dogs-the-weather-app/), a gamified weather app we created with a UK-based creative agency. The key purpose of the app is that apart from receiving a reliable weather forecast, you get to take care of a virtual pet and earn bonuses for dressing it according to the weather. The client provided all the designs, including over 10K (!) animations which are the very heart of the project. They were also one of the biggest challenges in development, as it required weeks of detailed work to integrate the animations and sounds with the app’s features. We’re really proud of how it turned out! The app has been created with MVVM + Coordinators architecture and RxSwift library, and for the animations we used Lottie.
We’ve also been a long-term partner to an international optoelectronics company, working with them on a complex mobile app for hunters, with such features as ballistics calculator, GPS assistance and more. There are also many exciting projects we worked on that we can’t mention because of the NDA agreements with our clients.

### Have you accommodated your work style to these unprecedented times?

It was quite impressive that a team of over 70 people switched to remote work basically overnight – and it went so smoothly. We are seriously blessed that our work can be done virtually from any place in the world with good internet connection. I think we should acknowledge it a little more. As much as we’re used to remote work right now, we look forward to meeting once again in the office with the rest of the Angry Nerds team!
