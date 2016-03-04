
func 초성(sound: String) -> Jamo {
    return Jamo(type: .초, sound: sound)
}

func 중성(sound: String) -> Jamo {
    return Jamo(type: .중, sound: sound)
}

func 종성(sound: String) -> Jamo {
    return Jamo(type: .종, sound: sound)
}

func 모음(sound: String) -> Jamo {
    return Jamo(type: .모, sound: sound)
}

func 갈마들이(lhs: Jamo, _ rhs: Jamo) -> Jamo {
    return Jamo(type: .갈(lhs, rhs), sound: "")
}

func 기호(sound: String) -> Jamo {
    return Jamo(type: .Normal, sound: sound)
}