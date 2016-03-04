//
//  HangulInputSystemNormal.swift
//  HangulSwift
//
//  Created by wookyoung on 2/1/16.
//  Copyright © 2016 factorcat. All rights reserved.
//

//import XCTest

class HangulInputSystemNormal: WTestCase {

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
        Assert.equal("ㄱㅏ", system.text)
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
        Assert.equal("ㅏA", system.text)
        system.input("B")
        Assert.equal("ㅏAB", system.text)
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
        Assert.equal("", system.text)
        system.input(중성("ㅏ"))
        Assert.equal("ㅏ", system.text)
        system.input(초성("ㄱ"))
        Assert.equal("감", system.text)
        system.input(초성("ㅈ"))
        Assert.equal("감ㅈ", system.text)
        system.input(중성("ㅏ"))
        Assert.equal("감자", system.text)
    }

}
