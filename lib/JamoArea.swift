//
//  JamoArea.swift
//  HangulSwift
//
//  Created by wookyoung on 3/27/16.
//  Copyright © 2016 factorcat. All rights reserved.
//

import Foundation

// MARK: YetJamoType
public indirect enum YetJamoType: Equatable {
    case Normal(string: String)
    case Special(key: SpecialKeyType)
    case 초
    case 중
    case 종
    case 모
    case 갈(YetJamo, YetJamo)
}

public func ==(lhs: YetJamoType , rhs: YetJamoType) -> Bool {
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


// MARK: YetJamo
public struct YetJamo: Equatable {
    var type: YetJamoType
    var scalar: UnicodeScalar
}

public func ==(lhs: YetJamo, rhs: YetJamo) -> Bool {
    return lhs.type == rhs.type && lhs.scalar == rhs.scalar
}

extension YetJamo: CustomStringConvertible {
    public var description: String {
        get {
            switch type {
            case .초:
                if scalar == 빈초성 {
                    return "초"
                }
            case .중, .모:
                if scalar == 빈중성 {
                    return "\(type)"
                }
            case .종:
                if scalar == 빈종성 {
                    return "종"
                }
            default:
                break
            }
            return "\(type): \(scalar)"
        }
    }
}


// MARK: YetJamoSet
struct YetJamoSet: Equatable {
    var 초: YetJamo
    var 중: YetJamo
    var 종: YetJamo
}

func ==(lhs: YetJamoSet, rhs: YetJamoSet) -> Bool {
    return lhs.초 == rhs.초 && lhs.중 == rhs.중 && lhs.종 == rhs.종
}

extension YetJamoSet: CustomStringConvertible {
    var description: String {
        get {
            return "(\(초), \(중), \(종))"
        }
    }
}


// MARK: Bangjeom
let 거성마크 = "ᅟ〮"  // 115F 302E
let 상성마크 = "ᅟ〯"  // 115F 302F

public enum Bangjeom: UnicodeScalar, CustomStringConvertible {
    case 거성 = "\u{302E}" // One dot
    case 상성 = "\u{302F}" // Two dots
    
    public var description: String {
        get {
            switch self {
            case .거성: return "거성"
            case .상성: return "상성"
            }
        }
    }
}


// MARK: YetHanChar
enum YetHanChar {
    case normal(value: String)
    case yethangul(set: YetJamoSet, 방점: Bangjeom?)
}

func ==(lhs: YetHanChar, rhs: YetHanChar) -> Bool {
    if case let .normal(lvalue) = lhs, case let .normal(rvalue) = rhs {
        return lvalue == rvalue
    }
    if case let .yethangul(lset,lbang) = lhs, case let .yethangul(rset,rbang) = rhs {
        return lset == rset && lbang == rbang
    }
    return false
}



let 유니코드_가 = 0xAC00
let 유니코드_히흫 = 0xD7A3
let 초성오프셋 = 21 * 28
let 중성오프셋 = 28

let 초성표 = "ㄱ ㄲ ㄴ ㄷ ㄸ ㄹ ㅁ ㅂ ㅃ ㅅ ㅆ ㅇ ㅈ ㅉ ㅊ ㅋ ㅌ ㅍ ㅎ".componentsSeparatedByString(" ")
let 중성표 = "ㅏ ㅐ ㅑ ㅒ ㅓ ㅔ ㅕ ㅖ ㅗ ㅘ ㅙ ㅚ ㅛ ㅜ ㅝ ㅞ ㅟ ㅠ ㅡ ㅢ ㅣ".componentsSeparatedByString(" ")
let 종성표 = [""] + "ㄱ ㄲ ㄳ ㄴ ㄵ ㄶ ㄷ ㄹ ㄺ ㄻ ㄼ ㄽ ㄾ ㄿ ㅀ ㅁ ㅂ ㅄ ㅅ ㅆ ㅇ ㅈ ㅊ ㅋ ㅌ ㅍ ㅎ".componentsSeparatedByString(" ")
let lower종성표: [UnicodeScalar] = [빈종성, "\u{11A8}", "\u{11A9}", "\u{11AA}", "\u{11AB}", "\u{11AC}", "\u{11AD}", "\u{11AE}", "\u{11AF}", "\u{11B0}", "\u{11B1}", "\u{11B2}", "\u{11B3}", "\u{11B4}", "\u{11B5}", "\u{11B6}", "\u{11B7}", "\u{11B8}", "\u{11B9}", "\u{11BA}", "\u{11BB}", "\u{11BC}", "\u{11BD}", "\u{11BE}", "\u{11BF}", "\u{11C0}", "\u{11C1}", "\u{11C2}"]

let 초성채움 = "\u{115F}"
let 중성채움 = "\u{1160}"
let 초성영역 = 0x1100
let 중성영역 = 0x1161
let 빈스칼라: UnicodeScalar = "\u{0}"


public enum SpecialKeyType: Int32 {
    case BACKSPACE = 8
    case TAB = 9
    case RETURN = 13
    case SHIFT = 15
    case SPACE = 32
    case NEXT_INPUT_MODE = 1000
    case KEYMAP = 1001
    case NOTHING = -1
}

public struct AutomataDiff {
    public var n: Int
    public var change: String
}



let 빈한글 = "\u{3164}"
let 빈초성 = UnicodeScalar("\u{115F}")
let 빈중성 = UnicodeScalar("\u{1160}")
let 빈종성 = UnicodeScalar("\u{0000}")

let 빈초 = YetJamo(type: .초, scalar: 빈초성)
let 빈중 = YetJamo(type: .중, scalar: 빈중성)
let 빈종 = YetJamo(type: .종, scalar: 빈종성)
let 빈자모셑 = YetJamoSet(초: 빈초, 중: 빈중, 종: 빈종)

extension String {
    var scalars: [UnicodeScalar] {
        get {
            return unicodeScalars.map { $0 }
        }
    }
}

func isEmpty(yet: YetJamo) -> Bool {
    switch yet.type {
    case .초:
        return 빈초성 == yet.scalar
    case .중, .모:
        return 빈중성 == yet.scalar
    case .종:
        return 빈종성 == yet.scalar
    default:
        return false
    }
}

func 옛초(scalar: UnicodeScalar) -> YetJamo {
    return YetJamo(type: .초, scalar: scalar)
}

func 옛중(scalar: UnicodeScalar) -> YetJamo {
    return YetJamo(type: .중, scalar: scalar)
}

func 옛종(scalar: UnicodeScalar) -> YetJamo {
    return YetJamo(type: .종, scalar: scalar)
}

class JamoArea {
    var yethangul_compatdict = [String: UnicodeScalar]()
    var yethangul_scalardict = [String: UnicodeScalar]()
    var johab_dict: [String: UnicodeScalar] = [String: UnicodeScalar]()
    var dejohab_dict: [String: UnicodeScalar] = [String: UnicodeScalar]()
    
    init() {
        yethangul_routine(yethangul_list())
        doensori_routine(johab_list())
    }
    
    func yethangul_routine(list: [(String, String, String)]) {
        for (a,b,c) in list {
            yethangul_compatdict[a + b] = c.unicodeScalars.first
            yethangul_scalardict[a + c] = b.unicodeScalars.first
        }
    }
    
    func doensori_routine(list: [(String, String, String, String)], custom: Bool = false) {
        for (a,b,c,d) in list {
            let type = yetjamotype(a)
            if let yb = proper_scalar(type, sound: b),
                let yc = proper_scalar(type, sound: c),
                let yd = proper_scalar(type, sound: d) {
                johab_dict[a + String(yc) + String(yd)] = yb
                if !custom {
                    dejohab_dict[a + String(yb) + String(yd)] = yc
                }
            } else {
                Log.info("else", a, b, c, d)
            }
        }
    }
    
    
    // MARK: 방점
    func scalar_to_bangjeom(scalar: UnicodeScalar) -> Bangjeom? {
        switch scalar {
        case "\u{302E}":
            return .거성
        case "\u{302F}":
            return .상성
        default:
            return nil
        }
    }
    
    func bangjeom_to_compatibility(방점 type: Bangjeom) -> String {
        switch type {
        case .거성:
            return "·"
        case .상성:
            return ":"
        }
    }
    
    func jamo_to_sound(jamo: YetJamo) -> String {
        if let compat = scalar_to_compatibility(jamo.type, scalar: jamo.scalar) {
            return compat
        } else {
            return String(jamo.scalar)
        }
    }
    
    func scalar_to_compatibility(type: YetJamoType, scalar: UnicodeScalar) -> String? {
        if let com = compact(type, scalar: scalar) {
            return com
        } else {
            if let compat = yethangul_scalardict[String(type) + String(scalar)] {
                return String(compat)
            } else {
                return nil
            }
        }
    }
    
    func proper_scalar(type: YetJamoType, sound: String) -> UnicodeScalar? {
        if let compat = compatibility_to_scalar(type, sound: sound) {
            return compat
        } else {
            return sound.unicodeScalars.first
        }
    }
    
    func compatibility_to_scalar(type: YetJamoType, sound: String) -> UnicodeScalar? {
        switch type {
        case .초:
            if let 값 = 초성표.indexOf(sound) {
                return UnicodeScalar(초성영역 + 값)
            }
        case .중:
            if let 값 = 중성표.indexOf(sound) {
                return UnicodeScalar(중성영역 + 값)
            }
        case .모:
            switch sound {
            case 거성마크:
                return Bangjeom.거성.rawValue
            case 상성마크:
                return Bangjeom.상성.rawValue
            default:
                if let 값 = 중성표.indexOf(sound) {
                    return UnicodeScalar(중성영역 + 값)
                }
            }
        case .종:
            if let idx = 종성표.indexOf(sound) {
                return lower종성표[idx]
            }
        default:
            break
        }
        return yethangul_compatdict[String(type) + sound]
    }
    
    func compact(type: YetJamoType, scalar: UnicodeScalar) -> String? {
        switch type {
        case .초:
            let idx = Int(scalar.value - UInt32(초성영역))
            if idx >= 0 && 초성표.count > idx {
                return 초성표[idx]
            } else {
                return nil
            }
        case .중, .모:
            let idx: Int = Int(scalar.value - UInt32(중성영역))
            if idx >= 0 && 중성표.count > idx {
                return 중성표[idx]
            } else {
                return nil
            }
        case .종:
            if let idx = lower종성표.indexOf(scalar) {
                return 종성표[idx]
            } else {
                return nil
            }
        default:
            return nil
        }
    }
    
    func compose(syllable: YetHanChar) -> String {
        switch syllable {
        case let .normal(value) :
            return value
        case let .yethangul(set, bangjeom):
            return compose_jamoset(set, bangjeom)
        }
    }
    
    func compose_jamoset(set: YetJamoSet, _ bangjeom: Bangjeom?) -> String {
        let (초성, 중성, 종성) = (set.초, set.중, set.종)
        if nil == bangjeom {
            switch (초성.scalar, 중성.scalar, 종성.scalar) {
            case (빈초성, 빈중성, 빈종성):
                return ""
            case (초성.scalar, 빈중성, 빈종성):
                if let compat = scalar_to_compatibility(.초, scalar: 초성.scalar) {
                    return compat
                }
            case (빈초성, 중성.scalar, 빈종성):
                if let compat = scalar_to_compatibility(.중, scalar: 중성.scalar) {
                    return compat
                }
            case (빈초성, 빈중성, 종성.scalar):
                break
            case (빈초성, 중성.scalar, 종성.scalar):
                break
            case (초성.scalar, 빈중성, 종성.scalar):
                break
            case (초성.scalar, 중성.scalar, 빈종성):
                if let _ = compact(.초, scalar: 초성.scalar),
                    let _ = compact(.중, scalar: 중성.scalar) {
                    let 초값 = Int(초성.scalar.value - UInt32(초성영역))
                    let 중값 = Int(중성.scalar.value - UInt32(중성영역))
                    return String(UnicodeScalar(유니코드_가 + 초성오프셋 * 초값 + 중성오프셋 * 중값))
                }
            default:
                if let _ = compact(.초, scalar: 초성.scalar),
                    let _ = compact(.중, scalar: 중성.scalar),
                    let 종값 = lower종성표.indexOf(종성.scalar) {
                    let 초값 = Int(초성.scalar.value - UInt32(초성영역))
                    let 중값 = Int(중성.scalar.value - UInt32(중성영역))
                    return String(UnicodeScalar(유니코드_가 + 초성오프셋 * 초값 + 중성오프셋 * 중값 + 종값))
                }
            }
        }
        
        let bang = (nil == bangjeom) ? "" : String(bangjeom!.rawValue)
        switch (초성.scalar, 중성.scalar, 종성.scalar) {
        case (빈초성, 빈중성, 빈종성):
            if let jeom = bangjeom {
                return bangjeom_to_compatibility(방점: jeom)
            } else {
                return ""
            }
        case (초성.scalar, 빈중성, 빈종성):
            return String(초성.scalar) + 중성채움 + bang
        case (빈초성, 중성.scalar, 빈종성):
            return 초성채움 + String(중성.scalar) + bang
        case (빈초성, 빈중성, 종성.scalar):
            return 초성채움 + 중성채움 + String(종성.scalar) + bang
        case (빈초성, 중성.scalar, 종성.scalar):
            return 초성채움 + String(중성.scalar) + String(종성.scalar) + bang
        case (초성.scalar, 빈중성, 종성.scalar):
            return String(초성.scalar) + 중성채움 + String(종성.scalar) + bang
        case (초성.scalar, 중성.scalar, 빈종성):
            return String(초성.scalar) + String(중성.scalar) + bang
        default:
            return String(초성.scalar) + String(중성.scalar) + String(종성.scalar) + bang
        }
    }
    
    func decompose_yethangul(seq: String) -> YetHanChar {
        let scalars = seq.scalars
        switch scalars.count {
        case 2:
            return .yethangul(set: YetJamoSet(초: 옛초(scalars[0]), 중: 옛중(scalars[1]), 종: 빈종), 방점: nil)
        case 3:
            return .yethangul(set: YetJamoSet(초: 옛초(scalars[0]), 중: 옛중(scalars[1]), 종: 옛종(scalars[2])), 방점: nil)
        case 4:
            return .yethangul(set: YetJamoSet(초: 옛초(scalars[1]), 중: 옛중(scalars[2]), 종: 옛종(scalars[3])), 방점: scalar_to_bangjeom(scalars[0]))
        default:
            return YetHanChar.normal(value: seq)
        }
    }
    
    func decompatibility(type: String, sound: String) -> YetJamo {
        switch type {
        case "초":
            if let scalar = proper_scalar(.초, sound: sound) {
                return YetJamo(type: .초, scalar: scalar)
            }
        case "중":
            if let scalar = proper_scalar(.중, sound: sound) {
                return YetJamo(type: .중, scalar: scalar)
            }
        case "모":
            if let scalar = proper_scalar(.모, sound: sound) {
                return YetJamo(type: .모, scalar: scalar)
            }
        case "종":
            if let scalar = proper_scalar(.종, sound: sound) {
                return YetJamo(type: .종, scalar: scalar)
            }
        default:
            break
        }
        return YetJamo(type: .Normal(string: sound), scalar: 빈스칼라)
    }
    
    func decompose_hangul(cha: String) -> YetHanChar {
        let scalars = cha.unicodeScalars
        var 값 :Int = Int(scalars[scalars.startIndex].value)
        if 값 >= 유니코드_가 && 값 <= 유니코드_히흫 {
            값 -= 유니코드_가
            let 초성인덱스 = (값 / 초성오프셋)
            값 %= 초성오프셋
            let (중성인덱스, 종성인덱스) = ((값 / 중성오프셋), (값 % 중성오프셋))
            var 종성: YetJamo = 빈종
            if 0 != 종성인덱스 {
                if let scalar: UnicodeScalar = lower종성표[종성인덱스] {
                    종성.scalar = scalar
                }
            }
            let set = YetJamoSet(초: 옛초(UnicodeScalar(초성영역.advancedBy(초성인덱스))), 중: 옛중(UnicodeScalar(중성영역.advancedBy(중성인덱스))), 종: 종성)
            return .yethangul(set: set, 방점: nil)
        } else {
            return .normal(value: cha)
        }
    }
    
    internal func nameof(type: YetJamoType) -> String {
        switch type {
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
    
    internal func yetjamotype(value: String) -> YetJamoType {
        switch value {
        case "초":
            return .초
        case "중":
            return .중
        case "종":
            return .종
        default:
            return .Normal(string: value)
        }
    }
    
    func deapplicable(prevjamo: YetJamo, jamo: YetJamo) -> UnicodeScalar? {
        return dejohab_dict[nameof(jamo.type) + String(prevjamo.scalar) + String(jamo.scalar)]
    }
    
    func applicable(prevjamo: YetJamo, jamo: YetJamo) -> UnicodeScalar? {
        return johab_dict[nameof(jamo.type) + String(prevjamo.scalar) + String(jamo.scalar)]
    }
}