//
//  HangulGalmadlyTests.swift
//  HangulSwift
//
//  Created by wookyoung on 2/28/16.
//  Copyright © 2016 factorcat. All rights reserved.
//

class HangulGalmadlyTests: WHangulTestCase {

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
        
        d = system.input(모음("ㅜ"))
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
        system.input(갈마들이(중성("ㅣ"), 종성("ㅎ")))
        Assert.equal(" ㅣ", system.text)
    }

    func test코() {
        let system = HangulInputSystem()
        system.input(갈마들이(중성("ㅗ"), 초성("ㅋ")))
        
        Assert.equal("ㅋ", system.text)
        system.input(갈마들이(중성("ㅗ"), 초성("ㅋ")))
        Assert.equal("코", system.text)
        system.input(.BACKSPACE)
        Assert.equal("ㅋ", system.text)
    }

    func test티ㅋ() {
        let system = HangulInputSystem()
        
        system.input(초성("ㅌ"))
        
        system.input(중성("ㅣ"))
        Assert.equal("티", system.text)
        
        system.input(갈마들이(모음("ㅗ"), 초성("ㅋ")))
        Assert.equal("티ㅋ", system.text)
    }

    func test취_ㅊㅜㅣ() {
        let system = HangulInputSystem()
        system.input(갈마들이(모음("ㅜ"), 초성("ㅊ")))
        Assert.equal("ㅊ", system.text)
        system.input(갈마들이(모음("ㅜ"), 초성("ㅊ")))
        Assert.equal("추", system.text)
        system.input(중성("ㅣ"))
        Assert.equal("취", system.text)
        system.input(갈마들이(모음("ㅡ"), 초성("ㅁ")))
        Assert.equal("취ㅁ", system.text)
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
        system.input(갈마들이(모음("ㅡ"), 초성("ㅁ")))
        Assert.equal("으", system.text)
        system.input(중성("ㅣ"))
        Assert.equal("의", system.text)
        system.input(.BACKSPACE)
        Assert.equal("으", system.text)
    }

    func test갈마들이() {
        let gal = 갈마들이(모음("ㅡ"), 종성("ㅋ"))
        var cnt = 0
        if case let .갈(lhs, rhs) = gal.type {
            Assert.equal(모음("ㅡ"), lhs)
            Assert.equal(종성("ㅋ"), rhs)
            cnt += 1
        }
        Assert.equal(1, cnt)
    }
    
    func test토크() {
        let system = HangulInputSystem()
        var d: AutomataDiff
        
        d = system.input(초성("ㅌ"))
        d = system.input(갈마들이(모음("ㅗ"), 초성("ㅋ")))
        Assert.equal("토", system.text)
        d = system.input(초성("ㅋ"))
        Assert.equal("토ㅋ", system.text)
        
        d = system.input(갈마들이(모음("ㅡ"), 종성("ㅋ")))
        Assert.equal("토크", system.text)
        Assert.equal("크", d.change)
        Assert.equal(-1, d.n)
    }
    
    func test퇴_ㅌㅗㅣ() {
        let system = HangulInputSystem()
        var d: AutomataDiff

        d = system.input(초성("ㅌ"))
        d = system.input(갈마들이(모음("ㅗ"), 초성("ㅋ")))
        Assert.equal("토", system.text)
        d = system.input(갈마들이(중성("ㅣ"), 종성("ㅎ")))
        Assert.equal("퇴", system.text)
        d = system.input(종성("ㄴ"))
        Assert.equal("퇸", system.text)
        d = system.input(.BACKSPACE)
        Assert.equal("퇴", system.text)
        d = system.input(갈마들이(중성("ㅣ"), 종성("ㄴ")))
        Assert.equal("퇸", system.text)

        d = system.input(갈마들이(중성("ㅣ"), 종성("ㄴ")))
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

        d = system.input(갈마들이(중성("ㅣ"), 종성("ㅎ")))
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

        d = system.input(갈마들이(중성("ㅣ"), 종성("ㄴ")))
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
        
        d = system.input(갈마들이(중성("ㅣ"), 종성("ㅇ")))
        Assert.equal("최", system.text)
        
        d = system.input(.BACKSPACE)
        Assert.equal("초", system.text)

        d = system.input(갈마들이(중성("ㅣ"), 종성("ㅇ")))
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
        
        d = system.input(갈마들이(중성("ㅣ"), 종성("ㅇ")))
        Assert.equal("총", system.text)
    }

    func test총_ㅇㅊㅗ() {
        let system = HangulInputSystem()
        var d: AutomataDiff
        
        d = system.input(종성("ㅇ"))
        Assert.equal("ᅟᅠᆼ", system.text)
        Assert.equal(0, d.n)
        
        d = system.input(초성("ㅊ"))
        Assert.equal("ᄎᅠᆼ", system.text)
        Assert.equal(-1, d.n)

        d = system.input(중성("ㅗ"))
        Assert.equal("총", system.text)
        
        d = system.input(.BACKSPACE)
        Assert.equal("ᄎᅠᆼ", system.text)

        d = system.input(갈마들이(중성("ㅗ"), 종성("ㅇ")))
        Assert.equal("총", system.text)
        
        d = system.input(.BACKSPACE)
        Assert.equal("ᄎᅠᆼ", system.text)
        
        d = system.input(갈마들이(중성("ㅗ"), 종성("ㅇ")))
        Assert.equal("총", system.text)
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

    func testᄅᆞ_ㄹㆍ() {
        let system = HangulInputSystem()
        system.input(초성("ㄹ"))
        Assert.equal("ㄹ", system.text)
        system.input(갈마들이(모음("ㆍ"), 초성("ㅍ")))
        Assert.equal("\u{1105}" + "\u{119E}", system.text)
        system.input(종성("ㅁ"))
        Assert.equal("\u{1105}" + "\u{119E}" + "\u{11B7}", system.text)
    }

}