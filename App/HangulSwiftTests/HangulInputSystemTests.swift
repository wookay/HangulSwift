//
//  HangulInputSystemTests.swift
//  HangulSwift
//
//  Created by wookyoung on 2/1/16.
//  Copyright © 2016 factorcat. All rights reserved.
//

import XCTest

class HangulInputSystemTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test감_ㄱㅏㅁ() {
        let system = HangulInputSystem()
        system.input(Jamo(type: .초, sound: "ㄱ"))
        XCTAssertEqual("ㄱ", system.text)
        system.input(Jamo(type: .중, sound: "ㅏ"))
        XCTAssertEqual("가", system.text)
        system.input(Jamo(type: .종, sound: "ㅁ"))
        XCTAssertEqual("감", system.text)
    }
    
    func test감_ㅁㅏㄱ() {
        let system = HangulInputSystem()
        system.input(Jamo(type: .종, sound: "ㅁ"))
        XCTAssertEqual("", system.text)
        system.input(Jamo(type: .중, sound: "ㅏ"))
        XCTAssertEqual("ㅏ", system.text)
        system.input(Jamo(type: .초, sound: "ㄱ"))
        XCTAssertEqual("감", system.text)
    }
    
    func test감_ㅏㅁㄱ() {
        let system = HangulInputSystem()
        system.input(Jamo(type: .중, sound: "ㅏ"))
        XCTAssertEqual("ㅏ", system.text)
        system.input(Jamo(type: .종, sound: "ㅁ"))
        XCTAssertEqual("ㅏ", system.text)
        system.input(Jamo(type: .초, sound: "ㄱ"))
        XCTAssertEqual("감", system.text)
    }
    
    func test과자_ㄱㅗㅏㅈㅏ() {
        let system = HangulInputSystem()
        system.input(Jamo(type: .초, sound: "ㄱ"))
        XCTAssertEqual("ㄱ", system.text)
        system.input(Jamo(type: .중, sound: "ㅗ"))
        XCTAssertEqual("고", system.text)
        system.input(Jamo(type: .중, sound: "ㅏ"))
        XCTAssertEqual("과", system.text)
        system.input(Jamo(type: .초, sound: "ㅈ"))
        XCTAssertEqual("과ㅈ", system.text)
        system.input(Jamo(type: .중, sound: "ㅏ"))
        XCTAssertEqual("과자", system.text)
    }
    
    func test과자_ㅗㅏㄱㅈㅏ() {
        let system = HangulInputSystem()
        system.input(Jamo(type: .중, sound: "ㅗ"))
        XCTAssertEqual("ㅗ", system.text)
        system.input(Jamo(type: .중, sound: "ㅏ"))
        XCTAssertEqual("ㅘ", system.text)
        system.input(Jamo(type: .초, sound: "ㄱ"))
        XCTAssertEqual("과", system.text)
        system.input(Jamo(type: .초, sound: "ㅈ"))
        XCTAssertEqual("과ㅈ", system.text)
        system.input(Jamo(type: .중, sound: "ㅏ"))
        XCTAssertEqual("과자", system.text)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
