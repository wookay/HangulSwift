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
    
    func 갈마들이(lhs: Jamo, _ rhs: Jamo) -> Jamo {
        return Jamo(type: .갈(lhs, rhs), sound: "")
    }
    
    func 기호(sound: String) -> Jamo {
        return Jamo(type: .Normal, sound: sound)
    }
    
    func test더() {
        let system = HangulInputSystem()
        var d: AutomataDiff

        d = system.input(초성("ㄷ"))
        Assert.equal("ㄷ", system.text)
        Assert.equal("ㄷ", d.change)
        Assert.equal(0, d.n)
        
        d = system.input(갈마들이(중성("ㅓ"), 종성("ㅊ")))
        Assert.equal("더", system.text)
        Assert.equal("더", d.change)
        Assert.equal(-1, d.n)

        d = system.input(.BACKSPACE)
        Assert.equal("ㄷ", system.text)
        Assert.equal("ㄷ", d.change)
        Assert.equal(-1, d.n)
        
        d = system.input(.BACKSPACE)
        
        Assert.equal("", system.text)
        Assert.equal("", d.change)
        Assert.equal(-1, d.n)
    }
    
    func test더_ㅓㄷ() {
        let system = HangulInputSystem()
        var d: AutomataDiff
        
        d = system.input(갈마들이(중성("ㅓ"), 종성("ㅊ")))
        Assert.equal("ㅓ", system.text)
        Assert.equal("ㅓ", d.change)
        Assert.equal(0, d.n)

        d = system.input(초성("ㄷ"))
        Assert.equal("더", system.text)
        Assert.equal("더", d.change)
        Assert.equal(-1, d.n)
        
        d = system.input(.BACKSPACE)
        Assert.equal("ㅓ", system.text)
        Assert.equal("ㅓ", d.change)
        Assert.equal(-1, d.n)
        
        d = system.input(.BACKSPACE)
        Assert.equal("", system.text)
        Assert.equal("", d.change)
        Assert.equal(-1, d.n)
    }

    func test덫() {
        let system = HangulInputSystem()
        var d: AutomataDiff
        
        d = system.input(초성("ㄷ"))
        d = system.input(중성("ㅓ"))
        Assert.equal("더", system.text)
        Assert.equal("더", d.change)
        Assert.equal(-1, d.n)

        d = system.input(갈마들이(중성("ㅓ"), 종성("ㅊ")))
        Assert.equal("덫", system.text)
        Assert.equal("덫", d.change)
        Assert.equal(-1, d.n)
        
        d = system.input(.BACKSPACE)
        Assert.equal("더", system.text)
        Assert.equal("더", d.change)
        Assert.equal(-1, d.n)
        
        d = system.input(.BACKSPACE)
        Assert.equal("", system.text)
        Assert.equal("", d.change)
        Assert.equal(-1, d.n)
        
        d = system.input(.BACKSPACE)
        Assert.equal("", system.text)
        Assert.equal("", d.change)
        Assert.equal(-1, d.n)
    }

    func test모() {
        let system = HangulInputSystem()
        var d: AutomataDiff

        d = system.input(초성("ㅁ"))
        d = system.input(모음("ㅗ"))
        Assert.equal("모", system.text)
        Assert.equal("모", d.change)
        Assert.equal(-1, d.n)
        
        d = system.input(.BACKSPACE)
        Assert.equal("ㅁ", system.text)
        Assert.equal("ㅁ", d.change)
        Assert.equal(-1, d.n)
    }

    func testㅘ_ㅗㅏ() {
        let system = HangulInputSystem()
        var d: AutomataDiff
        
        d = system.input(모음("ㅗ"))
        Assert.equal("ㅗ", system.text)
        Assert.equal("ㅗ", d.change)
        Assert.equal(0, d.n)
        
        d = system.input(갈마들이(중성("ㅏ"), 종성("ㅍ")))
        Assert.equal("ㅘ", system.text)
        Assert.equal("ㅘ", d.change)
        Assert.equal(-1, d.n)
        
        d = system.input(.BACKSPACE)
        Assert.equal("ㅗ", system.text)
        Assert.equal("ㅗ", d.change)
        Assert.equal(-1, d.n)

        d = system.input(.BACKSPACE)
        
        Assert.equal("", system.text)
        Assert.equal("", d.change)
        Assert.equal(-1, d.n)
    }

    func testㅘ_ㅏㅗ() {
        let system = HangulInputSystem()
        var d: AutomataDiff
        
        d = system.input(갈마들이(중성("ㅏ"), 종성("ㅍ")))
        Assert.equal("ㅏ", system.text)
        Assert.equal("ㅏ", d.change)
        Assert.equal(0, d.n)

        d = system.input(모음("ㅗ"))
        Assert.equal("ㅘ", system.text)
        Assert.equal("ㅘ", d.change)
        Assert.equal(-1, d.n)
        
        d = system.input(.BACKSPACE)
        Assert.equal("ㅏ", system.text)
        Assert.equal("ㅏ", d.change)
        Assert.equal(-1, d.n)

        d = system.input(모음("ㅗ"))
        Assert.equal("ㅘ", system.text)
        Assert.equal("ㅘ", d.change)
        Assert.equal(-1, d.n)

        d = system.input(.BACKSPACE)
        Assert.equal("ㅏ", system.text)
        Assert.equal("ㅏ", d.change)
        Assert.equal(-1, d.n)

        d = system.input(.BACKSPACE)
        Assert.equal("", system.text)
        Assert.equal("", d.change)
        Assert.equal(-1, d.n)
    }

    func testㅟ_ㅜㅣ() {
        let system = HangulInputSystem()
        var d: AutomataDiff
        
        d = system.input(모음("ㅜ"))
        Assert.equal("ㅜ", system.text)
        Assert.equal("ㅜ", d.change)
        Assert.equal(0, d.n)
        
        d = system.input(갈마들이(중성("ㅣ"), 종성("ㅎ")))
        Assert.equal("ㅟ", system.text)
        Assert.equal("ㅟ", d.change)
        Assert.equal(-1, d.n)
        
        d = system.input(.BACKSPACE)
        Assert.equal("ㅜ", system.text)
        Assert.equal("ㅜ", d.change)
        Assert.equal(-1, d.n)
        
        d = system.input(.BACKSPACE)
        Assert.equal("", system.text)
        Assert.equal("", d.change)
        Assert.equal(-1, d.n)
        
        d = system.input(.BACKSPACE)
        Assert.equal("", system.text)
        Assert.equal("", d.change)
        Assert.equal(-1, d.n)
    }

    func testㅟ_ㅣㅜ() {
        let system = HangulInputSystem()
        var d: AutomataDiff
        
        d = system.input(갈마들이(중성("ㅣ"), 종성("ㅎ")))
        Assert.equal("ㅣ", system.text)
        Assert.equal("ㅣ", d.change)
        Assert.equal(0, d.n)
        
        d = system.input(Jamo(type: .모, sound: "ㅜ"))
        Assert.equal("ㅟ", system.text)
        Assert.equal("ㅟ", d.change)
        Assert.equal(-1, d.n)

        d = system.input(.BACKSPACE)
        Assert.equal("ㅣ", system.text)
        Assert.equal("ㅣ", d.change)
        Assert.equal(-1, d.n)
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

    func test티ㅋ() {
        let system = HangulInputSystem()
        
        system.input(초성("ㅌ"))
        
        system.input(중성("ㅣ"))
        Assert.equal("티", system.text)
        
        system.input(Jamo(type: .갈(모음("ㅗ"), 초성("ㅋ")), sound: ""))
        Assert.equal("티ㅋ", system.text)
    }

    func test취_ㅊㅜㅣ() {
        let system = HangulInputSystem()
        system.input(Jamo(type: .갈(모음("ㅜ"), 초성("ㅊ")), sound: ""))
        Assert.equal("ㅊ", system.text)
        system.input(Jamo(type: .갈(모음("ㅜ"), 초성("ㅊ")), sound: ""))
        Assert.equal("추", system.text)
        system.input(중성("ㅣ"))
        Assert.equal("취", system.text)
        system.input(Jamo(type: .갈(모음("ㅡ"), 초성("ㅁ")), sound: ""))
        Assert.equal("취ㅁ", system.text)
    }

    func test기ㄱ() {
        let system = HangulInputSystem()
        var d: AutomataDiff
        
        d = system.input(초성("ㄱ"))
        d = system.input(중성("ㅣ"))
        Assert.equal("기", system.text)

        d = system.input(초성("ㄱ"))
        Assert.equal("기ㄱ", system.text)
        Assert.equal("ㄱ", d.change)
        Assert.equal(0, d.n)
    }

    func test치ㅊ() {
        let system = HangulInputSystem()
        var d: AutomataDiff
        
        d = system.input(갈마들이(모음("ㅜ"), 초성("ㅊ")))
        Assert.equal("ㅊ", system.text)
        Assert.equal("ㅊ", d.change)
        Assert.equal(0, d.n)
        
        d = system.input(중성("ㅣ"))
        Assert.equal("치", system.text)
        Assert.equal("치", d.change)
        Assert.equal(-1, d.n)
        
        d = system.input(갈마들이(모음("ㅜ"), 초성("ㅊ")))
        Assert.equal("치ㅊ", system.text)
        Assert.equal("ㅊ", d.change)
        Assert.equal(0, d.n)
        
        system.input(.BACKSPACE)
        Assert.equal("치", system.text)
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
        Assert.equal("으", system.text)
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

    func test토크() {
        let system = HangulInputSystem()
        var d: AutomataDiff
        
        d = system.input(초성("ㅌ"))
        d = system.input(Jamo(type: .갈(모음("ㅗ"), 초성("ㅋ")), sound: ""))
        Assert.equal("토", system.text)
        d = system.input(초성("ㅋ"))
        Assert.equal("토ㅋ", system.text)
        d = system.input(Jamo(type: .갈(모음("ㅡ"), 종성("ㅋ")), sound: ""))
        Assert.equal("토크", system.text)
        Assert.equal("크", d.change)
        Assert.equal(-1, d.n)
    }
    
    func test퇴_ㅌㅗㅣ() {
        let system = HangulInputSystem()
        var d: AutomataDiff

        d = system.input(초성("ㅌ"))
        d = system.input(Jamo(type: .갈(모음("ㅗ"), 초성("ㅋ")), sound: ""))
        Assert.equal("토", system.text)
        d = system.input(Jamo(type: .갈(중성("ㅣ"), 종성("ㅎ")), sound: ""))
        Assert.equal("퇴", system.text)
        d = system.input(종성("ㄴ"))
        Assert.equal("퇸", system.text)
        d = system.input(.BACKSPACE)
        Assert.equal("퇴", system.text)
        d = system.input(Jamo(type: .갈(중성("ㅣ"), 종성("ㄴ")), sound: ""))
        Assert.equal("퇸", system.text)

        d = system.input(Jamo(type: .갈(중성("ㅣ"), 종성("ㄴ")), sound: ""))
        Assert.equal("퇸ㅣ", system.text)
        Assert.equal("ㅣ", d.change)
        Assert.equal(0, d.n)

    }
    
    func test퇴_ㅗㅌㅣ() {
        let system = HangulInputSystem()
        var d: AutomataDiff
        
        d = system.input(모음("ㅗ"))
        Assert.equal("ㅗ", system.text)
        Assert.equal("ㅗ", d.change)
        Assert.equal(0, d.n)
        
        d = system.input(초성("ㅌ"))
        Assert.equal("토", system.text)
        Assert.equal("토", d.change)
        Assert.equal(-1, d.n)

        d = system.input(Jamo(type: .갈(중성("ㅣ"), 종성("ㅎ")), sound: ""))
        Assert.equal("퇴", system.text)
        Assert.equal("퇴", d.change)
        Assert.equal(-1, d.n)
        
        d = system.input(종성("ㄴ"))
        Assert.equal("퇸", system.text)
        Assert.equal("퇸", d.change)
        Assert.equal(-1, d.n)
        
        d = system.input(.BACKSPACE)
        Assert.equal("퇴", system.text)
        Assert.equal("퇴", d.change)
        Assert.equal(-1, d.n)

        d = system.input(Jamo(type: .갈(중성("ㅣ"), 종성("ㄴ")), sound: ""))
        Assert.equal("퇸", system.text)
        
        d = system.input(.BACKSPACE)
        Assert.equal("퇴", system.text)
        
        d = system.input(종성("ㄴ"))
        Assert.equal("퇸", system.text)
    }

    func test최_ㅊㅗㅣ() {
        let system = HangulInputSystem()
        var d: AutomataDiff
        
        d = system.input(초성("ㅊ"))
        Assert.equal("ㅊ", system.text)
        Assert.equal(0, d.n)
        
        d = system.input(모음("ㅗ"))
        Assert.equal("초", system.text)
        
        d = system.input(Jamo(type: .갈(중성("ㅣ"), 종성("ㅇ")), sound: ""))
        Assert.equal("최", system.text)
        
        d = system.input(.BACKSPACE)
        Assert.equal("초", system.text)

        d = system.input(Jamo(type: .갈(중성("ㅣ"), 종성("ㅇ")), sound: ""))
        Assert.equal("최", system.text)
    }

    func test총_ㅊㅗㅇ() {
        let system = HangulInputSystem()
        var d: AutomataDiff
        
        d = system.input(초성("ㅊ"))
        Assert.equal("ㅊ", system.text)
        Assert.equal(0, d.n)
        
        d = system.input(중성("ㅗ"))
        Assert.equal("초", system.text)
        
        d = system.input(Jamo(type: .갈(중성("ㅣ"), 종성("ㅇ")), sound: ""))
        Assert.equal("총", system.text)
    }

    func test총_ㅇㅊㅗ() {
        let system = HangulInputSystem()
        var d: AutomataDiff
        
        d = system.input(종성("ㅇ"))
        Assert.equal("", system.text)
        Assert.equal(0, d.n)
        
        d = system.input(초성("ㅊ"))
        Assert.equal("ㅊ", system.text)
        Assert.equal(0, d.n)

        d = system.input(중성("ㅗ"))
        Assert.equal("총", system.text)
        
        d = system.input(.BACKSPACE)
        Assert.equal("ㅊ", system.text)

        d = system.input(갈마들이(중성("ㅗ"), 종성("ㅇ")))
        Assert.equal("총", system.text)
        
        d = system.input(.BACKSPACE)
        Assert.equal("ㅊ", system.text)
        
        d = system.input(갈마들이(중성("ㅗ"), 종성("ㅇ")))
        Assert.equal("총", system.text)
    }

    func testㄱ() {
        let system = HangulInputSystem()
        var d: AutomataDiff
        
        d = system.input(초성("ㄱ"))
        Assert.equal("ㄱ", system.text)
        Assert.equal("ㄱ", d.change)
        Assert.equal(0, d.n)
        
        d = system.input(.BACKSPACE)
        Assert.equal("", system.text)
        
        d = system.input(초성("ㄱ"))
        Assert.equal("ㄱ", system.text)
        Assert.equal("ㄱ", d.change)
        Assert.equal(0, d.n)
    }

    func testㅃㅂ_ㅂㅂㅂ() {
        let system = HangulInputSystem()
        var d: AutomataDiff
        
        d = system.input(초성("ㅂ"))
        Assert.equal("ㅂ", system.text)
        Assert.equal("ㅂ", d.change)
        Assert.equal(0, d.n)
        
        d = system.input(초성("ㅂ"))
        Assert.equal("ㅃ", system.text)
        Assert.equal("ㅃ", d.change)
        Assert.equal(-1, d.n)
        
        d = system.input(초성("ㅂ"))
        Assert.equal("ㅃㅂ", system.text)
        Assert.equal("ㅂ", d.change)
        Assert.equal(0, d.n)
    }
    
    func testㅂ_() {
        let system = HangulInputSystem()
        var d: AutomataDiff
        
        d = system.input(초성("ㅂ"))
        Assert.equal("ㅂ", system.text)
        Assert.equal("ㅂ", d.change)
        Assert.equal(0, d.n)
        
        d = system.input(기호(" "))
        Assert.equal("ㅂ ", system.text)
        Assert.equal(" ", d.change)
        Assert.equal(0, d.n)
        
        d = system.input(기호(" "))
        Assert.equal("ㅂ  ", system.text)
        Assert.equal(" ", d.change)
        Assert.equal(0, d.n)
    }
    
    func test바_바() {
        let system = HangulInputSystem()
        var d: AutomataDiff
        
        d = system.input(초성("ㅂ"))
        Assert.equal("ㅂ", system.text)
        
        d = system.input(갈마들이(중성("ㅏ"), 종성("ㅇ")))
        Assert.equal("바", system.text)
        
        d = system.input(기호(" "))
        Assert.equal("바 ", system.text)
        
        d = system.input(초성("ㅂ"))
        Assert.equal("바 ㅂ", system.text)
        
        d = system.input(갈마들이(중성("ㅏ"), 종성("ㅇ")))
        Assert.equal("바 바", system.text)
        Assert.equal("바", d.change)
        Assert.equal(-1, d.n)
        
        d = system.input(.BACKSPACE)
        Assert.equal("바 ㅂ", system.text)
        Assert.equal("ㅂ", d.change)
        Assert.equal(-1, d.n)
        
        d = system.input(갈마들이(중성("ㅏ"), 초성("ㅋ")))
        Assert.equal("바 바", system.text)
        Assert.equal("바", d.change)
        Assert.equal(-1, d.n)
    }

    func test간결() {
        let system = HangulInputSystem()
        var d: AutomataDiff
        
        d = system.input(초성("ㄱ"))
        Assert.equal("ㄱ", system.text)
        
        d = system.input(중성("ㅏ"))
        Assert.equal("가", system.text)

        d = system.input(갈마들이(모음("ㅜ"), 종성("ㄴ")))
        Assert.equal("간", system.text)
        
        d = system.input(초성("ㄱ"))
        Assert.equal("간ㄱ", system.text)
        
        d = system.input(중성("ㅕ"))
        Assert.equal("간겨", system.text)
        
        d = system.input(갈마들이(모음("ㅜ"), 종성("ㄹ")))
        Assert.equal("간결", system.text)
        Assert.equal("결", d.change)
        Assert.equal(-1, d.n)
    }
    
    func test실() {
        let system = HangulInputSystem()
        var d: AutomataDiff
        
        d = system.input(초성("ㅅ"))
        Assert.equal("ㅅ", system.text)
        
        d = system.input(중성("ㅣ"))
        Assert.equal("시", system.text)
        
        d = system.input(종성("ㄹ"))
        Assert.equal("실", system.text)
        
        d = system.input(종성("ㅁ"))
        Assert.equal("싦", system.text)
        
        d = system.input(종성("ㄹ"))
        Assert.equal("싦", system.text)
        Assert.equal("", d.change)
        Assert.equal(0, d.n)
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
