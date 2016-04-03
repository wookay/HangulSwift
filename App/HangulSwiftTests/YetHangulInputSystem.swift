//
//  YetHangulInputSystem.swift
//  HangulSwift
//
//  Created by wookyoung on 2/1/16.
//  Copyright © 2016 factorcat. All rights reserved.
//

//import XCTest
import Foundation

func load_doensori(system: HangulInputSystem) {
    let list = [
        ("초", "ᄭ", "ㅅ", "ㄱ"),
        ("초", "ᅅ", "ㅇ", "ㅅ"),
        ("초", "ꥰ", "ㅁ", "ㄷ"),
        ("중", "ᆣ", "ㅏ", "ㅡ"),
        ("중", "ힹ", "ㅡ", "ㅏ"),
        ("중", "ᆢ", "ㆍ", "ㆍ"),
        ("중", "ᆖ", "ㅡ", "ㅡ"),
        
        ]
    system.area.doensori_routine(list)
}


class YetHangulInputSystemUnicode52: WHangulTestCase {
    
    // Unicode 5.2
    func test_ꥰᅧᆫ() {
        var d: AutomataDiff
        
        let system = HangulInputSystem()
        load_doensori(system)
        
        d = system.input(초성("ㅁ"))
        d = system.input(초성("ㄷ"))
        Assert.equal("ꥰᅠ", system.text)
        
        d = system.input(중성("ㅕ"))
        Assert.equal("ꥰᅧ", system.text)
        Assert.equal(-2, d.n)
        Assert.equal("ꥰᅧ", d.change)
        Assert.equal(true, d.change.containsUnicode52)
        
        d = system.input(종성("ㄴ"))
        Assert.equal("ꥰᅧᆫ", system.text)
        Assert.equal(-2, d.n)
        Assert.equal("ꥰᅧᆫ", d.change)
        Assert.equal([], system.syllables)
    }
    
    func test_ㅏㅡᆣ() {
        var d: AutomataDiff
        
        let system = HangulInputSystem()
        load_doensori(system)
        
        d = system.input(초성("ㄷ"))
        Assert.equal("ㄷ", system.text)
        Assert.equal("ㄷ", d.change)
        Assert.equal(0, d.n)
        
        d = system.input(중성("ㅏ"))
        Assert.equal("다", system.text)
        Assert.equal("다", d.change)
        Assert.equal(-1, d.n)
        
        d = system.input(중성("ㅡ"))
        Assert.equal("ᄃᆣ", system.text)
        Assert.equal("ᄃᆣ", d.change)
        Assert.equal(-1, d.n)
        
        d = system.input(.BACKSPACE)
        Assert.equal("다", system.text)
        Assert.equal("다", d.change)
        Assert.equal(-1, d.n)
        
        d = system.input(중성("ㅡ"))
        Assert.equal("ᄃᆣ", system.text)
        Assert.equal("ᄃᆣ", d.change)
        Assert.equal(-1, d.n)
        
        d = system.input(종성("ㄱ"))
        Assert.equal("ᄃᆣᆨ", system.text)
        Assert.equal("ᄃᆣᆨ", d.change)
        Assert.equal(-1, d.n)
        //
        
        d = system.input(초성("ㅂ"))
        Assert.equal("ᄃᆣᆨㅂ", system.text)
        Assert.equal("ㅂ", d.change)
        Assert.equal(0, d.n)
    }
    
    func test_ㅡㅏힹ() {
        var d: AutomataDiff
        
        let system = HangulInputSystem()
        load_doensori(system)
        
        d = system.input(초성("ㄷ"))
        Assert.equal("ㄷ", system.text)
        Assert.equal("ㄷ", d.change)
        Assert.equal(0, d.n)
        
        d = system.input(중성("ㅡ"))
        Assert.equal("드", system.text)
        Assert.equal("드", d.change)
        Assert.equal(-1, d.n)
        
        d = system.input(중성("ㅏ"))
        Assert.equal("ᄃힹ", system.text)
        Assert.equal("ᄃힹ", d.change)
        Assert.equal(-1, d.n)
        
        d = system.input(.BACKSPACE)
        Assert.equal("드", system.text)
        Assert.equal("드", d.change)
        Assert.equal(-2, d.n)
        
        d = system.input(중성("ㅏ"))
        Assert.equal("ᄃힹ", system.text)
        Assert.equal("ᄃힹ", d.change)
        Assert.equal(-1, d.n)
        
        d = system.input(종성("ㄱ"))
        Assert.equal("ᄃힹᆨ", system.text)
        Assert.equal("ᄃힹᆨ", d.change)
        Assert.equal(true, d.change.containsUnicode52)
        Assert.equal(-2, d.n)
        
        d = system.input(초성("ㅂ"))
        Assert.equal("ᄃힹᆨㅂ", system.text)
        Assert.equal("ㅂ", d.change)
        Assert.equal(0, d.n)
        
        d = system.input(중성("ㅏ"))
        Assert.equal("ᄃힹᆨ바", system.text)
        Assert.equal("바", d.change)
        Assert.equal(-1, d.n)
        
        d = system.input(종성("ㄱ"))
        Assert.equal("ᄃힹᆨ박", system.text)
        Assert.equal("박", d.change)
        Assert.equal(-1, d.n)
        
        d = system.input(초성("ㄱ"))
        Assert.equal("ᄃힹᆨ박ㄱ", system.text)
        Assert.equal("ㄱ", d.change)
        Assert.equal(0, d.n)
    }
    
    func test_ㅇㅅ굴() {
        var d: AutomataDiff
        
        let system = HangulInputSystem()
        load_doensori(system)
        
        d = system.input(초성("ㅇ"))
        d = system.input(초성("ㅅ"))
        Assert.equal("ᅅᅠ", system.text)
        Assert.equal(["\u{1145}", "\u{1160}"], system.text.unicodeScalars.map { x in x })
        Assert.equal("ᅅᅠ", d.change)
        Assert.equal(-1, d.n)
        
        d = system.input(초성("ㄱ"))
        Assert.equal("ᅅᅠㄱ", system.text)
        Assert.equal(["\u{1145}", "\u{1160}", "\u{3131}"], system.text.unicodeScalars.map { x in x })
        Assert.equal("ㄱ", d.change)
        Assert.equal(0, d.n)
        
        d = system.input(중성("ㅜ"))
        Assert.equal("ᅅᅠ구", system.text)
        Assert.equal("구", d.change)
        Assert.equal(-1, d.n)
        
        d = system.input(종성("ㄹ"))
        Assert.equal("ᅅᅠ굴", system.text)
        Assert.equal("굴", d.change)
        Assert.equal(-1, d.n)
    }
}


class YetHangulInputSystem: WHangulTestCase {

    func test_ᄇᆞᆯ() {
        let system = HangulInputSystem()
        var d: AutomataDiff

        d = system.input(초성("ㅂ"))
        d = system.input(중성("ㆍ"))
        Assert.equal("ᄇᆞ", system.text)
        
        d = system.input(종성("ㄹ"))
        Assert.equal("ᄇᆞᆯ", system.text)
        Assert.equal(-1, d.n)
    }
    
    func test_ᄇᆢᆯ() {
        let system = HangulInputSystem()
        var d: AutomataDiff
        
        d = system.input(초성("ㅂ"))
        d = system.input(옛중("ᆢ"))
        d = system.input(종성("ㄹ"))
        
        Assert.equal("ᄇᆢᆯ", system.text)
        Assert.equal(-1, d.n)
    }

    func test_ᄇㆎᆯ() {
        let system = HangulInputSystem()
        var d: AutomataDiff
        
        d = system.input(초성("ㅂ"))
        d = system.input(옛중("ㆎ"))
        d = system.input(종성("ㄹ"))
        
        Assert.equal("ᄇㆎᆯ", system.text)
        Assert.equal(-1, d.n)
    }
    
    func test_ᅙᆞᇹ() {
        let system = HangulInputSystem()
        var d: AutomataDiff
        
        d = system.input(초성("ㆆ"))
        Assert.equal("ㆆ", system.text)
        
        d = system.input(중성("ㆍ"))
        Assert.equal("ᅙᆞ", system.text)
        
        d = system.input(종성("ㆆ"))
        Assert.equal("ᅙᆞᇹ", system.text)
        Assert.equal(-1, d.n)
    }
    
    func test_ᄀᆞᇫ() {
        let system = HangulInputSystem()
        var d: AutomataDiff

        d = system.input(종성("ㅿ"))
        Assert.equal("ᅟᅠᇫ", system.text)
        Assert.equal(0, d.n)
        
        d = system.input(중성("ㆍ"))
        Assert.equal("ᅟᆞᇫ", system.text)
        
        d = system.input(초성("ㄱ"))
        Assert.equal("ᄀᆞᇫ", system.text)
    }

    func test_가ㅿ() {
        let system = HangulInputSystem()
        var d: AutomataDiff

        d = system.input(초성("ㄱ"))
        d = system.input(중성("ㅏ"))
        Assert.equal("가", system.text)
        
        d = system.input(종성("ㅿ"))
        Assert.equal("가ᇫ", system.text)
        Assert.equal(-1, d.n)
    }
    
    func test_ᅀㅏᆼ() {
        let system = HangulInputSystem()
        var d: AutomataDiff
        
        d = system.input(초성("ㅿ"))
        Assert.equal("ㅿ", system.text)
        
        d = system.input(중성("ㅏ"))
        Assert.equal("ᅀᅡ", system.text)
        
        d = system.input(종성("ㅇ"))
        Assert.equal("ᅀᅡᆼ", system.text)
        Assert.equal(-1, d.n)
    }
    
    func test_ᆢ() {
        var d: AutomataDiff
        
        let system = HangulInputSystem()
        load_doensori(system)
        
        d = system.input(초성("ㄱ"))
        Assert.equal(0, d.n)
        
        d = system.input(옛중("ᆞ"))
        Assert.equal("ᄀᆞ", system.text)
        
        d = system.input(옛중("ᆞ"))
        Assert.equal("ᄀᆢ", system.text)
        
        d = system.input(옛중("ᆞ"))
        Assert.equal("ᄀᆢㆍ", system.text)
        
        d = system.input(옛중("ᆞ"))
        Assert.equal("ᄀᆢᅟᆢ", system.text)
        
        d = system.input(초성("ㄱ"))
        Assert.equal("ᄀᆢᄀᆢ", system.text)
    }
    
    func test_는ㅡ() {
        var d: AutomataDiff
        
        let system = HangulInputSystem()
        load_doensori(system)
        
        d = system.input(초성("ㄴ"))
        d = system.input(중성("ㅡ"))
        d = system.input(종성("ㄴ"))
        Assert.equal("는", system.text)
        Assert.equal(-1, d.n)
        Assert.equal([], system.syllables)
        
        d = system.input(중성("ㅡ"))
        Assert.equal("는ㅡ", system.text)
        Assert.equal(0, d.n)
        Assert.equal("ㅡ", d.change)
        Assert.equal(["는"], system.syllables)
    }
    
    func test_ㅅ곳() {
        var d: AutomataDiff
        
        let system = HangulInputSystem()
        load_doensori(system)
        
        d = system.input(초성("ㅅ"))
        d = system.input(초성("ㄱ"))
        d = system.input(중성("ㅗ"))
        Assert.equal("ᄭᅩ", system.text)
        
        d = system.input(종성("ㅅ"))
        Assert.equal("ᄭᅩᆺ", system.text)
        Assert.equal([], system.syllables)
        
        d = system.input(.BACKSPACE)
        Assert.equal("ᄭᅩ", system.text)
        Assert.equal(-1, d.n)
        Assert.equal("ᄭᅩ", d.change)
        Assert.equal([], system.syllables)
    }
    
    func test_count() {
        Assert.equal(1, "ᄃᆣ".characters.count)
        Assert.equal(1, "ᄃힹᆨ".characters.count)
        Assert.equal(1, "ᄇᆞᆯ".characters.count)
        
        Assert.equal(3, "ᄃힹᆨ".utf16.count)
        Assert.equal(3, "ᄇᆞᆯ".utf16.count)
        
        Assert.equal(2, "ꥰᅧ".unicodeScalars.count)
        Assert.equal(2, "ᄃힹ".unicodeScalars.count)
        Assert.equal(3, "ᄃힹᆨ".unicodeScalars.count)
        Assert.equal(3, "ᄇᆞᆯ".unicodeScalars.count)
    }
    
//    func test_lower종성표() {
//        print(UnicodeScalar("\u{0000}").value)
//        var a = [UnicodeScalar]()
//        for (idx,x) in 초성표.enumerate() {
////            if x != "" {
//            print([UnicodeScalar(초성영역 + idx)].map { x in x})
//                    .unicodeScalars.map { x in x })
//            }
//            a.append(x.unicodeScalars.first)
//        }
//        Assert.equal(["\u{11AF}"], lower종성표.map { x in x.unicodeScalars.map { x in x }})
//    }
    
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

}