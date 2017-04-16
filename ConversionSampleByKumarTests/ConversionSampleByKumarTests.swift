//
//  ConversionSampleByKumarTests.swift
//  ConversionSampleByKumarTests
//
//  Created by Avadesh Kumar on 31/03/17.
//  Copyright © 2017 goibibo. All rights reserved.
//

import XCTest
@testable import ConversionSampleByKumar

class ConversionSampleByKumarTests: XCTestCase {
    
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
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        guard let _ = AKProduct.getPlistDataArray(from: "rates") else {
            XCTAssertTrue(false, "Unable to load rates plist from bundle")
            return
        }
        
        guard let _ = AKProduct.getPlistDataArray(from: "transactions") else {
            XCTAssertTrue(false, "Unable to load transactions plist from bundle")
            return
        }

        guard let _ = AKProduct.getProductObjects() else {
            XCTAssertTrue(false, "Unable to fetch products from plist")
            return
        }
        
        guard let _ = AKProduct.getProductObjects() else {
            XCTAssertTrue(false, "Unable to fetch products from plist")
            return
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
