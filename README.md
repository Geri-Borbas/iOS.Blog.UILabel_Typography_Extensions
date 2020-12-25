# UILabel Typography Extensions 📐
Set line height, letter spacing (and more) on `UILabel`.

```Swift
let label = UILabel()
label.text = "Hello World!"
label.textColor = .label
label.font = .preferredFont(forTextStyle: .largeTitle)
// 🎉
label.lineHeight = 100
label.letterSpacing = 10
label.underline = .double
label.strikethrough = .patternDash
```

A single extension on `UILabel` that adds some typographic property (see above) using [**Objective-C Runtime**] (for stored properties on a Swift extension), [`NSAttributedString`] (for manage typographic properties), and [`NSKeyValueObservation`] (to be able to use the regular `text` property to manage text content).

> 🚧  **Work in progress**. A complemetary blog post (with a corresponding Figma file), and more preview/testing is underway. Also I have high hopes to add leading and trailing image feature as well, so stay tuned.

## License

> Licensed under the [**MIT License**](https://en.wikipedia.org/wiki/MIT_License).

[**Objective-C Runtime**]: https://developer.apple.com/documentation/objectivec/objective-c_runtime
[`NSAttributedString`]: https://developer.apple.com/documentation/foundation/nsattributedstring
[`NSKeyValueObservation`]: https://developer.apple.com/documentation/foundation/nskeyvalueobservation
