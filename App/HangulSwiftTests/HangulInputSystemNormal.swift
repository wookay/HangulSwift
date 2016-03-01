//
//  HangulInputSystemNormal.swift
//  HangulSwift
//
//  Created by wookyoung on 2/1/16.
//  Copyright © 2016 factorcat. All rights reserved.
//

import XCTest

class HangulInputSystemNormal: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test감() {
        let system = HangulInputSystem()
        system.input(Jamo(type: .초, sound: "ㄱ"))
        XCTAssertEqual("ㄱ", system.text)
        system.input("A")
        XCTAssertEqual("ㄱA", system.text)
        system.input(.BACKSPACE)
        XCTAssertEqual("ㄱ", system.text)
        system.input(Jamo(type: .중, sound: "ㅏ"))
        XCTAssertEqual("ㄱㅏ", system.text)
        system.input(Jamo(type: .종, sound: "ㅁ"))
        XCTAssertEqual("ㄱㅏ", system.text)
    }
    
    func test감자() {
        let system = HangulInputSystem()
        system.input(.BACKSPACE)
        system.input(Jamo(type: .초, sound: "ㄱ"))
        XCTAssertEqual("ㄱ", system.text)
        system.input(.BACKSPACE)
        system.input(.BACKSPACE)
        XCTAssertEqual("", system.text)
        system.input(Jamo(type: .중, sound: "ㅏ"))
        XCTAssertEqual("ㅏ", system.text)
        system.input("A")
        XCTAssertEqual("ㅏA", system.text)
        system.input(Jamo(type: .종, sound: "ㅁ"))
        XCTAssertEqual("ㅏA", system.text)
        system.input("B")
        XCTAssertEqual("ㅏAB", system.text)
        system.input(.BACKSPACE)
        XCTAssertEqual("ㅏA", system.text)
        system.input(.BACKSPACE)
        XCTAssertEqual("ㅏ", system.text)
        system.input(Jamo(type: .초, sound: "ㄱ"))
        XCTAssertEqual("ㅏㄱ", system.text)
        system.input(.BACKSPACE)
        XCTAssertEqual("ㅏ", system.text)
        system.input(.BACKSPACE)
        XCTAssertEqual("", system.text)
        system.input(Jamo(type: .종, sound: "ㅁ"))
        XCTAssertEqual("", system.text)
        system.input(Jamo(type: .중, sound: "ㅏ"))
        XCTAssertEqual("ㅏ", system.text)
        system.input(Jamo(type: .초, sound: "ㄱ"))
        XCTAssertEqual("감", system.text)
        system.input(Jamo(type: .초, sound: "ㅈ"))
        XCTAssertEqual("감ㅈ", system.text)
        system.input(Jamo(type: .중, sound: "ㅏ"))
        XCTAssertEqual("감자", system.text)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
