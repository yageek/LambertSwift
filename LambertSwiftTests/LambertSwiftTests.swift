//
//  LambertSwiftTests.swift
//  LambertSwiftTests
//
//  Created by HEINRICH Yannick on 23/12/2014.
//  Copyright (c) 2014 yageek. All rights reserved.
//

import UIKit
import XCTest
import CoreLocation
import LambertSwift

class LambertSwiftTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBasic() {
        // This is an example of a functional test case.
            let pt = CLLocation(x: 668832.5384, y: 6950138.7285, inZone: .L93)
        
            XCTAssertEqualWithAccuracy(pt.coordinate.longitude, 2.56865, accuracy: 1e-3)
            XCTAssertEqualWithAccuracy(pt.coordinate.latitude, 49.64961, accuracy: 1e-3)

    }
    
}
