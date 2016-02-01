//
//  Hangul.swift
//  Test
//
//  Created by wookyoung on 2/1/16.
//  Copyright © 2016 factorcat. All rights reserved.
//

import UIKit


enum HanChar {
    case normal(value: String)
    case hangul(초: String, 중: String, 종: String)
}

enum JamoType {
    case Normal
    case Special(key: Int32)
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

func applicalbe(part: String, jamo: Jamo, prevjamo: Jamo?) -> String? {
    if part.isEmpty {
        return jamo.sound
    } else {
        switch jamo.type {
        case .초:
            if let preja: Jamo = prevjamo {
                if case .초 = preja.type {
                } else {
                    return nil
                }
            }
            switch (part, jamo.sound) {
            case ("ㄱ" ,"ㄱ"): return "ㄲ"
            case ("ㄷ" ,"ㄷ"): return "ㄸ"
            case ("ㅂ" ,"ㅂ"): return "ㅃ"
            case ("ㅅ" ,"ㅅ"): return "ㅆ"
            case ("ㅈ" ,"ㅈ"): return "ㅉ"
            default: return nil
            }
        case .중:
            if let preja: Jamo = prevjamo {
                if case .중 = preja.type {
                } else {
                    return nil
                }
            }
            switch (part, jamo.sound) {
//            case ("ㅏ", "ㅣ"): return "ㅐ"
//            case ("ㅑ", "ㅣ"): return "ㅒ"
//            case ("ㅓ", "ㅣ"): return "ㅔ"
//            case ("ㅕ", "ㅣ"): return "ㅖ"
            case ("ㅗ", "ㅏ"): return "ㅘ"
            case ("ㅗ", "ㅐ"): return "ㅙ"
            case ("ㅗ", "ㅣ"): return "ㅚ"
            case ("ㅜ", "ㅓ"): return "ㅝ"
            case ("ㅜ", "ㅔ"): return "ㅞ"
            case ("ㅜ", "ㅣ"): return "ㅟ"
            case ("ㅡ", "ㅣ"): return "ㅢ"
            case ("ㅏ", "ㅗ"): return "ㅘ" // rev
            case ("ㅐ", "ㅗ"): return "ㅙ" // rev
            case ("ㅣ", "ㅗ"): return "ㅚ" // rev
            case ("ㅓ", "ㅜ"): return "ㅝ" // rev
            case ("ㅔ", "ㅜ"): return "ㅞ" // rev
            case ("ㅣ", "ㅜ"): return "ㅟ" // rev
            case ("ㅣ", "ㅡ"): return "ㅢ" // rev
            default: return nil
            }
        case .종:
            if let preja: Jamo = prevjamo {
                if case .종 = preja.type {
                } else {
                    return nil
                }
            }
            switch (part, jamo.sound) {
            case ("ㄱ" ,"ㄱ"): return "ㄲ"
            case ("ㄱ" ,"ㅅ"): return "ㄳ"
            case ("ㄴ" ,"ㅈ"): return "ㄵ"
            case ("ㄴ" ,"ㅎ"): return "ㄶ"
//            case ("ㄷ" ,"ㄷ"): return "ㄸ"
            case ("ㄹ" ,"ㄱ"): return "ㄺ"
            case ("ㄹ" ,"ㅁ"): return "ㄻ"
            case ("ㄹ" ,"ㅂ"): return "ㄼ"
            case ("ㄹ" ,"ㅅ"): return "ㄽ"
            case ("ㄹ" ,"ㅌ"): return "ㄾ"
            case ("ㄹ" ,"ㅍ"): return "ㄿ"
            case ("ㄹ" ,"ㅎ"): return "ㅀ"
//            case ("ㅂ" ,"ㅂ"): return "ㅃ"
            case ("ㅂ" ,"ㅅ"): return "ㅄ"
            case ("ㅅ" ,"ㅅ"): return "ㅆ"
//            case ("ㅈ" ,"ㅈ"): return "ㅉ"
            default: return nil
            }
        default:
            return nil
        }
    }
}

func compose(syllable: HanChar) -> String {
    switch syllable {
    case let .normal(value) :
        return value
    case let .hangul(초, 중, 종):
        switch (초, 중, 종) {
        case ("", "", ""):
            return ""
        case (초, "", _):
            return 초
        case ("", 중, _):
            return 중
        case ("", "", 종):
            return ""
        default:
            var 값  = 유니코드_가
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
        var str = syllables.map { syllable in compose(syllable) }.joinWithSeparator("")
        if let prev = prevhangul {
            str += compose(prev)
        }
        if let prev = prevchar {
            str += compose(prev)
        }
        return str
    }
    var prevhangul: HanChar? = nil // save
    var prevchar: HanChar? = nil
    var prevjamo: Jamo? = nil
    
    func automata(jamo: Jamo) {
        if let prev = prevchar {
            switch (prev, jamo.type) {
            case (.hangul, .Normal):
                prevhangul = prev
                prevchar = HanChar.normal(value: jamo.sound)
            case (.normal, .Normal):
                if nil != prevhangul {
                    prevhangul = nil
                }
                prevchar = HanChar.normal(value: jamo.sound)
            case (.normal, .초):
                if let hangul = prevhangul {
                    syllables.append(hangul)
                    prevhangul = nil
                }
                syllables.append(prev)
                prevchar = HanChar.hangul(초: jamo.sound, 중: "", 종: "")
            case (.normal, .중):
                if let hangul = prevhangul {
                    syllables.append(hangul)
                    prevhangul = nil
                }
                syllables.append(prev)
                prevchar = HanChar.hangul(초: "", 중: jamo.sound, 종: "")
            case (.normal, .종):
                if let hangul = prevhangul {
                    syllables.append(hangul)
                    prevhangul = nil
                }
                syllables.append(prev)
                prevchar = HanChar.hangul(초: "", 중: "", 종: jamo.sound)
            case let (.hangul(초, 중, 종), .초):
                if let applied = applicalbe(초, jamo: jamo, prevjamo: prevjamo) {
                    prevchar = HanChar.hangul(초: applied, 중: 중, 종: 종)
                } else {
                    syllables.append(prev)
                    prevchar = HanChar.hangul(초: jamo.sound, 중: "", 종: "")
                }
            case let (.hangul(초, 중, 종), .중):
                if let applied = applicalbe(중, jamo: jamo, prevjamo: prevjamo) {
                    prevchar = HanChar.hangul(초: 초, 중: applied, 종: 종)
                } else {
                    syllables.append(prev)
                    prevchar = HanChar.hangul(초: "", 중: jamo.sound, 종: "")
                }
            case let (.hangul(초, 중, 종), .종):
                if let applied = applicalbe(종, jamo: jamo, prevjamo: prevjamo) {
                    prevchar = HanChar.hangul(초: 초, 중: 중, 종: applied)
                } else {
                    syllables.append(prev)
                    prevchar = HanChar.hangul(초: "", 중: "", 종: jamo.sound)
                }
            case (_, .Special(BACKSPACE)):
                remove_prev_input(prev)
            default:
                print("?")
                break
            }
        } else {
            switch jamo.type {
            case .Special:
                break
            case .Normal:
                prevchar = HanChar.normal(value: jamo.sound)
            case .초:
                prevchar = HanChar.hangul(초: jamo.sound, 중: "", 종: "")
            case .중:
                prevchar = HanChar.hangul(초: "", 중: jamo.sound, 종: "")
            case .종:
                prevchar = HanChar.hangul(초: "", 중: "", 종: jamo.sound)
            }
        }
        prevjamo = jamo
    }
    
    internal func remove_prev_input(prev: HanChar) {
        if case let .hangul(초, 중, 종) = prev {
            if let jamo = prevjamo {
                switch jamo.type {
                case .Special(_), .Normal:
                    if let hangul = prevhangul {
                        prevchar = hangul
                        prevhangul = nil
                    } else {
                        if syllables.count > 0 {
                            syllables.removeLast()
                        }
                        prevchar = nil
                    }
                case .초:
                    prevchar = HanChar.hangul(초: "", 중: 중, 종: 종)
                case .중:
                    prevchar = HanChar.hangul(초: 초, 중: "", 종: 종)
                case .종:
                    prevchar = HanChar.hangul(초: 초, 중: 중, 종: "")
                }
            }
        } else {
            if let hangul = prevhangul {
                prevchar = hangul
                prevhangul = nil
            } else {
                prevchar = nil
            }
        }
    }

    func input(key: Int32) {
        automata(Jamo(type: .Special(key: key), sound: ""))
    }
    
    func input(normal: String) {
        automata(Jamo(type: .Normal, sound: normal))
    }
    
    func input(jamo: Jamo) {
        automata(jamo)
    }
}