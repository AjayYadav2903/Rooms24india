
<!-- <p align="center">
<img src="./icon.png" alt="SHSearchBar" height="128" width="128">
</p> -->

<h1 align="center">SHSearchBar</h1>

<p align="center">
  <a href="https://app.bitrise.io/app/582435533da6e6e8">
    <img alt="Build Status" src="https://app.bitrise.io/app/582435533da6e6e8/status.svg?token=txPO2FVRfVTh3wS57eoOuw&branch=develop"/>
  </a>
  <img alt="Github Current Release" src="https://img.shields.io/github/release/blackjacx/SHSearchBar.svg" /> 
  <img alt="Cocoapods Platforms" src="https://img.shields.io/cocoapods/p/SHSearchBar.svg"/>
  <img alt="Xcode 10.0+" src="https://img.shields.io/badge/Xcode-10.0%2B-blue.svg"/>
  <img alt="iOS 10.0+" src="https://img.shields.io/badge/iOS-10.0%2B-blue.svg"/>
  <img alt="Swift 4.2+" src="https://img.shields.io/badge/Swift-4.2%2B-orange.svg"/>
  <img alt="Github Repo Size" src="https://img.shields.io/github/repo-size/blackjacx/SHSearchBar.svg" />
  <img alt="Github Code Size" src="https://img.shields.io/github/languages/code-size/blackjacx/SHSearchBar.svg" />
  <img alt="Github Closed PR's" src="https://img.shields.io/github/issues-pr-closed/blackjacx/SHSearchBar.svg" />
  <a href="https://github.com/Carthage/Carthage">
    <img alt="Carthage compatible" src="https://img.shields.io/badge/Carthage-Compatible-brightgreen.svg?style=flat"/>
  </a>
  <a href="https://github.com/Blackjacx/SHSearchBar/blob/develop/LICENSE?raw=true">
    <img alt="License" src="https://img.shields.io/cocoapods/l/SHSearchBar.svg?style=flat"/>
  </a>
  <a href="https://codebeat.co/projects/github-com-blackjacx-shsearchbar">
    <img alt="Codebeat" src="https://codebeat.co/badges/44539071-5029-4379-9d33-99dd721915c8" />
  </a>
  <a href="https://cocoapods.org/pods/SHSearchBar">
    <img alt="Downloads" src="https://img.shields.io/cocoapods/dt/SHSearchBar.svg?maxAge=3600&style=flat" />
  </a>
  <a href="https://www.paypal.me/STHEROLD">
    <img alt="Donate" src="https://img.shields.io/badge/Donate-PayPal-blue.svg"/>
  </a>
</p>

The clean and shiny search bar that does what UISearchBar does only with dirty 
hacks. This view is designed to tackle the customization limits of UISearchBar. 
The difference here is that this class does not inherit UISearchBar but 
composes a new UIView object by using a UITextField that is much easier to use. 
These are the limits of the UISearchBar:

- no clean way to left align the placeholder
- the cancel button is hard to taylor to your needs
- generally the appearance is not customizable (e.g. the font of the text)
- there are some strange behaviours when you set a custom background image

Since I use a UITextField these restrictions do not apply.

## Installation

SHSearchBar is compatible with `iOS 9` or higher and builds with `Xcode 9` 
and `Swift 4` syntax. It is available through [CocoaPods](http://cocoapods.org). 
To install it, simply add the following line to your Podfile:

```ruby
pod "SHSearchBar"
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks. To integrate SHSearchBar into your Xcode project using Carthage, specify it in your Cartfile:

```ruby
github "Blackjacx/SHSearchBar"
```

## Examples

The repo includes an example project. It shows shows different use cases of 
the searchbar. To run it, just type `pod try SHSearchBar` in your console and 
it will be cloned and opened for you. The following images show some of these 
use cases:

<p align="center">
<caption align="center">You can show a custom placeholder like for normal text fields:</caption><br />
<img src="./github/assets/example_01.png" alt="Placeholder">
</p>

<p align="center">
<caption align="center">And you can even type text into that searchbar:</caption><br />
<img src="./github/assets/example_02.png" alt="Text">
</p>

<p align="center">
<caption align="center">Wow there are customizable accessory views too:</caption><br />
<img src="./github/assets/example_03.png" alt="Accesssory Icon">
</p>

<p align="center">
<caption align="center">Easily customize text and cancel button as you want:</caption><br />
<img src="./github/assets/example_04.png" alt="Customizable text and ancel button">
</p>

<p align="center">
<caption align="center">You can customize each corner radius of the text field so that layouts like this become an ease:</caption><br />
<img src="./github/assets/example_06.png" alt="Corner Radius Customization">
</p>

<p align="center">
<caption align="center">The inner text field supports the new iOS 10 'textContentMode':<br />(Re-uses the address searched in Apple Maps before)</caption><br />
<img src="./github/assets/example_05.png" alt="UITextContentMode Support">
</p>

<p align="center">
<caption align="center">You can use the search bar inside a UINavigationBar:</caption><br />
<img src="./github/assets/example_07.png" alt="UINavigationBar Support">
</p>

## Contribution

- If you found a **bug**, please open an **issue**.
- If you have a **feature request**, please open an **issue**.
- If you want to **contribute**, please submit a **pull request**.

## Author

[Stefan Herold](mailto:stefan.herold@gmail.com) ??? [@Blackjacxxx](https://twitter.com/Blackjacxxx)

## License

SHSearchBar is available under the MIT license. See the LICENSE file for more 
info.
