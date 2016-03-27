

class WHangulTestCase: WTestCase {
    let a = JamoArea()
    func 초성(sound: String) -> YetJamo {
        return 옛초(a.compatibility_to_scalar(.초, sound: sound)!)
    }
    func 중성(sound: String) -> YetJamo {
        return 옛중(a.compatibility_to_scalar(.중, sound: sound)!)
    }
    func 종성(sound: String) -> YetJamo {
        return 옛종(a.compatibility_to_scalar(.종, sound: sound)!)
    }
    func 갈마들이(lhs: YetJamo, _ rhs: YetJamo) -> YetJamo {
        return YetJamo(type: .갈(lhs, rhs), scalar: 빈스칼라)
    }
    func 모음(sound: String) -> YetJamo {
        return YetJamo(type: .모, scalar: a.compatibility_to_scalar(.중, sound: sound)!)
    }
    func 기호(sound: String) -> YetJamo {
        return YetJamo(type: .Normal(string: sound), scalar: 빈스칼라)
    }
}

//func 초성(sound: String) -> YetJamo {
//    return YetJamo(type: .초, scalar: sound.scalars.first!)
//}
//
//func 중성(sound: String) -> YetJamo {
//    return YetJamo(type: .중, scalar: sound.scalars.first!)
//}
//
//func 종성(sound: String) -> YetJamo {
//    return YetJamo(type: .종, scalar: sound.scalars.first!)
//}
//
//func 모음(sound: String) -> YetJamo {
//    return YetJamo(type: .모, scalar: sound.scalars.first!)
//}
//
//func 갈마들이(lhs: YetJamo, _ rhs: YetJamo) -> YetJamo {
//    return YetJamo(type: .갈(lhs, rhs), scalar: 빈스칼라)
//}
//
//func 기호(sound: String) -> YetJamo {
//    return YetJamo(type: .Normal, scalar: sound.scalars.first!)
//}
//
//
