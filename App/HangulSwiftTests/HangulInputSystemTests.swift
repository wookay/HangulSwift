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
    
    func test감자_BACKSPACE() {
        let system = HangulInputSystem()
        system.input(BACKSPACE)
        system.input(Jamo(type: .초, sound: "ㄱ"))
        XCTAssertEqual("ㄱ", system.text)
        system.input(BACKSPACE)
        system.input(BACKSPACE)
        XCTAssertEqual("", system.text)
        system.input(Jamo(type: .중, sound: "ㅏ"))
        XCTAssertEqual("ㅏ", system.text)
        system.input(Jamo(type: .종, sound: "ㅁ"))
        XCTAssertEqual("ㅏ", system.text)
        system.input(Jamo(type: .초, sound: "ㄱ"))
        XCTAssertEqual("감", system.text)
        system.input(Jamo(type: .초, sound: "ㅈ"))
        XCTAssertEqual("감ㅈ", system.text)
        system.input(Jamo(type: .중, sound: "ㅏ"))
        XCTAssertEqual("감자", system.text)
    }

    func testㅂㅇㅏ() {
        var system = HangulInputSystem()
        system.input(Jamo(type: .초, sound: "ㅂ"))
        XCTAssertEqual("ㅂ", system.text)
        system.input(Jamo(type: .종, sound: "ㅇ"))
        XCTAssertEqual("ㅂ", system.text)
        system.input(Jamo(type: .중, sound: "ㅏ"))
        XCTAssertEqual("방", system.text)
        
        system = HangulInputSystem()
        system.input(Jamo(type: .종, sound: "ㅇ"))
        XCTAssertEqual("", system.text)
        system.input(Jamo(type: .초, sound: "ㅂ"))
        XCTAssertEqual("ㅂ", system.text)
        system.input(Jamo(type: .중, sound: "ㅏ"))
        XCTAssertEqual("방", system.text)
    }
    
    func test녕ㅎ() {
        let system = HangulInputSystem()
        system.input(Jamo(type: .초, sound: "ㄴ"))
        XCTAssertEqual("ㄴ", system.text)
        system.input(Jamo(type: .중, sound: "ㅕ"))
        XCTAssertEqual("녀", system.text)
        system.input(Jamo(type: .종, sound: "ㅇ"))
        XCTAssertEqual("녕", system.text)
        system.input(Jamo(type: .초, sound: "ㅎ"))
        XCTAssertEqual("녕ㅎ", system.text)
    }

    func test돎가_ㄷㅗㄹㅁㄱㅏ() {
        let system = HangulInputSystem()
        system.input(Jamo(type: .초, sound: "ㄷ"))
        XCTAssertEqual("ㄷ", system.text)
        system.input(Jamo(type: .중, sound: "ㅗ"))
        XCTAssertEqual("도", system.text)
        system.input(Jamo(type: .종, sound: "ㄹ"))
        XCTAssertEqual("돌", system.text)
        system.input(Jamo(type: .종, sound: "ㅁ"))
        XCTAssertEqual("돎", system.text)
        system.input(Jamo(type: .초, sound: "ㄱ"))
        XCTAssertEqual("돎ㄱ", system.text)
        system.input(Jamo(type: .중, sound: "ㅏ"))
        XCTAssertEqual("돎가", system.text)
    }
    
    func test돎가_ㄷㅗㄹㄱㅁㅏ() {
        let system = HangulInputSystem()
        system.input(Jamo(type: .초, sound: "ㄷ"))
        XCTAssertEqual("ㄷ", system.text)
        system.input(Jamo(type: .중, sound: "ㅗ"))
        XCTAssertEqual("도", system.text)
        system.input(Jamo(type: .종, sound: "ㄹ"))
        XCTAssertEqual("돌", system.text)
        system.input(Jamo(type: .초, sound: "ㄱ"))
        XCTAssertEqual("돌ㄱ", system.text)
        system.input(Jamo(type: .종, sound: "ㅁ"))
        XCTAssertEqual("돌ㄱ", system.text)
        system.input(Jamo(type: .중, sound: "ㅏ"))
        XCTAssertEqual("돌감", system.text)
    }
    
    func test돌감_ㄷㅗㄹㅏㅁㄱ() {
        let system = HangulInputSystem()
        system.input(Jamo(type: .초, sound: "ㄷ"))
        XCTAssertEqual("ㄷ", system.text)
        system.input(Jamo(type: .중, sound: "ㅗ"))
        XCTAssertEqual("도", system.text)
        system.input(Jamo(type: .종, sound: "ㄹ"))
        XCTAssertEqual("돌", system.text)
        system.input(Jamo(type: .중, sound: "ㅏ"))
        XCTAssertEqual("돌ㅏ", system.text)
        system.input(Jamo(type: .종, sound: "ㅁ"))
        XCTAssertEqual("돌ㅏ", system.text)
        system.input(Jamo(type: .초, sound: "ㄱ"))
        XCTAssertEqual("돌감", system.text)
    }
    
    func test돌감_ㄷㅗㄹㄱㅏㅁ() {
        let system = HangulInputSystem()
        system.input(Jamo(type: .초, sound: "ㄷ"))
        XCTAssertEqual("ㄷ", system.text)
        system.input(Jamo(type: .중, sound: "ㅗ"))
        XCTAssertEqual("도", system.text)
        system.input(Jamo(type: .종, sound: "ㄹ"))
        XCTAssertEqual("돌", system.text)
        system.input(Jamo(type: .초, sound: "ㄱ"))
        XCTAssertEqual("돌ㄱ", system.text)
        system.input(Jamo(type: .중, sound: "ㅏ"))
        XCTAssertEqual("돌가", system.text)
        system.input(Jamo(type: .종, sound: "ㅁ"))
        XCTAssertEqual("돌감", system.text)
    }
    
    func test다다_ㄷㅏㄷㅏ() {
        let system = HangulInputSystem()
        system.input(Jamo(type: .초, sound: "ㄷ"))
        XCTAssertEqual("ㄷ", system.text)
        system.input(Jamo(type: .중, sound: "ㅏ"))
        XCTAssertEqual("다", system.text)
        system.input(Jamo(type: .초, sound: "ㄷ"))
        XCTAssertEqual("다ㄷ", system.text)
        system.input(Jamo(type: .중, sound: "ㅏ"))
        XCTAssertEqual("다다", system.text)
    }
    
    func test많() {
        let system = HangulInputSystem()
        system.input(Jamo(type: .초, sound: "ㅁ"))
        XCTAssertEqual("ㅁ", system.text)
        system.input(Jamo(type: .중, sound: "ㅏ"))
        XCTAssertEqual("마", system.text)
        system.input(Jamo(type: .종, sound: "ㄶ"))
        XCTAssertEqual("많", system.text)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
