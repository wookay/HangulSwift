//
//  Hangul.swift
//  Test
//
//  Created by wookyoung on 2/1/16.
//  Copyright © 2016 factorcat. All rights reserved.
//

import UIKit


struct JamoSet {
    var 초: Jamo
    var 중: Jamo
    var 종: Jamo
}

enum HanChar {
    case normal(value: String)
    case hangul(set: JamoSet)
}

indirect enum JamoType: Equatable {
    case Normal
    case Special(key: SpecialKeyType)
    case 초
    case 중
    case 종
    case 모
    case 갈(Jamo, Jamo)
}

func ==(lhs: JamoType , rhs: JamoType) -> Bool {
    switch lhs {
    case .초:
        if case .초 = rhs {
            return true
        }
    case .중, .모:
        switch rhs {
        case .중, .모:
            return true
        default:
            break
        }
    case .종:
        if case .종 = rhs {
            return true
        }
    default:
        break
    }
    return false
}

struct Jamo {
    var type: JamoType
    var sound: String
}


let 유니코드_가 = 0xAC00
let 유니코드_히흫 = 0xD7A3
let 초성오프셋 = 21 * 28
let 중성오프셋 = 28
let 모음ㆍ = "ㆍ"

let 초성표 = split_by(space: "ㄱ ㄲ ㄴ ㄷ ㄸ ㄹ ㅁ ㅂ ㅃ ㅅ ㅆ ㅇ ㅈ ㅉ ㅊ ㅋ ㅌ ㅍ ㅎ")
let 중성표 = split_by(space: "ㅏ ㅐ ㅑ ㅒ ㅓ ㅔ ㅕ ㅖ ㅗ ㅘ ㅙ ㅚ ㅛ ㅜ ㅝ ㅞ ㅟ ㅠ ㅡ ㅢ ㅣ")
let 종성표 = [""] + split_by(space: "ㄱ ㄲ ㄳ ㄴ ㄵ ㄶ ㄷ ㄹ ㄺ ㄻ ㄼ ㄽ ㄾ ㄿ ㅀ ㅁ ㅂ ㅄ ㅅ ㅆ ㅇ ㅈ ㅊ ㅋ ㅌ ㅍ ㅎ")
let lower종성표 = [""] + split_by(space: "ᆨ ᆩ ᆪ ᆫ ᆬ ᆭ ᆮ ᆯ ᆰ ᆱ ᆲ ᆳ ᆴ ᆵ ᆶ ᆷ ᆸ ᆹ ᆺ ᆻ ᆼ ᆽ ᆾ ᆿ ᇀ ᇁ ᇂ")

func split_by(space str: String) -> [String] {
    return str.componentsSeparatedByString(" ")
}

extension String {
    var hanchar: HanChar {
        let scalars = String(self).unicodeScalars
        var 값 :Int = Int(scalars[scalars.startIndex].value)
        if 값 >= 유니코드_가 && 값 <= 유니코드_히흫 {
            값 -= 유니코드_가
            let 초성인덱스 = (값 / 초성오프셋)
            값 %= 초성오프셋
            let (중성인덱스, 종성인덱스) = ((값 / 중성오프셋), (값 % 중성오프셋))
            let set = JamoSet(
                초: Jamo(type: .초, sound: 초성표[초성인덱스]),
                중: Jamo(type: .중, sound: 중성표[중성인덱스]),
                종: Jamo(type: .종, sound: 종성표[종성인덱스])
            )
            return HanChar.hangul(set: set)
        } else {
            return HanChar.normal(value: self)
        }
    }
}

func lower(jamo: Jamo) -> Jamo {
    if let idx = 종성표.indexOf(jamo.sound), let sound: String = lower종성표[idx] {
        return Jamo(type: jamo.type, sound: sound)
    }
    return jamo
}

func compose(syllable: HanChar) -> String {
    switch syllable {
    case let .normal(value) :
        return value
    case let .hangul(set):
        let (초성, 중성, 종성) = (set.초, set.중, set.종)
        switch (초성.sound, 중성.sound, 종성.sound) {
        case ("", "", ""):
            return ""
        case (초성.sound, "", ""):
            return 초성.sound
        case ("", 중성.sound, ""):
            return 중성.sound
        case ("", "", 종성.sound):
            return "\u{1160}" + lower(종성).sound
        case (초성.sound, "", 종성.sound):
            var s = ""
            if let 초값 = 초성표.indexOf(초성.sound) {
                s += String(UnicodeScalar(0x1100 + 초값))
            }
            s += "\u{1160}" + lower(종성).sound
            return s
        case ("", 중성.sound, 종성.sound):
            var s = ""
            if 모음ㆍ == 중성.sound {
                s += "\u{119E}"
            } else {
                if let 중값 = 중성표.indexOf(중성.sound) {
                    s += String(UnicodeScalar(0x1161 + 중값))
                }
            }
            s += lower(종성).sound
            return s
        default:
            if 모음ㆍ == 중성.sound {
                var s = ""
                if let 초값 = 초성표.indexOf(초성.sound) {
                    s += String(UnicodeScalar(0x1100 + 초값))
                }
                s += "\u{119E}" + lower(종성).sound
                return s
            } else {
                var 값 = 유니코드_가
                if let 초값 = 초성표.indexOf(초성.sound) {
                    값 += 초성오프셋 * 초값
                }
                if let 중값 = 중성표.indexOf(중성.sound) {
                    값 += 중성오프셋 * 중값
                }
                if let 종값 = 종성표.indexOf(종성.sound) {
                    값 += 종값
                }
                return String(UnicodeScalar(값))
            }
        }
    }
}

enum SpecialKeyType: Int32 {
    case BACKSPACE = 8
    case RETURN = 13
    case SHIFT = 15
    case SPACE = 32
    case NEXT_INPUT_MODE = 1000
    case KEYMAP = 1001
    case NOTHING = -1
}

struct AutomataDiff {
    var n: Int
    var change: String
}

func indexof(jamo: Jamo) -> Int {
    switch jamo.type {
    case .초:
        return 0
    case .중, .모:
        return 1
    case .종:
        return 2
    default:
        return 0
    }
}

func nameof(jamo: Jamo) -> String {
    switch jamo.type {
    case .초:
        return "초"
    case .중, .모:
        return "중"
    case .종:
        return "종"
    default:
        return ""
    }
}

class HangulInputSystem {
    var syllables =  [String]()
    var hangul: JamoSet = JamoSet(
        초: Jamo(type: .초, sound: ""),
        중: Jamo(type: .중, sound: ""),
        종: Jamo(type: .종, sound: "")
    )
    var prevjamo: Jamo? = nil
    var last_backspace: Bool = false
    var pressed: ((Jamo)->Void)? = nil

    func debug() {
//        Log.info("hangul", hangul, "prevjamo", prevjamo, "last_backspace", last_backspace, "syllables", syllables)
    }

    var text: String {
        let str = syllables.joinWithSeparator("")
        return str + compose(HanChar.hangul(set: hangul))
    }
        
    var johab_dict: [String: String] = [String: String]()
    var dejohab_dict: [String: String] = [String: String]()

    func doensori_routine(list: [(String, String, String, String)], custom: Bool = false) {
        for (a,b,c,d) in list {
            johab_dict[a + c + d] = b
            if !custom {
                dejohab_dict[a + b + d] = c
            }
        }
    }
    
    init() {
        doensori_routine(johab_list())
    }
    
    func johab_list() -> [(String, String, String, String)] {
        return [
            ("초", "ㄲ", "ㄱ" ,"ㄱ"),
            ("초", "ㄸ", "ㄷ" ,"ㄷ"),
            ("초", "ㅃ", "ㅂ" ,"ㅂ"),
            ("초", "ㅆ", "ㅅ" ,"ㅅ"),
            ("초", "ㅉ", "ㅈ" ,"ㅈ"),
            ("중", "ㅘ", "ㅗ", "ㅏ"),
            ("중", "ㅙ", "ㅗ", "ㅐ"),
            ("중", "ㅚ", "ㅗ", "ㅣ"),
            ("중", "ㅝ", "ㅜ", "ㅓ"),
            ("중", "ㅞ", "ㅜ", "ㅔ"),
            ("중", "ㅟ", "ㅜ", "ㅣ"),
            ("중", "ㅢ", "ㅡ", "ㅣ"),
            ("중", "ㅘ", "ㅏ", "ㅗ"), // rev
            ("중", "ㅙ", "ㅐ", "ㅗ"), // rev
            ("중", "ㅚ", "ㅣ", "ㅗ"), // rev
            ("중", "ㅝ", "ㅓ", "ㅜ"), // rev
            ("중", "ㅞ", "ㅔ", "ㅜ"), // rev
            ("중", "ㅟ", "ㅣ", "ㅜ"), // rev
            ("중", "ㅢ", "ㅣ", "ㅡ"), // rev
            ("중", "ㅔ", "ㅓ", "ㅣ"),
            ("중", "ㅐ", "ㅏ", "ㅣ"),
            ("중", "ㅖ", "ㅕ", "ㅣ"),
            ("중", "ㅒ", "ㅑ", "ㅣ"),
            ("중", "ㅙ", "ㅘ", "ㅣ"),
            ("중", "ㅞ", "ㅝ", "ㅣ"),
            ("종", "ㄲ", "ㄱ" ,"ㄱ"),
            ("종", "ㄳ", "ㄱ" ,"ㅅ"),
            ("종", "ㄵ", "ㄴ" ,"ㅈ"),
            ("종", "ㄶ", "ㄴ" ,"ㅎ"),
            ("종", "ㄺ", "ㄹ" ,"ㄱ"),
            ("종", "ㄻ", "ㄹ" ,"ㅁ"),
            ("종", "ㄼ", "ㄹ" ,"ㅂ"),
            ("종", "ㄽ", "ㄹ" ,"ㅅ"),
            ("종", "ㄾ", "ㄹ" ,"ㅌ"),
            ("종", "ㄿ", "ㄹ" ,"ㅍ"),
            ("종", "ㅀ", "ㄹ" ,"ㅎ"),
            ("종", "ㅄ", "ㅂ" ,"ㅅ"),
            ("종", "ㅆ", "ㅅ" ,"ㅅ"),
            ("종", "ㄳ", "ㅅ" ,"ㄱ"), // rev
            ("종", "ㄵ", "ㅈ" ,"ㄴ"), // rev
            ("종", "ㄶ", "ㅎ" ,"ㄴ"), // rev
            ("종", "ㄺ", "ㄱ" ,"ㄹ"), // rev
            ("종", "ㄻ", "ㅁ" ,"ㄹ"), // rev
            ("종", "ㄼ", "ㅂ" ,"ㄹ"), // rev
            ("종", "ㄽ", "ㅅ" ,"ㄹ"), // rev
            ("종", "ㄾ", "ㅌ" ,"ㄹ"), // rev
            ("종", "ㄿ", "ㅍ" ,"ㄹ"), // rev
            ("종", "ㅀ", "ㅎ" ,"ㄹ"), // rev
            ("종", "ㅄ", "ㅅ" ,"ㅂ"), // rev
        ]
    }
    
    func deapplicalbe(prevjamo: Jamo, jamo: Jamo) -> String? {
        if let dejohab = dejohab_dict[nameof(jamo) + prevjamo.sound + jamo.sound] {
            return dejohab
        }
        return nil
    }
    
    func applicalbe(prevjamo: Jamo, jamo: Jamo) -> String? {
        if let johab = johab_dict[nameof(jamo) + prevjamo.sound + jamo.sound] {
            return johab
        }
        return nil
    }
    
    func append_syllable(set: JamoSet) {
        syllables.append(compose(HanChar.hangul(set: set)))
    }
    
    func append_syllable(normal: String) {
        syllables.append(compose(HanChar.normal(value: normal)))
    }
    
    func apply_compose(var set: JamoSet, jamo: Jamo) -> Int {
        var n: Int = 0
        switch jamo.type {
        case .초:
            if set.초.sound.isEmpty {
                pressed?(jamo)
                set.초 = jamo
            } else {
                if set.중.sound.isEmpty {
                    if let applied = applicalbe(set.초, jamo: jamo) {
                        pressed?(jamo)
                        set.초 = Jamo(type: .초, sound: applied)
                    } else {
                        pressed?(jamo)
                        append_syllable(hangul)
                        set.초 = jamo
                        set.중.sound = ""
                        set.종.sound = ""
                        n += 1
                    }
                } else {
                    pressed?(jamo)
                    set.초 = jamo
                    set.중.sound = ""
                    set.종.sound = ""
                    append_syllable(hangul)
                    n += 1
                }
            }
        case .중, .모:
            if let applied = applicalbe(set.중, jamo: jamo) {
                if set.종.sound.isEmpty {
                    set.중 = Jamo(type: .중, sound: applied)
                } else {
                    set.초.sound = ""
                    set.중 = jamo
                    set.종.sound = ""
                    append_syllable(hangul)
                    n += 1
                }
            } else {
                if set.중.sound.isEmpty {
                    set.중 = jamo
                } else {
                    set.초.sound = ""
                    set.중 = jamo
                    set.종.sound = ""
                    append_syllable(hangul)
                    n += 1
                }
            }
        case .종:
            if let applied = applicalbe(set.종, jamo: jamo) {
                set.종 = Jamo(type: .종, sound: applied)
            } else {
                if set.종.sound.isEmpty {
                    set.종 = jamo
                } else {
                    set.초.sound = ""
                    set.중.sound = ""
                    set.종 = jamo
                    append_syllable(hangul)
                    n += 1
                }
            }
        default:
            break
        }
        prevjamo = jamo
        hangul = set
        return n
    }
    
    func galma(var set: JamoSet, _ lhs: Jamo, _ rhs: Jamo) -> Int {
        var n: Int = 0
        switch rhs.type {
        case .초:
            if set.초.sound.isEmpty {
                pressed?(rhs)
                set.초 = rhs
                prevjamo = rhs
                hangul = set
            } else {
                if set.중.sound.isEmpty {
                    n += apply_compose(set, jamo: lhs)
                } else {
                    if let applied = applicalbe(set.초, jamo: rhs) {
                        pressed?(rhs)
                        set.초 = Jamo(type: .초, sound: applied)
                        prevjamo = rhs
                        hangul = set
                    } else {
                        n += apply_compose(set, jamo: rhs)
                    }
                }
            }
        case .종:
            if set.중.sound.isEmpty {
                set.중 = lhs
                prevjamo = lhs
                hangul = set
            } else {
                if case .모 = set.중.type {
                    if let applied = applicalbe(set.중, jamo: lhs) {
                        set.중 = Jamo(type: .중, sound: applied)
                        prevjamo = lhs
                        hangul = set
                    } else {
                        n += apply_compose(set, jamo: rhs)
                    }
                } else {
                    if set.종.sound.isEmpty {
                        n += apply_compose(set, jamo: rhs)
                    } else {
                        if let applied = applicalbe(set.종, jamo: rhs) {
                            set.종 = Jamo(type: .종, sound: applied)
                            prevjamo = rhs
                            hangul = set
                        } else {
                            n += apply_compose(set, jamo: lhs)
                        }
                    }
                }
            }
        default:
            break
        }
        return n
    }
    
    func backspace_remove() -> AutomataDiff {
        var diff = AutomataDiff(n: -1, change: "")
        if last_backspace {
            hangul.초.sound = ""
            hangul.중.sound = ""
            hangul.종.sound = ""
            if let _ = prevjamo {
                prevjamo = nil
            }
            if syllables.count > 0 {
                syllables.removeLast()
            }
        } else {
            last_backspace = true
            var set = hangul
            if let prev = prevjamo {
                switch prev.type {
                case .초:
                    if let dejohab = deapplicalbe(set.초, jamo: prev) {
                        set.초.sound = dejohab
                    } else {
                        set.초.sound = ""
                    }
                case .중, .모:
                    if let dejohab = deapplicalbe(set.중, jamo: prev) {
                        set.중 = Jamo(type: .모, sound: dejohab)
                    } else {
                        set.중.sound = ""
                    }
                    if !set.종.sound.isEmpty {
                        prevjamo = set.종
                    } else if !set.초.sound.isEmpty {
                        prevjamo = set.초
                    } else {
                        prevjamo = nil
                    }
                case .종:
                    if let dejohab = deapplicalbe(set.종, jamo: prev) {
                        set.종.sound = dejohab
                    } else {
                        set.종.sound = ""
                    }
                default:
                    if syllables.count > 0 {
                        syllables.removeLast()
                    }                                    
                }
                hangul = set
                diff.change += compose(HanChar.hangul(set: hangul))
            }
        }
        return diff
    }
    
    func automata_diff(jamo: Jamo) -> AutomataDiff {
        var diff = AutomataDiff(n: 0, change: "")
        if case .Special(.BACKSPACE) = jamo.type {
            diff = backspace_remove()
        } else {
            last_backspace = false
            let set = hangul
            if !compose(HanChar.hangul(set: set)).isEmpty {
                diff.n -= 1
            }

            switch jamo.type {
            case .초, .중, .모, .종:
                diff.n += apply_compose(set, jamo: jamo)
            case let .갈(lhs, rhs):
                diff.n += galma(set, lhs, rhs)
            case .Normal:
                prevjamo = jamo
                if !compose(HanChar.hangul(set: hangul)).isEmpty {
                    append_syllable(hangul)
                    diff.n += 1
                }
                let normal = jamo.sound
                append_syllable(normal)
                hangul.초.sound = ""
                hangul.중.sound = ""
                hangul.종.sound = ""
                diff.change += normal
            default:
                break
            }
            diff.change += compose(HanChar.hangul(set: hangul))
        }
        return diff
    }

    func input(key: SpecialKeyType) -> AutomataDiff {
        return automata_diff(Jamo(type: .Special(key: key), sound: ""))
    }
    
    func input(normal: String) -> AutomataDiff {
        return automata_diff(Jamo(type: .Normal, sound: normal))
    }
    
    func input(jamo: Jamo) -> AutomataDiff {
        return automata_diff(jamo)
    }
    
}