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

indirect enum JamoType {
    case Normal
    case Special(key: SpecialKeyType)
    case 초
    case 중
    case 종
    case 모
    case 갈(Jamo, Jamo)
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
            return HanChar.hangul(초: 초성표[초성인덱스], 중: 중성표[중성인덱스], 종: 종성표[종성인덱스])
        } else {
            return HanChar.normal(value: self)
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
            if 모음ㆍ == 중 {
                var s = ""
                if let 초값 = 초성표.indexOf(초) {
                    s += String(UnicodeScalar(0x1100 + 초값))
                }
                s += "\u{119E}"
                if let 종값 = 종성표.indexOf(종) {
                    if 종값 > 0 {
                        s += String(UnicodeScalar(0x11a6 + 1 + 종값))
                    }
                }
                return s
            } else {
                var 값 = 유니코드_가
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

class HangulInputSystem {
    var syllables =  [HanChar]()
    var text: String {
        let str = syllables.map { syllable in compose(syllable) }.joinWithSeparator("")
        if let prev = prevchar {
            return str + compose(prev)
        } else {
            return str
        }
    }
    
    var prevchar: HanChar? = nil
    var prevjamo: Jamo? = nil
    var pressed: ((Jamo)->Void)? = nil
    var doensori: ((String, String, String) -> String?)? = nil
    
    func applicalbe(part: String, jamo: Jamo, prevjamo: Jamo?) -> String? {
        if part.isEmpty {
            return jamo.sound
        } else {
            switch jamo.type {
            case .갈(_,_):
                return nil
                
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
                default:
                    if let doensori_func = doensori {
                        if let doen = doensori_func("초", part, jamo.sound) {
                            return doen
                        }
                    } else {
                        return nil
                    }
                }
                
            case .중, .모:
                if let preja: Jamo = prevjamo {
                    switch preja.type {
                    case .중, .모:
                        break
                    default:
                        return nil
                    }
                }
                switch (part, jamo.sound) {
//              case ("ㅏ", "ㅣ"): return "ㅐ"
//              case ("ㅑ", "ㅣ"): return "ㅒ"
//              case ("ㅓ", "ㅣ"): return "ㅔ"
//              case ("ㅕ", "ㅣ"): return "ㅖ"
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
                default:
                    if let doensori_func = doensori {
                        if let doen = doensori_func("중", part, jamo.sound) {
                            return doen
                        }
                    } else {
                        return nil
                    }
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
                case ("ㄹ" ,"ㄱ"): return "ㄺ"
                case ("ㄹ" ,"ㅁ"): return "ㄻ"
                case ("ㄹ" ,"ㅂ"): return "ㄼ"
                case ("ㄹ" ,"ㅅ"): return "ㄽ"
                case ("ㄹ" ,"ㅌ"): return "ㄾ"
                case ("ㄹ" ,"ㅍ"): return "ㄿ"
                case ("ㄹ" ,"ㅎ"): return "ㅀ"
                case ("ㅂ" ,"ㅅ"): return "ㅄ"
                case ("ㅅ" ,"ㅅ"): return "ㅆ"
                case ("ㅅ" ,"ㄱ"): return "ㄳ" // rev
                case ("ㅈ" ,"ㄴ"): return "ㄵ" // rev
                case ("ㅎ" ,"ㄴ"): return "ㄶ" // rev
                case ("ㄱ" ,"ㄹ"): return "ㄺ" // rev
                case ("ㅁ" ,"ㄹ"): return "ㄻ" // rev
                case ("ㅂ" ,"ㄹ"): return "ㄼ" // rev
                case ("ㅅ" ,"ㄹ"): return "ㄽ" // rev
                case ("ㅌ" ,"ㄹ"): return "ㄾ" // rev
                case ("ㅍ" ,"ㄹ"): return "ㄿ" // rev
                case ("ㅎ" ,"ㄹ"): return "ㅀ" // rev
                case ("ㅅ" ,"ㅂ"): return "ㅄ" // rev
                default:
                    if let doensori_func = doensori {
                        if let doen = doensori_func("종", part, jamo.sound) {
                            return doen
                        }
                    } else {
                        return nil
                    }
                }
            default:
                return nil
            }
        }
        return nil
    }

    internal func apply_compose(part: String, _ jamo: Jamo, _ prev: HanChar) -> AutomataDiff {
        var n: Int = 0
        let idx = indexof(jamo)
        if case let .hangul(초, 중, 종) = prev {
            var parts = [초, 중, 종]
            if let applied = applicalbe(part, jamo: jamo, prevjamo: prevjamo) {
                if compose(prev).isEmpty {
                } else {
                    n -= 1
                }
                parts[idx] = applied
            } else {
                syllables.append(prev)
                parts[0] = ""
                parts[1] = ""
                parts[2] = ""
                parts[idx] = jamo.sound
            }
            let (cho, jung, jong) = (parts[0], parts[1], parts[2])
            prevchar = HanChar.hangul(초: cho, 중: jung, 종: jong)
        }
        return AutomataDiff(n: n, change: "")
    }
    
    func automata_diff(jamo: Jamo) -> AutomataDiff {
        var diff = AutomataDiff(n: 0, change: "")
        if let prev = prevchar {
            switch (prev, jamo.type) {
            case (.hangul, .Normal):
                if !compose(prev).isEmpty {
                    syllables.append(prev)
                }
                prevchar = HanChar.normal(value: jamo.sound)
            case (.normal, .Normal):
                syllables.append(prev)
                prevchar = HanChar.normal(value: jamo.sound)
            case (.normal, .초):
                pressed?(jamo)
                syllables.append(prev)
                prevchar = HanChar.hangul(초: jamo.sound, 중: "", 종: "")
            case (.normal, .중), (.normal, .모):
                syllables.append(prev)
                prevchar = HanChar.hangul(초: "", 중: jamo.sound, 종: "")
            case (.normal, .종):
                syllables.append(prev)
                prevchar = HanChar.hangul(초: "", 중: "", 종: jamo.sound)
            case let (.normal, .갈(jung, cho_jong)):
                switch cho_jong.type {
                case .초:
                    let cho = cho_jong
                    pressed?(cho)
                    prevchar = HanChar.hangul(초: cho.sound, 중: "", 종: "")
                    prevjamo = cho
                    diff.n += 1
                    diff.change += compose(prevchar!)
                case .종:
                    syllables.append(prev)
                    prevchar = HanChar.hangul(초: "", 중: jung.sound, 종: "")
                    prevjamo = jung
                    diff.n += 1
                    diff.change += compose(prevchar!)
                default:
                    break
                }
            case let (.hangul(초, _, _), .초):
                pressed?(jamo)
                diff.n += apply_compose(초, jamo, prev).n
            case let (.hangul(_, 중, _), .중):
                diff.n += apply_compose(중, jamo, prev).n
            case let (.hangul(_, 중, _), .모):
                diff.n += apply_compose(중, Jamo(type: .중, sound: jamo.sound), prev).n
            case let (.hangul(_, _, 종), .종):
                diff.n += apply_compose(종, jamo, prev).n
            case let (.hangul(초, 중, 종), .갈(jung, cho_jong)):
                switch cho_jong.type {
                case .초:
                    let cho = cho_jong
                    if 중.isEmpty {
                        if 초.isEmpty {
                            pressed?(cho)
                            prevchar = HanChar.hangul(초: cho.sound, 중: jung.sound, 종: 종)
                            prevjamo = cho
                        } else {
                            prevchar = HanChar.hangul(초: 초, 중: jung.sound, 종: 종)
                            prevjamo = jung
                        }
                        diff.n -= 1
                        diff.change += compose(prevchar!)
                    } else {
                        if let pr = prevjamo {
                            switch pr.type {
                            case .중, .모:
                                if let _ = applicalbe(pr.sound, jamo: jung, prevjamo: prevjamo) {
                                    prevjamo = jung
                                    diff.n += apply_compose(pr.sound, jung, prev).n
                                    diff.change += compose(prevchar!)
                                } else {
                                    pressed?(cho)
                                    prevchar = HanChar.hangul(초: cho.sound, 중: "", 종: "")
                                    prevjamo = cho
                                    diff.n += 1
                                    diff.change += compose(prevchar!)
                                }
                            case .초, .종:
                                pressed?(cho)
                                prevchar = HanChar.hangul(초: cho.sound, 중: "", 종: "")
                                prevjamo = cho
                                diff.n += 1
                                diff.change += compose(prevchar!)
                            default:
                                break
                            }
                        }
                    }
                case .종:
                    let jong = cho_jong
                    if 중.isEmpty {
                        diff.n += apply_compose(중, jung, prev).n
                        prevjamo = jung
                    } else {
                        var cont = true
                        if let pr = prevjamo {
                            if case .모 = pr.type {
                                if let _ = applicalbe(pr.sound, jamo: jung, prevjamo: prevjamo) {
                                    diff.n += apply_compose(pr.sound, jung, prev).n
                                    cont = false
                                }
                            }
                        }
                        if cont {
                            diff.n += apply_compose(종, jong, prev).n
                            prevjamo = jong
                        }
                    }
                    diff.change += compose(prevchar!)
                default:
                    break
                }
            case (_, .Special(.BACKSPACE)):
                let df = remove_prev_input_diff(prev)
                diff.n += df.n
                diff.change += df.change
            default:
                break
            }
        } else {
            switch jamo.type {
            case .Special(.BACKSPACE):
                diff.n -= 1
                if syllables.count > 0 {
                    syllables.removeLast()
                }
            case .Special:
                break
            case .Normal:
                prevchar = HanChar.normal(value: jamo.sound)
            case .초:
                pressed?(jamo)
                prevchar = HanChar.hangul(초: jamo.sound, 중: "", 종: "")
            case .중, .모:
                prevchar = HanChar.hangul(초: "", 중: jamo.sound, 종: "")
            case .종:
                prevchar = HanChar.hangul(초: "", 중: "", 종: jamo.sound)
            case let .갈(jung, cho_jong):
                switch cho_jong.type {
                case .초:
                    let cho = cho_jong
                    pressed?(cho)
                    prevchar = HanChar.hangul(초: cho.sound, 중: "", 종: "")
                    prevjamo = cho
                    diff.n += 1
                    diff.change += compose(prevchar!)
                    break
                case .종:
                    prevchar = HanChar.hangul(초: "", 중: jung.sound, 종: "")
                    prevjamo = jung
                    diff.n += 1
                    diff.change += compose(prevchar!)
                default:
                    break
                }
                break
            }
        }
        
        switch jamo.type {
        case .갈:
            break
        case .Special:
            prevjamo = nil
        default:
            diff.change += compose(prevchar!)
            prevjamo = jamo
        }
        return diff
    }
    
    
    internal func remove_prev_input_diff(prev: HanChar) -> AutomataDiff {

        var n: Int = -1
        var change: String = ""
        if case let .hangul(초, 중, 종) = prev {
            if let jamo = prevjamo {
                switch jamo.type {
                case .Special(_), .Normal:
                    if compose(prev).isEmpty {
                        if syllables.count > 0 {
                            syllables.removeLast()
                        }
                    } else {
                        n -= 1
                    }
                case .초:
                    prevchar = HanChar.hangul(초: "", 중: 중, 종: 종)
                case .중, .모:
                    prevchar = HanChar.hangul(초: 초, 중: "", 종: 종)
                case .종:
                    prevchar = HanChar.hangul(초: 초, 중: 중, 종: "")
                case .갈:
                    break
                }
                if case .Special = jamo.type {
                    if syllables.count > 0 {
                        syllables.removeLast()
                    }
                } else {

                    if let pr = prevchar {
                        let old = compose(pr)
                        if !old.isEmpty {
                            change += old
                        }
                    } else {
                    }
                }
            } else {
                prevchar = nil
                if syllables.count > 0 {
                    syllables.removeLast()
                }
            }
        } else {
            prevchar = nil
        }
        return AutomataDiff(n: n, change: change)
    }
        
    func input(key: SpecialKeyType) {
        automata_diff(Jamo(type: .Special(key: key), sound: ""))
    }
    
    func input(normal: String) {
        automata_diff(Jamo(type: .Normal, sound: normal))
    }
    
    func input(jamo: Jamo) {
        automata_diff(jamo)
    }
    
}