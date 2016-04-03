//
//  JamoAreaTests.swift
//  HangulSwift
//
//  Created by wookyoung on 3/26/16.
//  Copyright © 2016 factorcat. All rights reserved.
//

import Foundation

// https://en.wikipedia.org/wiki/List_of_hangul_jamo




//let 빈종성 = "\u{0000}"
//let lower종성표 = [빈종성, "\u{11A8}", "\u{11A9}", "\u{11AA}", "\u{11AB}", "\u{11AC}", "\u{11AD}", "\u{11AE}", "\u{11AF}", "\u{11B0}", "\u{11B1}", "\u{11B2}", "\u{11B3}", "\u{11B4}", "\u{11B5}", "\u{11B6}", "\u{11B7}", "\u{11B8}", "\u{11B9}", "\u{11BA}", "\u{11BB}", "\u{11BC}", "\u{11BD}", "\u{11BE}", "\u{11BF}", "\u{11C0}", "\u{11C1}", "\u{11C2}"]
//let lower중성표 = ["\u{1161}", "\u{1162}", "\u{1163}", "\u{1164}", "\u{1165}", "\u{1166}", "\u{1167}", "\u{1168}", "\u{1169}", "\u{116A}", "\u{116B}", "\u{116C}", "\u{116D}", "\u{116E}", "\u{116F}", "\u{1170}", "\u{1171}", "\u{1172}", "\u{1173}", "\u{1174}", "\u{1175}"]
//let lower초성표 = ["\u{1100}", "\u{1101}", "\u{1102}", "\u{1103}", "\u{1104}", "\u{1105}", "\u{1106}", "\u{1107}", "\u{1108}", "\u{1109}", "\u{110A}", "\u{110B}", "\u{110C}", "\u{110D}", "\u{110E}", "\u{110F}", "\u{1110}", "\u{1111}", "\u{1112}"]


func load_doensori(area: JamoArea) {
    let list = [
        ("초", "ᄭ", "ㅅ", "ㄱ"),
        ("초", "ᅅ", "ㅇ", "ㅅ"),
        ("초", "ꥰ", "ㅁ", "ㄷ"),
        ("중", "ᆣ", "ㅏ", "ㅡ"),
        ("중", "ힹ", "ㅡ", "ㅏ"),
        ("중", "ᆢ", "ㆍ", "ㆍ"),
        ("중", "ᆖ", "ㅡ", "ㅡ"),
        ]
    area.doensori_routine(list)
}

class JamoAreaTests: WHangulTestCase {
    
    func setup() {
        load_doensori(a)
    }
    
    func test_compact() {
        Assert.equal("ㄱ", a.compact(.초, scalar: "\u{1100}"))
        Assert.equal(nil, a.compact(.초, scalar: "\u{1140}"))
    }
    
    func test_jamoarea() {
        Assert.equal("ㄱ", a.scalar_to_compatibility(.초, scalar: "\u{1100}"))
        Assert.equal("ㅿ", a.scalar_to_compatibility(.초, scalar: "\u{1140}"))
    }
    
    func test_compatibility_to_scalar() {
        Assert.equal("\u{1100}", a.compatibility_to_scalar(.초, sound: "ㄱ"))
        Assert.equal("\u{1140}", a.compatibility_to_scalar(.초, sound: "ㅿ"))
        Assert.equal("\u{119E}", a.compatibility_to_scalar(.중, sound: "ㆍ"))
        
        Assert.equal("\u{1105}", a.compatibility_to_scalar(.초, sound: "ㄹ"))
        Assert.equal("\u{1161}", a.compatibility_to_scalar(.중, sound: "ㅏ"))
        Assert.equal("\u{11BA}", a.compatibility_to_scalar(.종, sound: "ㅅ"))
        
        Assert.equal("\u{1106}", a.compatibility_to_scalar(.초, sound: "ㅁ"))
        Assert.equal("\u{1161}", a.compatibility_to_scalar(.중, sound: "ㅏ"))
        Assert.equal("\u{11AF}", a.compatibility_to_scalar(.종, sound: "ㄹ"))
    }
    
    func test_compose() {
        var syl: YetHanChar
        
        syl = YetHanChar.yethangul(set: 빈자모셑, 방점: nil)
        Assert.equal("", a.compose(syl))
        Assert.equal([], a.compose(syl).scalars)
        
        syl = YetHanChar.yethangul(set: YetJamoSet(초: 옛초("\u{1100}"), 중: 빈중, 종: 빈종), 방점: nil)
        Assert.equal("ㄱ", a.compose(syl))
        Assert.equal("\u{3131}", a.compose(syl))
        Assert.equal(["\u{3131}"], a.compose(syl).scalars)
        
        syl = YetHanChar.yethangul(set: YetJamoSet(초: 옛초("\u{1100}"), 중: 옛중("\u{1161}"), 종: 빈종), 방점: nil)
        Assert.equal("가", a.compose(syl))
        
        syl = YetHanChar.yethangul(set: YetJamoSet(초: 옛초("\u{1100}"), 중: 옛중("\u{1161}"), 종: 옛종("\u{11BC}")), 방점: nil)
        Assert.equal("강", a.compose(syl))
    }
    
    func test_방점() {
        Assert.equal(["\u{115F}", "\u{302E}"], 거성마크.scalars)
        Assert.equal(["\u{115F}", "\u{302F}"], 상성마크.scalars)
    }

    func test_decompose_hangul() {
        let 랏a: YetHanChar = a.decompose_hangul("랏")
        let 랏b = YetHanChar.yethangul(set: YetJamoSet(초: 옛초("\u{1105}"), 중: 옛중("\u{1161}"), 종: 옛종("\u{11BA}")), 방점: nil)
        Assert.True(랏a == 랏b)
    }
    
    func test_decompose_yethangul() {
        let 말a = a.decompose_yethangul("\u{302F}\u{1106}\u{1161}\u{11AF}")
        let 말b = YetHanChar.yethangul(set: YetJamoSet(초: 옛초("\u{1106}"), 중: 옛중("\u{1161}"), 종: 옛종("\u{11AF}")), 방점: .상성)
        Assert.True(말a == 말b)
    }
    
    func test_compose_방점() {
        var syl: YetHanChar
        
        Assert.equal(["\u{00B7}"], "·".unicodeScalars.map { x in x})
        Assert.equal(["\u{003A}"], ":".unicodeScalars.map { x in x})
        
        Assert.equal(["\u{115F}", "\u{302E}"], 거성마크.scalars)
        
        Assert.equal(["\u{302E}"], a.compose(YetHanChar.yethangul(set: 빈자모셑, 방점: .거성), spacing: false).scalars)
        Assert.equal(["\u{302F}"], a.compose(YetHanChar.yethangul(set: 빈자모셑, 방점: .상성), spacing: false).scalars)
        Assert.equal(["\u{302E}", 방점후공백], a.compose(YetHanChar.yethangul(set: 빈자모셑, 방점: .거성)).scalars)
        Assert.equal(["\u{302F}", 방점후공백], a.compose(YetHanChar.yethangul(set: 빈자모셑, 방점: .상성)).scalars)
        
        syl = YetHanChar.yethangul(set: YetJamoSet(초: 옛초("\u{1105}"), 중: 옛중("\u{1161}"), 종: 옛종("\u{11BA}")), 방점: nil)
        Assert.equal(["\u{B78F}"], a.compose(syl).scalars)
        
        syl = YetHanChar.yethangul(set: YetJamoSet(초: 옛초("\u{1105}"), 중: 옛중("\u{1161}"), 종: 옛종("\u{11BA}")), 방점: nil)
        Assert.equal(["\u{B78F}"], a.compose(syl).scalars)
        
        syl = YetHanChar.yethangul(set: YetJamoSet(초: 옛초("\u{1105}"), 중: 옛중("\u{1161}"), 종: 옛종("\u{11BA}")), 방점: .거성)
        Assert.equal(["\u{1105}", "\u{1161}", "\u{11BA}", "\u{302E}", 방점후공백], a.compose(syl).scalars)
        
        syl = YetHanChar.yethangul(set: YetJamoSet(초: 옛초("\u{1106}"), 중: 옛중("\u{1161}"), 종: 옛종("\u{11AF}")), 방점: .상성)
        Assert.equal(["\u{1106}", "\u{1161}", "\u{11AF}", "\u{302F}", 방점후공백], a.compose(syl).scalars)
    }

    func test_applicable() {
        load_doensori(a)
        Assert.equal("\u{1101}", a.applicable(초성("ㄱ"), jamo: 초성("ㄱ")))
        Assert.equal("\u{112D}", a.applicable(초성("ㅅ"), jamo: 초성("ㄱ")))
    }
    
    func test_deapplicable() {
        load_doensori(a)
        Assert.equal("\u{1100}", a.deapplicable(초성("ㄲ"), jamo: 초성("ㄱ")))
        Assert.equal(nil, a.deapplicable(옛초("\u{112D}"), jamo: 초성("ㅅ")))
        Assert.equal("\u{1109}", a.deapplicable(옛초("\u{112D}"), jamo: 초성("ㄱ")))
    }
    
    func test_compose_halfwidth() {
        var syl: YetHanChar
        syl = YetHanChar.yethangul(set: YetJamoSet(초: 옛초("\u{1105}"), 중: 옛중("\u{318E}"), 종: 옛종("\u{11BA}")), 방점: nil)
        Assert.equal(["\u{1105}", "\u{318E}", "\u{11BA}"], a.compose(syl).scalars)
   
    }

}