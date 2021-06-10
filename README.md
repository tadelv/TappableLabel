# TappableLabel

[![Version](https://img.shields.io/cocoapods/v/TappableLabel.svg?style=flat)](https://cocoapods.org/pods/TappableLabel)
[![License](https://img.shields.io/cocoapods/l/TappableLabel.svg?style=flat)](https://cocoapods.org/pods/TappableLabel)
[![Platform](https://img.shields.io/cocoapods/p/TappableLabel.svg?style=flat)](https://cocoapods.org/pods/TappableLabel)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

Using TappableLabel should be quite intuitive. All you need to do, is `import TappableLabel`, and all your UILabel objects will gain automatic link detection.

Here is an example:
```swift
import TappableLabel

let myLabel = UILabel()
// set up the label using NSAttributedString
myLabel.addLinkDetection { url in
  UIApplication.shared.open(url)
}
```

## Installation

TappableLabel is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'TappableLabel'
```

## Author

Vid Tadel

## License

TappableLabel is available under the MIT license. See the LICENSE file for more info.
