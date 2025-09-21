# rab-foundation // RabFoundation

A small pure and cross-platform Swift library (usable on Windows or WebAssembly for example). Without any specific context, it just includes reusable code, covering very different topics.

![platform](https://img.shields.io/badge/platform-macOS%20%7C%20iOS%20%7C%20tvOS%20%7C%20watchOS%20%7C%20visionOS%20%7C%20Linux%20%7C%20Windows%20%7C%20WebAssembly-lightgrey)

[![CodeQL](https://github.com/auvents-brave/RABFoundation/actions/workflows/github-code-scanning/codeql/badge.svg)](https://github.com/auvents-brave/RABFoundation/actions/workflows/github-code-scanning/codeql)

[![codecov](https://codecov.io/gh/auvents-brave/RABFoundation/branch/main/graph/badge.svg?token=YOURTOKEN)](https://codecov.io/gh/auvents-brave/RABFoundation)

[![Docs](https://img.shields.io/badge/docs-available-brightgreen)](https://auvents-brave.github.io/RABFoundation/)

>  One day I created a folder on my HD to move various documents to organise or destroy at a later time. I called it ["rubrique à brac"](https://fr.wikipedia.org/wiki/rubrique-à-brac), from the name of a French comic book series. Years later, when I was thinking about creating my first library to store code that could be used in different applications, the name RabLib just popped into my head!

I try to document the code as well as possible, and have a good coverage of unit tests, without being perfect either.

I use Xcode on macOS and VS Code on Windows. Always the latest versions of development environments, or at least very recent. I always recommend to use the latest released version.

- [Download Xcode here][xcode]
- [Download Visual Studio Code here][vscode]
- [Download Swift here][swift]


## What's inside

#### Bundle

Provides convenient accessors for version numbers in an application's Info.plist via Bundle extensions.

```swift
let v = Bundle.main.releaseVersionNumber! + " (" + Bundle.main.buildVersionNumber! + ")"
```

#### StripHtlmlTags

Removes HTML tags from a given string using two different regular expressions.

```swift
let stripped = StripHtlmlTags(myTextContaingHtmlTags strict: true)
```

#### Throttled

Provides a property wrapper to throttle the assignment of values to a property, ensuring that updates only occur at a specified minimum interval.

```swift
@Throttled(timeInterval: 2) var myText = "Hello"
```

## Contributing

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change. Please make sure to update tests as appropriate.

## License

[MIT](LICENSE.txt)



```swift
let kumaraswamy = Uncertain<Double>.kumaraswamy(a: 2.0, b: 3.0)
```


[xcode]: https://developer.apple.com/xcode/
[vscode]: https://code.visualstudio.com/Download
[swift]: https://swift.org/download/#releases
