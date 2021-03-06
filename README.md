[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE.md)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/LambertSwift.svg)](https://img.shields.io/cocoapods/v/LambertSwift.svg)
[![Platform](https://img.shields.io/cocoapods/p/LambertSwift.svg?style=flat)](http://cocoadocs.org/docsets/LambertSwift)

# LambertSwift

LambertSwift is a Swift lightweight library to convert Lambert coordinates to WGS84
 
# Carthage
```
github "yageek/LambertSwift"
```

# Swift Package Manager
```
.Package(url: "https://github.com/yageek/LambertSwift.org.git",majorVersion: 1)
```

# Cocoapods
```
pod 'LambertSwift'
```

# Usage

The Lambert extension adds a new initializer to the `CLLocation` class :

```swift
	/**
	  * Zone argument could be one of the followings : 
	  * I, II, III, IV, II_E, L93
	 */
	 var loc:CLLocation = CLLocation(x: 668832.5384, y: 6950138.7285, inZone: .L93)
```

# License
LambertSwift is released under the MIT license. See LICENSE for details.
