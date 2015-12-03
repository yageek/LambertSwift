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
    
    func testExample() {
        // This is an example of a functional test case.
            var pt = CLLocation(x: 668832.5384, y: 6950138.7285, inZone: .Lambert93)
            print("Pt origin: \(pt.coordinate.latitude) \(pt.coordinate.longitude)")
//668832.5384,6950138.7285
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
