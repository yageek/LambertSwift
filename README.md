[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE.md)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

# LambertSwift

LambertSwift is a Swift lightweight library to convert Lambert coordinates to WGS84

# Carthage
```
github "yageek/LambertSwift"
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



