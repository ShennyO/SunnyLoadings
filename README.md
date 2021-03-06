# SunnyLoadings

[![CI Status](https://img.shields.io/travis/ShennyO/SunnyLoadings.svg?style=flat)](https://travis-ci.org/ShennyO/SunnyLoadings)
[![Version](https://img.shields.io/cocoapods/v/SunnyLoadings.svg?style=flat)](https://cocoapods.org/pods/SunnyLoadings)
[![License](https://img.shields.io/cocoapods/l/SunnyLoadings.svg?style=flat)](https://cocoapods.org/pods/SunnyLoadings)
[![Platform](https://img.shields.io/cocoapods/p/SunnyLoadings.svg?style=flat)](https://cocoapods.org/pods/SunnyLoadings)


![preview](https://camo.githubusercontent.com/da2a58c305b77e6419a2820ba8a8c1c7b7ba9feb/68747470733a2f2f6d656469612e67697068792e636f6d2f6d656469612f32783074454158656e434a4c6850374465642f67697068792e676966)


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

SunnyLoadings is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SunnyLoadings'
```

## To Use:

1. Instantiate the loader class  ``` let loader = Loader(vc: self) ```
2. To start the loading animation, call the method startAnimations, specify the position and size of your preferred loading indicator and color of choice``` loader.startAnimations(x: self.view.bounds.midX, y: self.view.bounds.midY, size: self.view.bounds.width * 0.3, color: UIColor.white) ``` 
3. To end the animations, just call the method stopAllAnimations with the specific case, whether it's a success: ``` loader.stopAllAnimations(result: .success) ``` or failure: ``` loader.stopAllAnimations(result: .failure) ```

## Extra Notes:

Known bug: When clicking the home button and returning to the app, or when changing view controllers, the expanding and shrinking animation of the circle is automatically removed. To work around this, developers can call the method removeAnimationViews: ``` loader.removeAnimationViews() ``` when leaving the view and call the function 'startAnimations': ``` loader.startAnimations(x: self.view.bounds.midX, y: self.view.bounds.midY, size: self.view.bounds.width * 0.3) ``` again when the view is displayed again.


## Author

ShennyO, SunnyOuyang.work@gmail.com

## License

SunnyLoadings is available under the MIT license. See the LICENSE file for more info.
