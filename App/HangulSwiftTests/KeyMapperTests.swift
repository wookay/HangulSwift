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
        var tested = 0
        if case let .종(sym, sound) = rows[0][2] {
            XCTAssertEqual("!", sym)
            XCTAssertEqual("ㅈ", sound)
            tested += 1
        }
        XCTAssertEqual(1, tested)
    }
    
    func test391() {
        let path = [NSBundle.mainBundle().resourcePath!, "391-Sebulshik.txt"].joinWithSeparator("/")
        let rows = jamo_mapper_rows(path)
        XCTAssertEqual(4, rows.count)
        var tested = 0
        if case let .종(sym, sound) = rows[0][2] {
            XCTAssertEqual("!", sym)
            XCTAssertEqual("ㄲ", sound)
            tested += 1
        }
        XCTAssertEqual(1, tested)
    }
    
    func test3_2015() {
        let path = [NSBundle.mainBundle().resourcePath!, "3-2015.txt"].joinWithSeparator("/")
        let rows = jamo_mapper_rows(path)
        XCTAssertEqual(4, rows.count)
        var tested = 0
        if case let .갈(sym, jung, jong) = rows[1][5] {
            XCTAssertEqual("e", sym)
            XCTAssertEqual("ㅕ", jung)
            XCTAssertEqual("ㅈ", jong)
            tested += 1
        }
        XCTAssertEqual(1, tested)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
}