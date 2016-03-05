//
//  HangulInputSystemNormal.swift
//  HangulSwift
//
//  Created by wookyoung on 2/1/16.
//  Copyright © 2016 factorcat. All rights reserved.
//

//import XCTest

class HangulInputSystemNormal: WTestCase {

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