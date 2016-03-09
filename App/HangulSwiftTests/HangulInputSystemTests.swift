//
//  HangulInputSystemTests.swift
//  HangulSwift
//
//  Created by wookyoung on 2/1/16.
//  Copyright © 2016 factorcat. All rights reserved.
//

//import XCTest

class HangulInputSystemTests: WTestCase {

    func test감_ㄱㅏㅁ() {
        let system = HangulInputSystem()
        system.input(초성("ㄱ"))
        Assert.equal("ㄱ", system.text)
        system.input(중성("ㅏ"))
        Assert.equal("가", system.text)
        system.input(종성("ㅁ"))
        Assert.equal("감", system.text)
    }
    
    func test감_ㅁㅏㄱ() {
        let system = HangulInputSystem()
        system.input(종성("ㅁ"))
        Assert.equal("ᅠᆷ", system.text)
        system.input(중성("ㅏ"))
        Assert.equal("ᅡᆷ", system.text)
        system.input(초성("ㄱ"))
        Assert.equal("감", system.text)
    }
    
    func test감_ㅏㅁㄱ() {
        let system = HangulInputSystem()
        system.input(중성("ㅏ"))
        Assert.equal("ㅏ", system.text)
        system.input(종성("ㅁ"))
        Assert.equal("ᅡᆷ", system.text)
        system.input(초성("ㄱ"))
        Assert.equal("감", system.text)
    }
    
    func test과자_ㄱㅗㅏㅈㅏ() {
        let system = HangulInputSystem()
        system.input(초성("ㄱ"))
        Assert.equal("ㄱ", system.text)
        system.input(중성("ㅗ"))
        Assert.equal("고", system.text)
        system.input(중성("ㅏ"))
        Assert.equal("과", system.text)
        system.input(초성("ㅈ"))
        Assert.equal("과ㅈ", system.text)
        system.input(중성("ㅏ"))
        Assert.equal("과자", system.text)
    }
    
    func test과자_ㅗㅏㄱㅈㅏ() {
        let system = HangulInputSystem()
        system.input(중성("ㅗ"))
        Assert.equal("ㅗ", system.text)
        system.input(중성("ㅏ"))
        Assert.equal("ㅘ", system.text)
        system.input(초성("ㄱ"))
        Assert.equal("과", system.text)
        system.input(초성("ㅈ"))
        Assert.equal("과ㅈ", system.text)
        system.input(중성("ㅏ"))
        Assert.equal("과자", system.text)
    }
    
    func test감자_BACKSPACE() {
        let system = HangulInputSystem()
        system.input(.BACKSPACE)
        system.input(초성("ㄱ"))
        Assert.equal("ㄱ", system.text)
        system.input(.BACKSPACE)
        system.input(.BACKSPACE)
        Assert.equal("", system.text)
        system.input(중성("ㅏ"))
        Assert.equal("ㅏ", system.text)
        system.input(종성("ㅁ"))
        Assert.equal("ᅡᆷ", system.text)
        system.input(초성("ㄱ"))
        Assert.equal("감", system.text)
        system.input(초성("ㅈ"))
        Assert.equal("감ㅈ", system.text)
        system.input(중성("ㅏ"))
        Assert.equal("감자", system.text)
    }

    func testㅂㅇㅏ() {
        var system = HangulInputSystem()
        system.input(초성("ㅂ"))
        Assert.equal("ㅂ", system.text)
        system.input(종성("ㅇ"))
        Assert.equal("ᄇᅠᆼ", system.text) // ㅂㅇ
        system.input(중성("ㅏ"))
        Assert.equal("방", system.text)
        
        system = HangulInputSystem()
        system.input(종성("ㅇ"))
        Assert.equal("ᅠᆼ", system.text)
        system.input(초성("ㅂ"))
        Assert.equal("ᄇᅠᆼ", system.text)
        system.input(중성("ㅏ"))
        Assert.equal("방", system.text)
    }
    
    func test녕ㅎ() {
        let system = HangulInputSystem()
        system.input(초성("ㄴ"))
        Assert.equal("ㄴ", system.text)
        system.input(중성("ㅕ"))
        Assert.equal("녀", system.text)
        system.input(종성("ㅇ"))
        Assert.equal("녕", system.text)
        system.input(초성("ㅎ"))
        Assert.equal("녕ㅎ", system.text)
    }

    func test돎가_ㄷㅗㄹㅁㄱㅏ() {
        let system = HangulInputSystem()
        system.input(초성("ㄷ"))
        Assert.equal("ㄷ", system.text)
        system.input(중성("ㅗ"))
        Assert.equal("도", system.text)
        system.input(종성("ㄹ"))
        Assert.equal("돌", system.text)
        system.input(종성("ㅁ"))
        Assert.equal("돎", system.text)
        system.input(초성("ㄱ"))
        Assert.equal("돎ㄱ", system.text)
        system.input(중성("ㅏ"))
        Assert.equal("돎가", system.text)
    }
    
    func test돎가_ㄷㅗㄹㄱㅁㅏ() {
        let system = HangulInputSystem()
        system.input(초성("ㄷ"))
        Assert.equal("ㄷ", system.text)
        system.input(중성("ㅗ"))
        Assert.equal("도", system.text)
        system.input(종성("ㄹ"))
        Assert.equal("돌", system.text)
        system.input(초성("ㄱ"))
        Assert.equal("돌ㄱ", system.text)
        system.input(종성("ㅁ"))
        Assert.equal("돌ᄀᅠᆷ", system.text)
        system.input(중성("ㅏ"))
        Assert.equal("돌감", system.text)
    }
    
    func test돌감_ㄷㅗㄹㅏㅁㄱ() {
        let system = HangulInputSystem()
        system.input(초성("ㄷ"))
        Assert.equal("ㄷ", system.text)
        system.input(중성("ㅗ"))
        Assert.equal("도", system.text)
        system.input(종성("ㄹ"))
        Assert.equal("돌", system.text)
        system.input(중성("ㅏ"))
        Assert.equal("돌ㅏ", system.text)
        system.input(종성("ㅁ"))
        Assert.equal("돌ᅡᆷ", system.text)
        system.input(초성("ㄱ"))
        Assert.equal("돌감", system.text)
    }
    
    func test돌감_ㄷㅗㄹㄱㅏㅁ() {
        let system = HangulInputSystem()
        system.input(초성("ㄷ"))
        Assert.equal("ㄷ", system.text)
        system.input(중성("ㅗ"))
        Assert.equal("도", system.text)
        system.input(종성("ㄹ"))
        Assert.equal("돌", system.text)
        system.input(초성("ㄱ"))
        Assert.equal("돌ㄱ", system.text)
        system.input(중성("ㅏ"))
        Assert.equal("돌가", system.text)
        system.input(종성("ㅁ"))
        Assert.equal("돌감", system.text)
    }
    
    func test다다_ㄷㅏㄷㅏ() {
        let system = HangulInputSystem()
        system.input(초성("ㄷ"))
        Assert.equal("ㄷ", system.text)
        system.input(중성("ㅏ"))
        Assert.equal("다", system.text)
        system.input(초성("ㄷ"))
        Assert.equal("다ㄷ", system.text)
        system.input(중성("ㅏ"))
        Assert.equal("다다", system.text)
    }
    
    func test많() {
        let system = HangulInputSystem()
        system.input(초성("ㅁ"))
        Assert.equal("ㅁ", system.text)
        system.input(중성("ㅏ"))
        Assert.equal("마", system.text)
        system.input(종성("ㄶ"))
        Assert.equal("많", system.text)
    }
    
    func test감() {
        let system = HangulInputSystem()
        system.input(초성("ㄱ"))
        Assert.equal("ㄱ", system.text)
        system.input("A")
        Assert.equal("ㄱA", system.text)
        system.input(.BACKSPACE)
        Assert.equal("ㄱ", system.text)
        system.input(중성("ㅏ"))
        Assert.equal("ㄱㅏ", system.text)
        system.input(종성("ㅁ"))
        Assert.equal("ㄱᅡᆷ", system.text)
    }
    
    func test감자() {
        let system = HangulInputSystem()
        system.input(.BACKSPACE)
        system.input(초성("ㄱ"))
        Assert.equal("ㄱ", system.text)
        system.input(.BACKSPACE)
        system.input(.BACKSPACE)
        Assert.equal("", system.text)
        system.input(중성("ㅏ"))
        Assert.equal("ㅏ", system.text)
        system.input("A")
        Assert.equal("ㅏA", system.text)
        system.input(종성("ㅁ"))
        Assert.equal("ㅏAᅠᆷ", system.text)
        system.input("B")
        Assert.equal("ㅏAᅠᆷB", system.text)
        system.input(.BACKSPACE)
        Assert.equal("ㅏAᅠᆷ", system.text)
        system.input(.BACKSPACE)
        Assert.equal("ㅏA", system.text)
        system.input(.BACKSPACE)
        Assert.equal("ㅏ", system.text)
        system.input(초성("ㄱ"))
        Assert.equal("ㅏㄱ", system.text)
        system.input(.BACKSPACE)
        Assert.equal("ㅏ", system.text)
        system.input(.BACKSPACE)
        Assert.equal("", system.text)
        system.input(종성("ㅁ"))
        Assert.equal("ᅠᆷ", system.text)
        system.input(중성("ㅏ"))
        Assert.equal("ᅡᆷ", system.text)
        system.input(초성("ㄱ"))
        Assert.equal("감", system.text)
        system.input(초성("ㅈ"))
        Assert.equal("감ㅈ", system.text)
        system.input(중성("ㅏ"))
        Assert.equal("감자", system.text)
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
        Assert.equal("싦ᅠᆯ", system.text)
        Assert.equal("ᅠᆯ", d.change)
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

    func test종성() {
        let system = HangulInputSystem()
        var d: AutomataDiff
        
        d = system.input(종성("ㅁ"))
        Assert.equal("ᅠᆷ", system.text)
        Assert.equal("ᅠᆷ", d.change)
        Assert.equal(0, d.n)

        d = system.input(중성("ㅓ"))
        Assert.equal("ᅥᆷ", system.text)
        Assert.equal("ᅥᆷ", d.change)
        Assert.equal(-1, d.n)
    }
    
    func testㅔ_ㅓㅣ() {
        let system = HangulInputSystem()
        var d: AutomataDiff
        
        d = system.input(중성("ㅓ"))
        Assert.equal("ㅓ", system.text)
        
        d = system.input(중성("ㅣ"))
        Assert.equal("ㅔ", system.text)
        Assert.equal("ㅔ", d.change)
        Assert.equal(-1, d.n)
        
        d = system.input(.BACKSPACE)
        Assert.equal("ㅓ", system.text)
    }
    
    func test게_ㄱㅓㅣ() {
        let system = HangulInputSystem()
        var d: AutomataDiff

        d = system.input(초성("ㄱ"))
        Assert.equal("ㄱ", system.text)
        
        d = system.input(중성("ㅓ"))
        Assert.equal("거", system.text)
        
        d = system.input(중성("ㅣ"))
        Assert.equal("게", system.text)
        Assert.equal("게", d.change)
        Assert.equal(-1, d.n)
        
        d = system.input(.BACKSPACE)
        Assert.equal("거", system.text)
    }

    func test게_ㅓㅣㄱ() {
        let system = HangulInputSystem()
        var d: AutomataDiff
        
        d = system.input(중성("ㅓ"))
        Assert.equal("ㅓ", system.text)
        Assert.equal("ㅓ", d.change)
        Assert.equal(0, d.n)
        
        d = system.input(중성("ㅣ"))
        Assert.equal("ㅔ", system.text)
        
        d = system.input(초성("ㄱ"))
        Assert.equal("게", system.text)
        
        d = system.input(.BACKSPACE)
        Assert.equal("ㅔ", system.text)
    }
}