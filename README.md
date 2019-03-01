# Prestyler

[![CI Status](https://img.shields.io/travis/kruil/Prestyler.svg?style=flat)](https://travis-ci.org/kruil/Prestyler)
[![Version](https://img.shields.io/cocoapods/v/Prestyler.svg?style=flat)](https://cocoapods.org/pods/Prestyler)
[![License](https://img.shields.io/cocoapods/l/Prestyler.svg?style=flat)](https://cocoapods.org/pods/Prestyler)
[![Platform](https://img.shields.io/cocoapods/p/Prestyler.svg?style=flat)](https://cocoapods.org/pods/Prestyler)

## Requirements

- iOS 9.2+ / macOS 10.12+ / tvOS 10.0+ / watchOS 3.0+
- Xcode 10.1+
- Swift 4.0+

## Installation

Prestyler is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Prestyler'
```
## What is Prestyler?

Actually, Prestyler allows you to replace this code
``` swift
let baseString = "It is a pain to use attributed strings."
let attributedString = NSMutableAttributedString(string: baseString, attributes: nil)
let painWord = (attributedString.string as NSString).range(of: "pain")
let attributes: [NSAttributedStringKey : Any] = [
    NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18),
    NSAttributedStringKey.underlineStyle : 2,
    NSAttributedStringKey.foregroundColor : UIColor.red]
attributedString.setAttributes(attributes, range: painWord)
label.attributedText = attributedString
```
to
``` swift
Prestyler.newRule("$", Prestyle.bold, Prestyle.underline, UIColor.red)
label.attributedText = "Prestyler do $everithing$ instead of you.".prestyled()
```

## How to use

Prestyler parse your string and gives `NSAttributedString` as a result:
``` swift
import Prestyler
...
label.attributedText = "Hello, i am <b>bold<b> text!".prestyled()
```
### Predefined rules
4 rules are predefined and you can use them directly. Its's a **\<b>** for bold, **\<i>** for italic, **\<strike>** and **\<underline>** .
``` swift
label.attributedText = "And here is <i>italic<i> text!".prestyled()
```
### Custom rules
And off course you can easy define your own simple rules
``` swift
Prestyler.newRule("$", UIColor.green)
label.attributedText = "It's a $green$ text.".prestyled()
```
or more complex with different styles combination:
``` swift
Prestyler.newRule("<BigYellowBold>", 48, UIColor.yellow, Prestyle.bold)
label.attributedText = "It's a <BigYellowBold>green<BigYellowBold> text.".prestyled()
```
### Working with colors
There are several ways you can manage colors in Prestyler. The easest one is just to pass `UIColor` or hex string as a style:
``` swift
Prestyler.newRule("<colored>", UIColor.yellow)
Prestyler.newRule("<colored>", "#b5e253")
Prestyler.newRule("<colored>", "#ff0")
Prestyler.newRule("<colored>", "ff2")
```
This colors would be applied to foreground text color. To set a backgound color you have to use `Precolor` class, which has several more interesting options.
``` swift
Prestyler.newRule("<colored>", Precolor(UIColor.yellow).forBackgound())
Prestyler.newRule("<colored>", Precolor("#b5e253").forBackgound())
Prestyler.newRule("<colored>", Precolor("#ff0").forBackgound())
```
`Precolor` has a `random(_ percent: Int)` method which allows you to get cool effects in seconds.
``` swift
// Color is mixed for 50% with random color
Prestyler.newRule("<randomRed>", Precolor(UIColor.red).random(50))
// 100% random
Prestyler.newRule("<random>", Precolor().random())
```

## Few things you need to know

- Don't put a tag inside other tags. Results can be unexpectable (but safe). Instead just create new Rule with desired style.
- Adding same styles to rule like `Prestyler.newRule("$", UIColor.yellow, UIColor.green)` has no effect. There will be applied just a last one.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Author

Ilia Krupko

## License

Prestyler is available under the MIT license. See the LICENSE file for more info.
