---
title: 'Interview with Franz Busch - We are now using Combine as our Reactive framework and it makes development so much better'
category: "community"
tags:
  [
    Tuist,
    Franz,
    Sixt,
    soundcloud,
    app development at scale,
    xcodeproj,
    xcode,
    swift,
    xcodegen,
    xcode project generation,
  ]
type: interview
excerpt: 'In this interview we talk with Franz Busch, iOS Developer at Sixt, a mobility provider. Franz shares how the adoption of the RIBs and Combine significantly improved the development experience and allowed them to have a very good test coverage.'
interviewee_name: 'Franz Busch'
interviewee_role: "iOS developer at Sixt"
interviewee_x_handle: 'FranzJBusch'
interviewee_avatar: https://pbs.twimg.com/profile_images/1009133677929009152/zC1BnPOZ_400x400.jpg
---

Continuing with our series of interviews about companies doing app development at scale, we are pleased to have [Franz Busch](https://twitter.com/FranzJBusch), iOS Developer at [Sixt](https://es.wikipedia.org/wiki/Sixt). As a mobility provider, Sixt has unique challenges, like integrating with car SDKs, that led the company to adopt a modular architecture using Uber's RIB approach and develop features following the reactive paradigm with Combine.

## Tell us more about yourself and the project you work on

I have been developing iOS apps for the past 8 years and started at [Sixt](https://www.sixt.de/) in 2016. Back then we were still developing our applications in Objective-C and only had a team of 3 people per platform. Since, then we grew tremendously both in team and app size which resulted in an increased complexity as well. Nowadays, we are not only a car rental company anymore but transformed into a true mobility provider. Our application has a broad range of products from the classic car rental to car sharing and scooters. Additionally, we launched last year the integration of our own ride hailing platform which is available world wide and just 2 weeks ago we launched our new car subscription product. About 2 years ago I created our internal **platform team** which is responsible for CI/CD, our build setup, internal libraries and a bunch of shared processes.

## Team structure

### How are the teams structured?

We have **5 teams** working in our application at the moment. Each team is responsible for certain domains. For example one team is responsible for our car rental product and the other for the whole account section. The only team that has no direct domain is our platform team which takes care about a lot of shared libraries.

### How many engineers work on features and how many take care of the infrastructure of your projects?

8-10 work on features and 2 on infra per platform.

## Project and code architecture

### Could you describe the architecture of your project?

We started off with the classic [MVC](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller) architecture. After, 2 years of development we noticed that we are running into the same problems again and again and that collaboration between teams wasn’t the best since MVC can be interpreted quite broadly. Lastly, the testability & reusability of our code wasn’t the best; therefore, we decided to move forward with a [RIB architecture](https://github.com/uber/RIBs) and are currently undergoing a migration. We have finished a lot already. The best part about this is, that we are now using [Combine](https://developer.apple.com/documentation/combine) as our Reactive framework and it makes development so much better!

### What code paradigms and architectures do you follow?

As said before we use RIBs and FRP with Combine. Additionally, we are in the process of modularizing our applicaton heavily. Some other interesting things we are doing: Design System, UI in code, Single responsibility, generate code when possible.

### If you have multiple apps, how do you share code between them and how do you use internal tools to automate repetitive processes?

We have a bunch of internal libraries that fulfill always only one purpose and be very good at that. For example, we have a library with all our UI components or one for formatting. We call these libraries `CoreModules` and they are shared among all our applicatons. On top of them, we build so-called `BusinessModules` that are then implementing specific flows. For example we have a `BusinessModule` that handles the `SixtLoginRegister` flow, which is specific to one application. Sometimes, these `BusinessModules` can be shared but most often they are specific to one app.

### What are the main challenges on your architecture when scaling?

The architecture can scale quite heavily as shown by [Uber](https://www.uber.com/de/en/). The biggest challenges are probably to keep the dependency graph sane and the build times low.

## Dependencies

### How do you manage your third-party dependencies?

Right now we are still integrating them through [Carthage](https://github.com/carthage/carthage) but plan to move over to SPM as soon as Xcode 12 hits GM. We have a bunch of binary dependencies which will be supported by Xcode 12 🥳.

### What’s a third-party dependency your project heavily depends on?

We do not heavily rely on any third party dependency, since we are always trying to hide dependencies behind protocols. However, since we are a interacting with cars a lot we are quite relient on the car vendor SDKs to communicate with the cars.

### What’s your take on external dependencies?

Keep the number low and if possible build them internally. If that is not possible always hide them behind protocols, so that no logic is directly relying on them. This allowed us oftentimes to switch the underlying dependency without anybody noticing it.

## Testing

### What’s your testing strategy?

Our focus is heavy on unit testing. In our old MVC architecture we had quite a bunch of problems with testability. Nowadays, with RIBs almost all of our business logic is testable and we are requiring tests for all new code. Additionally, our `CoreModules` need to be test covered quite extensively since we have to rely on them in the business logic layer. For our UI components and also screens we are using snapshot tests to make sure that the UI looks and behaves like we want it to. This allows us to move fast on the UI as well without breaking anything. We also have a whole testing team that takes care about manual and automated tests written in Appium. This allows us to release every 2 weeks with confidence.

### Do you use third-party frameworks for testing?

In the beginning, we used [Nimble](https://github.com/Quick/Nimble) but decided to migrate to [XCTest](https://developer.apple.com/documentation/xctest) since it provides everything we need. For snapshot testing we use the [library from Pointfree](https://github.com/pointfreeco/swift-snapshot-testing). Lately, we have written our own `CombineTestHelpers` to make testing of Combine based code easier.

### How many tests do you have and how are they split between unit/integration/ui. Which ones give you more confidence?

**2,5k unit + snapshot tests**. No integration or UI tests from our side. However, a lot of UI automation tests for all of our core flows from our test team. The unit tests give us the most confidence right now since the migration to RIBs we cover all of our business logic which is the most crucial to test.

## Tooling

### What internal tools did you build that you are proud of?

A tool to download & organize all of our translations which is quite handy and fast!
A tool that lints XIB & Storyboard files e.g. to disallow usage of images in them or check that nothing is ambiguous.
We have an internal debug screen which allows to hook new subscreens in dynamically. For example when transitioning to a certain screen it can register an associated debug screen which allows for better debugging.

### What are your main challenges on tooling when scaling?

When scaling, the performance of tools is very important. Especially, when these tools need to run during build time. Additionally, in larger projects you need to be careful when using code generation during build phases since it can hinder fast incremental builds quite drastically. Lastly, tools should be used when there is a big potential for critical bugs such as API contracts. API clients & server stubs should be generated by tools to avoid any misinterpretations.

### What are some challenges you are facing scaling up your project?

Definitely **build time**. The bigger the project gets the harder it becomes to track dependencies and also code that is slow to compile. Keeping on top of this is nearly a fulltime job. We were thinking about moving to [Bazel](https://bazel.build/) for a long time now to make use of remote caching. Our ultimate goal is to provide developers fast iterative development.

## Build times

### What’s your cold start build time, and what are your plans to improve it

Our build time for clean builds is 300 seconds.

## Tuist

### What motivates you to consider the adoption of Tuist?

Right now we are using [XcodeGen](https://github.com/yonaskolb/xcodegen) for our project. While this made it already 100 times better than before it has certain limitations. First, it does not allow scripting. We have some build phases that need to get all the dependencies and pass it to a command. This is right now hard coded and required manual updating. Additionally, the YAML format is not the best to code-review and write. Lastly, it does not help us with improving build performance. With Tuist we hope to tackle of these. Especially the focus mode and pre-build dependencies would be great. A killer feature for Tuist would be integrating with Bazel. Right now this is rather cumbersome and has some very hard problems like debugging support. The people at [Lyft](https://lyft.com) made tremendous improvements there and if there would be an easy to use solution would be awesome.

## Other

### If you started the project again, what would you do differently?

Choose an architecture that covers these problems from the beginning: _high testability, common dependency injection strategy, modulare, single responsibility, supports asynchronous in app routing, uses FRP._
From a build perspective: Start with modularisation right way and try to keep the main target as slim as possible. Additionally start with something like Tuist right away. If there is enough experience or capacity use Bazel.
On a side note, I think for any bigger app having a design system from the beginning makes creating new UIs way easier and the whole UX feels more coherent.

### What’s the announcement that excited you the most from WWDC?

There is a lot in it for us. Apple Silicone means we need to look into our iOS app on Mac which is interesting. For our project probably the advancements in [SwiftPM](https://github.com/apple/swift-package-manager). [SwiftUI](https://developer.apple.com/xcode/swiftui/) seems to get better and better and we are really looking forward to use it at some point.
