# Description

LambertSwift a Swift lightweight library to convert Lambert coordinates to WGS84

# Usage

The Lambert extension adds a new initializer to the `CLLocation` class :

```swift
	/**
	  * Zone argument could be one of the followings : 
	  * LambertI, LambertII, LambertIII, LambertIV, LambertII_E, Lambert93
	 */
	 var loc:CLLocation = CLLocation(x: 668832.5384, y: 6950138.7285, inZone: .Lambert93)
```


