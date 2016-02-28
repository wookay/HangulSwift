//
//  HangulGalmadlyTests.swift
//  HangulSwift
//
//  Created by wookyoung on 2/28/16.
//  Copyright © 2016 factorcat. All rights reserved.
//

import XCTest

class HangulGalmadlyTests: XCTestCase {
    
    func 중성(sound: String) -> Jamo {
        return Jamo(type: .중, sound: sound)
    }
    
    func 종성(sound: String) -> Jamo {
        return Jamo(type: .종, sound: sound)
    }
    
    func test더() {
        let system = HangulInputSystem()
        system.input(Jamo(type: .초, sound: "ㄷ"))
        system.input(Jamo(type: .갈(중성("ㅓ"), 종성("ㅊ")), sound: ""))
        Assert.equal("더", system.text)
        system.input(BACKSPACE)
        Assert.equal("ㄷ", system.text)
        system.input(BACKSPACE)
        Assert.equal("", system.text)
    }
    
    func test더_ㅓㄷ() {
        let system = HangulInputSystem()
        system.input(Jamo(type: .갈(중성("ㅓ"), 종성("ㅊ")), sound: ""))
        Assert.equal("ㅓ", system.text)
        system.input(Jamo(type: .초, sound: "ㄷ"))
        Assert.equal("더", system.text)
        system.input(BACKSPACE)
        Assert.equal("ㅓ", system.text)
        system.input(BACKSPACE)
        Assert.equal("", system.text)
    }
    
    func test덫() {
        let system = HangulInputSystem()
        system.input(Jamo(type: .초, sound: "ㄷ"))
        system.input(Jamo(type: .중, sound: "ㅓ"))
        system.input(Jamo(type: .갈(중성("ㅓ"), 종성("ㅊ")), sound: ""))
        Assert.equal("덫", system.text)
        system.input(BACKSPACE)
        Assert.equal("더", system.text)
        system.input(BACKSPACE)
        Assert.equal("", system.text) // TODO: 자소단위
    }
    
    func test모() {
        let system = HangulInputSystem()
        system.input(Jamo(type: .초, sound: "ㅁ"))
        system.input(Jamo(type: .모, sound: "ㅗ"))
        Assert.equal("모", system.text)
        system.input(BACKSPACE)
        Assert.equal("ㅁ", system.text)
    }

    func testㅘ_ㅗㅏ() {
        let system = HangulInputSystem()
        system.input(Jamo(type: .모, sound: "ㅗ"))
        Assert.equal("ㅗ", system.text)
        system.input(Jamo(type: .갈(중성("ㅏ"), 종성("ㅍ")), sound: ""))
        Assert.equal("ㅘ", system.text)
        system.input(BACKSPACE)
        Assert.equal("", system.text)
    }

    func testㅘ_ㅏㅗ() {
        let system = HangulInputSystem()
        system.input(Jamo(type: .갈(중성("ㅏ"), 종성("ㅍ")), sound: ""))
        Assert.equal("ㅏ", system.text)
        system.input(Jamo(type: .모, sound: "ㅗ"))
        Assert.equal("ㅘ", system.text)
        system.input(BACKSPACE)
        Assert.equal("", system.text)
    }

    func testㅟ_ㅜㅣ() {
        let system = HangulInputSystem()
        system.input(Jamo(type: .모, sound: "ㅜ"))
        Assert.equal("ㅜ", system.text)
        system.input(Jamo(type: .갈(중성("ㅣ"), 종성("ㅎ")), sound: ""))
        Assert.equal("ㅟ", system.text)
        system.input(BACKSPACE)
        Assert.equal("", system.text)
    }
    
    func testㅟ_ㅣㅜ() {
        let system = HangulInputSystem()
        system.input(Jamo(type: .갈(중성("ㅣ"), 종성("ㅎ")), sound: ""))
        Assert.equal("ㅣ", system.text)
        system.input(Jamo(type: .모, sound: "ㅜ"))
        Assert.equal("ㅟ", system.text)
        system.input(BACKSPACE)
        Assert.equal("", system.text)
    }
    

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
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
