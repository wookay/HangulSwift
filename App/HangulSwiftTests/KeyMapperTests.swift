//
//  KeyMapperTests.swift
//  HangulSwift
//
//  Created by wookyoung on 2/2/16.
//  Copyright © 2016 factorcat. All rights reserved.
//

import Foundation
import XCTest

class KeyMapperTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test390() {
        let path = [NSBundle.mainBundle().resourcePath!, "390-Sebulshik.txt"].joinWithSeparator("/")
        let rows = jamo_mapper_rows(path)
        XCTAssertEqual(4, rows.count)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
