![Prestyler: Swift text styler](https://github.com/kruil/Prestyler/blob/master/logo.png?raw=true)
[![CI Status](https://img.shields.io/travis/kruil/Prestyler.svg?style=flat)](https://travis-ci.org/kruil/Prestyler)
[![Version](https://img.shields.io/cocoapods/v/Prestyler.svg?style=flat)](https://cocoapods.org/pods/Prestyler)
[![Swift Version](https://img.shields.io/badge/language-swift%204.2-brightgreen.svg)](https://developer.apple.com/swift)
[![License](https://img.shields.io/cocoapods/l/Prestyler.svg?style=flat)](https://cocoapods.org/pods/Prestyler)
[![Platform](https://img.shields.io/cocoapods/p/Prestyler.svg?style=flat)](https://cocoapods.org/pods/Prestyler)

Prestyler is a text formatting library which is based on original NSAttributedString class. It simplifies and extends original workflow, giving you clean and short syntax.

---

Actually, Prestyler allows you to replace this code
``` swift
let baseString = "It is a pain to use attributed strings in ios."
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
Prestyler.defineRule("$", Prestyle.bold, Prestyle.underline, UIColor.red)
label.attributedText = "Prestyler do $everything$ instead of you.".prestyled()
```

### Requirements and installation

- iOS 9.0+
- Xcode 10.0+
- Swift 4.2+

Prestyler is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Prestyler'
```

# How to use

Prestyler parse your string, applies defined rules, and gives `NSAttributedString` as a result:
``` swift
import Prestyler
...
label.attributedText = "Hello, i am <b>bold<b> text!".prestyled()
```
You also can style a text directly by listing its styles:
``` swift
label.attributedText = "Prestyler".prestyledBy(styles: UIColor.green)
```
Or by defined rules:
``` swift
Prestyler.defineRule("myRule", UIColor.green)
...
label.attributedText = "All this text is bold.".prestyledBy(rule: "myRule")
```

### Predefined rules
Several rules already defined. It's a **\<b>** for bold, **\<i>** for italic, **\<strike>** and **\<underline>** .
``` swift
label.attributedText = "And here is <i>italic<i> text!".prestyled()
```

### Custom rules
You can easy define your own simple rules.
``` swift
Prestyler.defineRule("$", UIColor.green)
label.attributedText = "It's a $green$ text.".prestyled()
```
or more complex with different styles combination:
``` swift
Prestyler.defineRule("<BigYellowBold>", 48, UIColor.yellow, Prestyle.bold)
label.attributedText = "It's a <BigYellowBold>green<BigYellowBold> text.".prestyled()
```
When you define a rule first parameter is a pattern to search in `String` format, and then you put list of styles. To define a style you can use next classes:
``` swift
* Prestyle.bold // .italic, .strike, .underline
* Precolor(.red) // Precolor("#af45392"), Precolor().random . Read more about colors below
* UIFont // UIFont.italicSystemFont(ofSize: 33)
* UIColor // UIColor.green
* String // "432" or "#432"or "#648362" treated as hex color
* Int // 18, treated as a font size
```

### Working with colors 🎨
There are several ways you can manage colors in Prestyler. The easiest one is just to pass `UIColor` or hex string as a style:
``` swift
Prestyler.defineRule("<colored>", UIColor.yellow)
Prestyler.defineRule("<colored>", "#b5e253")
Prestyler.defineRule("<colored>", "#ff0")
Prestyler.defineRule("<colored>", "ff2")
```
This colors would be applied to foreground text color. To set a background color you have to use `Precolor` class, which has several more interesting options.
``` swift
Prestyler.defineRule("<colored>", Precolor(UIColor.yellow).forBackgound())
Prestyler.defineRule("<colored>", Precolor("#b5e253").forBackgound())
Prestyler.defineRule("<colored>", Precolor("#ff0").forBackgound())
```
`Precolor` has a `random(_ percent: Int)` method which allows you to get cool effects in seconds.
``` swift
// Color is mixed for 50% with random color
Prestyler.defineRule("<randomRed>", Precolor(UIColor.red).random(50))
// 100% random
Prestyler.defineRule("<random>", Precolor().random())
```

### Few things you need to know

- Don't put a tag inside other tags. Results can be unexpectable (but safe). Instead just create new Rule with desired style.
- Adding same styles to rule like `Prestyler.defineRule("$", UIColor.yellow, UIColor.green)` has no effect. There will be applied just a last one.
- When you define already existing style the old one would replaced.

# Example
To run the example project, clone the repo, and run `pod install` from the Example directory first.

![Prestyler: Swift text styler](https://raw.githubusercontent.com/kruil/Prestyler/master/screenshot1.png?raw=true)

## Author

Ilia Krupko

## License

Prestyler is available under the MIT license. See the LICENSE file for more info.
