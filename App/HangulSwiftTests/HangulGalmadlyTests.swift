//
//  HangulGalmadlyTests.swift
//  HangulSwift
//
//  Created by wookyoung on 2/28/16.
//  Copyright © 2016 factorcat. All rights reserved.
//

//import XCTest

class HangulGalmadlyTests: WTestCase {

    func 초성(sound: String) -> Jamo {
        return Jamo(type: .초, sound: sound)
    }

    func 중성(sound: String) -> Jamo {
        return Jamo(type: .중, sound: sound)
    }
    
    func 종성(sound: String) -> Jamo {
        return Jamo(type: .종, sound: sound)
    }
    
    func 모음(sound: String) -> Jamo {
        return Jamo(type: .모, sound: sound)
    }
    
    func test더() {
        let system = HangulInputSystem()
        system.input(Jamo(type: .초, sound: "ㄷ"))
        system.input(Jamo(type: .갈(중성("ㅓ"), 종성("ㅊ")), sound: ""))
        Assert.equal("더", system.text)
        system.input(.BACKSPACE)
        Assert.equal("ㄷ", system.text)
        system.input(.BACKSPACE)
        Assert.equal("", system.text)
    }
    
    func test더_ㅓㄷ() {
        let system = HangulInputSystem()
        system.input(Jamo(type: .갈(중성("ㅓ"), 종성("ㅊ")), sound: ""))
        Assert.equal("ㅓ", system.text)
        system.input(Jamo(type: .초, sound: "ㄷ"))
        Assert.equal("더", system.text)
        system.input(.BACKSPACE)
        Assert.equal("ㅓ", system.text)
        system.input(.BACKSPACE)
        Assert.equal("", system.text)
    }
    
    func test덫() {
        let system = HangulInputSystem()
        system.input(Jamo(type: .초, sound: "ㄷ"))
        system.input(Jamo(type: .중, sound: "ㅓ"))
        system.input(Jamo(type: .갈(중성("ㅓ"), 종성("ㅊ")), sound: ""))
        Assert.equal("덫", system.text)
        system.input(.BACKSPACE)
        Assert.equal("더", system.text)
        system.input(.BACKSPACE)
        Assert.equal("", system.text) // TODO: 자소단위
    }
    
    func test모() {
        let system = HangulInputSystem()
        system.input(Jamo(type: .초, sound: "ㅁ"))
        system.input(Jamo(type: .모, sound: "ㅗ"))
        Assert.equal("모", system.text)
        system.input(.BACKSPACE)
        Assert.equal("ㅁ", system.text)
    }

    func testㅘ_ㅗㅏ() {
        let system = HangulInputSystem()
        system.input(Jamo(type: .모, sound: "ㅗ"))
        Assert.equal("ㅗ", system.text)
        system.input(Jamo(type: .갈(중성("ㅏ"), 종성("ㅍ")), sound: ""))
        Assert.equal("ㅘ", system.text)
        system.input(.BACKSPACE)
        Assert.equal("", system.text) // 자소 단위?
    }

    func testㅘ_ㅏㅗ() {
        let system = HangulInputSystem()
        system.input(Jamo(type: .갈(중성("ㅏ"), 종성("ㅍ")), sound: ""))
        Assert.equal("ㅏ", system.text)
        system.input(Jamo(type: .모, sound: "ㅗ"))
        Assert.equal("ㅘ", system.text)
        system.input(.BACKSPACE)
        Assert.equal("", system.text) // 자소 단위?
    }

    func testㅟ_ㅜㅣ() {
        let system = HangulInputSystem()
        system.input(Jamo(type: .모, sound: "ㅜ"))
        Assert.equal("ㅜ", system.text)
        system.input(Jamo(type: .갈(중성("ㅣ"), 종성("ㅎ")), sound: ""))
        Assert.equal("ㅟ", system.text)
        system.input(.BACKSPACE)
        Assert.equal("", system.text)
    }
    
    func testㅟ_ㅣㅜ() {
        let system = HangulInputSystem()
        system.input(Jamo(type: .갈(중성("ㅣ"), 종성("ㅎ")), sound: ""))
        Assert.equal("ㅣ", system.text)
        system.input(Jamo(type: .모, sound: "ㅜ"))
        Assert.equal("ㅟ", system.text)
        system.input(.BACKSPACE)
        Assert.equal("", system.text) // 자소 단위?
    }

    func test_ㅣ() {
        let system = HangulInputSystem()
        system.input(" ")
        Assert.equal(" ", system.text)
        system.input(Jamo(type: .갈(중성("ㅣ"), 종성("ㅎ")), sound: ""))
        Assert.equal(" ㅣ", system.text)
    }

    func test코() {
        let system = HangulInputSystem()
        system.input(Jamo(type: .갈(중성("ㅗ"), 초성("ㅋ")), sound: ""))
        Assert.equal("ㅋ", system.text)
        system.input(Jamo(type: .갈(중성("ㅗ"), 초성("ㅋ")), sound: ""))
        Assert.equal("코", system.text)
        system.input(.BACKSPACE)
        Assert.equal("ㅋ", system.text)
    }

    func test취_ㅊㅜㅣ() {
        let system = HangulInputSystem()
        system.input(Jamo(type: .갈(모음("ㅜ"), 초성("ㅊ")), sound: ""))
        Assert.equal("ㅊ", system.text)
        system.input(Jamo(type: .갈(모음("ㅜ"), 초성("ㅊ")), sound: ""))
        Assert.equal("추", system.text)
        system.input(중성("ㅣ"))
        Assert.equal("취", system.text)
    }

    func test취_ㅊㅣㅜ() {
        let system = HangulInputSystem()
        system.input(Jamo(type: .갈(모음("ㅜ"), 초성("ㅊ")), sound: ""))
        Assert.equal("ㅊ", system.text)
        system.input(중성("ㅣ"))
        Assert.equal("치", system.text)
        system.input(Jamo(type: .갈(모음("ㅜ"), 초성("ㅊ")), sound: ""))
        Assert.equal("취", system.text)
        system.input(.BACKSPACE)
        Assert.equal("ㅊ", system.text) // 자소 단위?
    }
    
    func test의_ㅇㅡㅣ() {
        let system = HangulInputSystem()
        system.input(초성("ㅇ"))
        Assert.equal("ㅇ", system.text)
        system.input(Jamo(type: .갈(모음("ㅡ"), 초성("ㅁ")), sound: ""))
        Assert.equal("으", system.text)
        system.input(중성("ㅣ"))
        Assert.equal("의", system.text)
        system.input(.BACKSPACE)
        Assert.equal("ㅇ", system.text)  // 자소 단위?
    }

    func test_unicodeScalars() {
        // 한글 호환 자모 영역
        Assert.equal(["\u{3139}"], "ㄹ".unicodeScalars.map { x in x })
        Assert.equal(["\u{3139}", "\u{119E}"], "ㄹᆞ".unicodeScalars.map { x in x })
        
        // 한글 자모 영역
        Assert.equal(["\u{1105}"], "ᄅ".unicodeScalars.map { x in x })
        Assert.equal(["\u{1105}", "\u{119E}"], "ᄅᆞ".unicodeScalars.map { x in x })

        Assert.equal(["\u{1105}", "\u{119E}", "\u{11B7}"], "ᄅᆞᆷ".unicodeScalars.map { x in x })
        
        // 받침
        Assert.equal(["\u{11AF}"], "ᆯ".unicodeScalars.map { x in x })
        Assert.equal(["\u{11B7}"], "ᆷ".unicodeScalars.map { x in x })
    }

    func testᄅᆞ_ㄹㆍ() {
        let system = HangulInputSystem()
        system.input(초성("ㄹ"))
        Assert.equal("ㄹ", system.text)
        system.input(Jamo(type: .갈(모음("ㆍ"), 초성("ㅍ")), sound: ""))
        Assert.equal("\u{1105}" + "\u{119E}", system.text)
        system.input(종성("ㅁ"))
        Assert.equal("\u{1105}" + "\u{119E}" + "\u{11B7}", system.text)
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
