//
//  HanCharTests.swift
//  HangulSwift
//
//  Created by wookyoung on 2/1/16.
//  Copyright © 2016 factorcat. All rights reserved.
//

//import XCTest

class HanCharTests: WTestCase {

    func testHangul() {
        let 감: HanChar = "감".hanchar
        if case let .hangul(set) = 감 {
            Assert.equal("ㄱ", set.초.sound)
            Assert.equal("ㅏ", set.중.sound)
            Assert.equal("ㅁ", set.종.sound)
        }
        
        let 가: HanChar = "가".hanchar
        if case let .hangul(set) = 가 {
            Assert.equal("ㄱ",set.초.sound)
            Assert.equal("ㅏ", set.중.sound)
            Assert.equal("", set.종.sound)
        }
    }
    
    func testNormal() {
        let A: HanChar = "A".hanchar
        if case let .normal(value) = A {
            Assert.equal("A", value)
        }
    }

}
