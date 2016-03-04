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
        Assert.equal("", system.text)
        system.input(중성("ㅏ"))
        Assert.equal("ㅏ", system.text)
        system.input(초성("ㄱ"))
        Assert.equal("감", system.text)
    }
    
    func test감_ㅏㅁㄱ() {
        let system = HangulInputSystem()
        system.input(중성("ㅏ"))
        Assert.equal("ㅏ", system.text)
        system.input(종성("ㅁ"))
        Assert.equal("ㅏ", system.text)
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
        Assert.equal("ㅏ", system.text)
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
        Assert.equal("ㅂ", system.text)
        system.input(중성("ㅏ"))
        Assert.equal("방", system.text)
        
        system = HangulInputSystem()
        system.input(종성("ㅇ"))
        Assert.equal("", system.text)
        system.input(초성("ㅂ"))
        Assert.equal("ㅂ", system.text)
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
        Assert.equal("돌ㄱ", system.text)
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
        Assert.equal("돌ㅏ", system.text)
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

}
