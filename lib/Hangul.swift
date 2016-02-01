//
//  Hangul.swift
//  Test
//
//  Created by wookyoung on 2/1/16.
//  Copyright © 2016 factorcat. All rights reserved.
//

import Foundation


enum HanChar {
    case normal(value: String)
    case hangul(초: String, 중: String, 종: String)
}

enum JamoType {
    case A
    case 초
    case 중
    case 종
}

struct Jamo {
    var type: JamoType
    var sound: String
}


let 유니코드_가 = 0xAC00
let 유니코드_히흫 = 0xD7A3
let 초성오프셋 = 21 * 28
let 중성오프셋 = 28

func split_by(space str: String) -> [String] {
    return str.componentsSeparatedByString(" ")
}

let 초성표 = split_by(space: "ㄱ ㄲ ㄴ ㄷ ㄸ ㄹ ㅁ ㅂ ㅃ ㅅ ㅆ ㅇ ㅈ ㅉ ㅊ ㅋ ㅌ ㅍ ㅎ")
let 중성표 = split_by(space: "ㅏ ㅐ ㅑ ㅒ ㅓ ㅔ ㅕ ㅖ ㅗ ㅘ ㅙ ㅚ ㅛ ㅜ ㅝ ㅞ ㅟ ㅠ ㅡ ㅢ ㅣ")
let 종성표 = [""] + split_by(space: "ㄱ ㄲ ㄳ ㄴ ㄵ ㄶ ㄷ ㄹ ㄺ ㄻ ㄼ ㄽ ㄾ ㄿ ㅀ ㅁ ㅂ ㅄ ㅅ ㅆ ㅇ ㅈ ㅊ ㅋ ㅌ ㅍ ㅎ")

extension String {
    var hanchar: HanChar {
        let scalars = String(self).unicodeScalars
        var 값 :Int = Int(scalars[scalars.startIndex].value)
        if 값 >= 유니코드_가 && 값 <= 유니코드_히흫 {
            값 -= 유니코드_가
            let 초성인덱스 = (값 / 초성오프셋)
            값 %= 초성오프셋
            let (중성인덱스, 종성인덱스) = ((값 / 중성오프셋), (값 % 중성오프셋))
            return HanChar.hangul(초: 초성표[초성인덱스], 중: 중성표[중성인덱스], 종: 종성표[종성인덱스])
        } else {
            return HanChar.normal(value: self)
        }
    }
}

func applicalbe(part: String, jamo: Jamo) -> String? {
    if "" == part {
        return jamo.sound
    } else {
        switch jamo.type {
        case .초, .종:
            switch (part, jamo.sound) {
            case ("ㄱ" ,"ㅅ"): return "ㄳ"
            case ("ㄴ" ,"ㅈ"): return "ㄵ"
            case ("ㄴ" ,"ㅎ"): return "ㄶ"
            case ("ㄹ" ,"ㄱ"): return "ㄺ"
            case ("ㄹ" ,"ㅁ"): return "ㄻ"
            case ("ㄹ" ,"ㅂ"): return "ㄼ"
            case ("ㄹ" ,"ㅅ"): return "ㄽ"
            case ("ㄹ" ,"ㅌ"): return "ㄾ"
            case ("ㄹ" ,"ㅍ"): return "ㄿ"
            case ("ㄹ" ,"ㅎ"): return "ㅀ"
            case ("ㅂ" ,"ㅅ"): return "ㅄ"
            default: return nil
            }
        case .중:
            switch (part, jamo.sound) {
            case ("ㅗ", "ㅏ"): return "ㅘ"
            case ("ㅗ", "ㅐ"): return "ㅙ"
            case ("ㅗ", "ㅣ"): return "ㅚ"
            case ("ㅜ", "ㅓ"): return "ㅝ"
            case ("ㅜ", "ㅔ"): return "ㅞ"
            case ("ㅜ", "ㅣ"): return "ㅟ"
            case ("ㅡ", "ㅣ"): return "ㅢ"
            default: return nil
            }
        default:
            return nil
        }
    }
}

func compose(syl: HanChar) -> String {
    switch syl {
    case let .normal(value) :
        return value
    case let .hangul(초, 중, 종):
        var 값  = 유니코드_가
        switch (초, 중, 종) {
        case ("", "", ""):
            return ""
        case (초, "", ""):
            return 초
        case ("", 중, _):
            return 중
        case ("", "", 종):
            return ""
        default:
            if let 초값 = 초성표.indexOf(초) {
                값 += 초성오프셋 * 초값
            }
            if let 중값 = 중성표.indexOf(중) {
                값 += 중성오프셋 * 중값
            }
            if let 종값 = 종성표.indexOf(종) {
                값 += 종값
            }
            return String(UnicodeScalar(값))
        }
    }
}

class HangulInputSystem {
    var syllables =  [HanChar]()
    var text: String {
        let str = syllables.map { syl in compose(syl) }.joinWithSeparator("")
        if let prev = prevchar {
            return str + compose(prev)
        } else {
            return str
        }
    }
    var prevchar: HanChar? = nil
    
    func automata(jamo: Jamo) {
        if let prev = prevchar {
            switch (prev, jamo.type) {
            case (_, .A):
                syllables.append(prev)
                prevchar = HanChar.normal(value: jamo.sound)
            case (.normal, .초):
                syllables.append(prev)
                prevchar = HanChar.hangul(초: jamo.sound, 중: "", 종: "")
            case (.normal, .중):
                syllables.append(prev)
                prevchar = HanChar.hangul(초: "", 중: jamo.sound, 종: "")
            case (.normal, .종):
                syllables.append(prev)
                prevchar = HanChar.hangul(초: "", 중: "", 종: jamo.sound)
            case let (.hangul(초, 중, 종), .초):
                if let applied = applicalbe(초, jamo: jamo) {
                    prevchar = HanChar.hangul(초: applied, 중: 중, 종: 종)
                } else {
                    syllables.append(prev)
                    prevchar = HanChar.hangul(초: jamo.sound, 중: "", 종: "")
                }
            case let (.hangul(초, 중, 종), .중):
                if let applied = applicalbe(중, jamo: jamo) {
                    prevchar = HanChar.hangul(초: 초, 중: applied, 종: 종)
                } else {
                    syllables.append(prev)
                    prevchar = HanChar.hangul(초: "", 중: jamo.sound, 종: "")
                }
            case let (.hangul(초, 중, 종), .종):
                if let applied = applicalbe(종, jamo: jamo) {
                    prevchar = HanChar.hangul(초: 초, 중: 중, 종: applied)
                } else {
                    syllables.append(prev)
                    prevchar = HanChar.hangul(초: "", 중: "", 종: jamo.sound)
                }
            }
        } else {
            switch jamo.type {
            case .A:
                prevchar = HanChar.normal(value: jamo.sound)
            case .초:
                prevchar = HanChar.hangul(초: jamo.sound, 중: "", 종: "")
            case .중:
                prevchar = HanChar.hangul(초: "", 중: jamo.sound, 종: "")
            case .종:
                prevchar = HanChar.hangul(초: "", 중: "", 종: jamo.sound)
            }
        }
    }
    
    func input(jamo: Jamo) {
        switch jamo.type {
        case .A:
            syllables.append(HanChar.normal(value: jamo.sound))
        case _:
            automata(jamo)
        }
    }
}