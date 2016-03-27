//
//  HangulInputSystem.swift
//  HangulSwift
//
//  Created by wookyoung on 3/27/16.
//  Copyright © 2016 factorcat. All rights reserved.
//

import Foundation

public struct Jamo {
    var type: YetJamoType
    var sound: String
}

public class HangulInputSystem {
    let area = JamoArea()
    
    public var syllables =  [String]()
    var hangul: YetJamoSet = 빈자모셑
    var prevjamo: YetJamo? = nil
    var bangjeom: Bangjeom? = nil
    
    var last_backspace: Bool = false
    public var pressed: ((YetJamo)->Void)? = nil
    
    func debug(s: String = "") {
        Log.info("hangul\(s)", hangul, "prevjamo", prevjamo, "last_backspace", last_backspace, "syllables", syllables)
    }

    var text: String {
        let str = syllables.joinWithSeparator("")
        return str + area.compose(YetHanChar.yethangul(set: hangul, 방점: bangjeom))
    }
    
    public init() {
    }

    func append_syllable(set: YetJamoSet) -> Int {
        let cha = area.compose(YetHanChar.yethangul(set: set, 방점: bangjeom))
        syllables.append(cha)
        if let _ = bangjeom {
            bangjeom = nil
        }
        return 1
    }

    
    func append_syllable(normal: String) -> Int {
        let cha = area.compose(.normal(value: normal))
        syllables.append(cha)
        if let _ = bangjeom {
            bangjeom = nil
        }
        return 1
    }
    
    func apply_compose(jamoset: YetJamoSet, jamo: YetJamo) -> (YetJamoSet, Int) {
        var set = jamoset
        var n: Int = -1
        switch jamo.type {
        case .초:
            if isEmpty(set.초) {
                pressed?(jamo)
                set.초 = jamo
            } else {
                if isEmpty(set.중) {
                    if let applied = area.applicable(set.초, jamo: jamo) {
                        pressed?(jamo)
                        set.초 = YetJamo(type: .초, scalar: applied)
                    } else {
                        pressed?(jamo)
                        n += append_syllable(hangul)
                        set.초 = jamo
                        set.중.scalar = 빈중성
                        set.종.scalar = 빈종성
                    }
                } else {
                    pressed?(jamo)
                    set.초 = jamo
                    set.중.scalar = 빈중성
                    set.종.scalar = 빈종성
                    n += append_syllable(hangul)
                }
            }
        case .중, .모:
            if let applied = area.applicable(set.중, jamo: jamo) {
                if isEmpty(set.종) {
                    set.중 = YetJamo(type: .중, scalar: applied)
                } else {
                    set.초.scalar = 빈초성
                    set.중 = jamo
                    set.종.scalar = 빈종성
                    n += append_syllable(hangul)
                }
            } else {
                if isEmpty(set.중) {
                    set.중 = jamo
                } else {
                    set.초.scalar = 빈초성
                    set.중 = jamo
                    set.종.scalar = 빈종성
                    n += append_syllable(hangul)
                }
            }
        case .종:
            if let applied = area.applicable(set.종, jamo: jamo) {
                set.종 = YetJamo(type: .종, scalar: applied)
            } else {
                if isEmpty(set.종) {
                    set.종 = jamo
                } else {
                    set.초.scalar = 빈초성
                    set.중.scalar = 빈중성
                    set.종 = jamo
                    n += append_syllable(hangul)
                }
            }
        default:
            break
        }
        prevjamo = jamo
        hangul = set
        return (set, n)
    }
    
    func galma(jamoset: YetJamoSet, _ lhs: YetJamo, _ rhs: YetJamo) -> (YetJamoSet, Int) {
        var set = jamoset
        var n: Int = -1
        switch rhs.type {
        case .초:
            if isEmpty(set.초) {
                pressed?(rhs)
                set.초 = rhs
                prevjamo = rhs
                hangul = set
            } else {
                if isEmpty(jamoset.중) {
                    (set, n) = apply_compose(set, jamo: lhs)
                } else {
                    if let applied = area.applicable(set.초, jamo: rhs) {
                        pressed?(rhs)
                        set.초 = YetJamo(type: .초, scalar: applied)
                        prevjamo = rhs
                        hangul = set
                    } else {
                        (set, n) = apply_compose(jamoset, jamo: rhs)
                    }
                }
            }
        case .종:
            if isEmpty(set.중) {
                set.중 = lhs
                prevjamo = lhs
                hangul = set
            } else {
                if case .모 = set.중.type {
                    if let applied = area.applicable(set.중, jamo: lhs) {
                        set.중 = YetJamo(type: .중, scalar: applied)
                        prevjamo = lhs
                        hangul = set
                    } else {
                        (set, n) = apply_compose(set, jamo: rhs)
                    }
                } else {
                    if isEmpty(set.종) {
                        (set, n) = apply_compose(set, jamo: rhs)
                    } else {
                        if let applied = area.applicable(set.종, jamo: rhs) {
                            set.종 = YetJamo(type: .종, scalar: applied)
                            prevjamo = rhs
                            hangul = set
                        } else {
                            (set, n) = apply_compose(set, jamo: lhs)
                        }
                    }
                }
            }
        default:
            break
        }
        return (set, n)
    }
    
    func backspace_remove() -> AutomataDiff {
        if let _ = bangjeom {
//            let old = area.compose(.yethangul(set: hangul, 방점: bangjeom))
            bangjeom = nil
            let newer = area.compose(.yethangul(set: hangul, 방점: bangjeom))
//            if old != newer {
//                let change = newer
//                return AutomataDiff(n: -old.characters.count, change: change)
//            }
            return AutomataDiff(n: -1, change: newer)
        }
        var diff = AutomataDiff(n: 0, change: "")
        if last_backspace {
            let cha = area.compose(.yethangul(set: hangul, 방점: bangjeom))
            if cha.isEmpty {
                if syllables.count > 0 {
                    syllables.removeLast()
                }
            } else {
                hangul = 빈자모셑
                if let _ = prevjamo {
                    prevjamo = nil
                }
            }
            diff.n -= 1
        } else {
            last_backspace = true
            var set = hangul
            let cha = area.compose(.yethangul(set: set, 방점: bangjeom))
            if cha.containsUnicode52 {
                diff.n += 1
                diff.n -= cha.unicodeScalars.count
            }
            if let prev = prevjamo {
                switch prev.type {
                case .초:
                    if let dejohab = area.deapplicable(set.초, jamo: prev) {
                        set.초.scalar = dejohab
                    } else {
                        set.초.scalar = 빈초성
                    }
                case .중, .모:
                    if let dejohab = area.deapplicable(set.중, jamo: prev) {
                        set.중 = YetJamo(type: .모, scalar: dejohab)
                    } else {
                        set.중.scalar = 빈중성
                    }
                    if !isEmpty(set.종) {
                        prevjamo = set.종
                    } else if !isEmpty(set.초) {
                        prevjamo = set.초
                    } else {
                        prevjamo = nil
                    }
                case .종:
                    if let dejohab = area.deapplicable(set.종, jamo: prev) {
                        set.종.scalar = dejohab
                    } else {
                        set.종.scalar = 빈종성
                    }
                default:
                    if syllables.count > 0 {
                        syllables.removeLast()
                    }
                }
                hangul = set
                diff.change += area.compose(.yethangul(set: hangul, 방점: bangjeom))
                diff.n -= 1
            }
        }
        return diff
    }
    
    public func automata_diff(bang: Bangjeom) -> AutomataDiff {
        let old = area.compose(.yethangul(set: hangul, 방점: bangjeom))
        var was상성 = false
        if let jeom = bangjeom {
            was상성 = jeom == .상성
        }
        if bang == .거성 && was상성 {
            bangjeom = nil
        } else {
            bangjeom = bang
        }
        let newer = area.compose(.yethangul(set: hangul, 방점: bangjeom))
        if old == newer {
            return AutomataDiff(n: 0, change: "")
        } else {
            let change = newer
            return AutomataDiff(n: -old.characters.count, change: change)
        }
    }
    
    public func automata_diff(jam: YetJamo) -> AutomataDiff {
        var diff = AutomataDiff(n: 0, change: "")
        if case .Special(.BACKSPACE) = jam.type {
            diff = backspace_remove()
        } else {
            var jamo: YetJamo = jam
            switch jam.type {
            case .모:
                if let bang = area.scalar_to_bangjeom(jam.scalar) {
                    return automata_diff(bang)
                }
            case .Special(.RETURN):
                jamo = YetJamo(type: .Normal(string: "\n"), scalar: 빈스칼라)
            case .Special(.SPACE):
                jamo = YetJamo(type: .Normal(string: " "), scalar: 빈스칼라)
            case .Special(.TAB):
                jamo = YetJamo(type: .Normal(string: "\t"), scalar: 빈스칼라)
            default:
                break
            }
            
            last_backspace = false
            var set = hangul
            let cha = area.compose(.yethangul(set: set, 방점: bangjeom))
            if cha.isEmpty {
                diff.n += 1
            } else {
                if cha.containsUnicode52 {
                    diff.n += 1
                    diff.n -= cha.unicodeScalars.count
                }
            }
            
            var n = 0
            switch jamo.type {
            case .초, .중, .모, .종:
                let cnt = syllables.count
                (set, n) = apply_compose(set, jamo: jamo)
                if syllables.count > cnt {
                    if cha.containsUnicode52 {
                        diff.n = 0
                    }
                }
                diff.n += n
            case let .갈(lhs, rhs):
                (set, n) = galma(set, lhs, rhs)
                diff.n += n
            case let .Normal(string):
                prevjamo = jamo
                diff.n -= 1
                if !area.compose(.yethangul(set: hangul, 방점: bangjeom)).isEmpty {
                    diff.n += append_syllable(hangul)
                }
                append_syllable(string)
                hangul = 빈자모셑
                diff.change += string
            default:
                break
            }
            diff.change += area.compose(.yethangul(set: hangul, 방점: bangjeom))
        }
        return diff
    }
    
    public func input(key: SpecialKeyType) -> AutomataDiff {
        return automata_diff(YetJamo(type: .Special(key: key), scalar: 빈스칼라))
    }
    
    public func input(normal: String) -> AutomataDiff {
        return automata_diff(YetJamo(type: .Normal(string: normal), scalar: 빈스칼라))
    }
    
    public func input(jamo: YetJamo) -> AutomataDiff {
        return automata_diff(jamo)
    }
    
    public func input(bang: Bangjeom) -> AutomataDiff {
        return automata_diff(bang)
    }
    
    public func input(jam: Jamo) -> AutomataDiff {
        if let scalar = area.proper_scalar(jam.type, sound: jam.sound) {
            return automata_diff(YetJamo(type: jam.type, scalar: scalar))
        } else {
            return AutomataDiff(n: 0, change: "")
        }
    }
}


extension String {
    var containsUnicode52: Bool {
        return
            self.unicodeScalars.contains { scalar in
            [
                (0x115A...0x115E),
                //                (0x11A3...0x11A7),
                (0x11FA...0x11FF),
                (0xA960...0xA97C),
                (0xD7B0...0xD7FB),
                ].contains { $0.contains(scalar.value) }
        }
    }
}