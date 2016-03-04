//
//  KeyMapperTests.swift
//  HangulSwift
//
//  Created by wookyoung on 2/2/16.
//  Copyright © 2016 factorcat. All rights reserved.
//

import Foundation
//import XCTest

class KeyMapperTests: WTestCase {
    
    func test390() {
        let path = [NSBundle.mainBundle().resourcePath!, "390-Sebulsik.txt"].joinWithSeparator("/")
        let rows = jamo_mapper_rows(path)
        Assert.equal(4, rows.count)
        var tested = 0
        if case let .종(sym, sound) = rows[0][2] {
            Assert.equal("!", sym)
            Assert.equal("ㅈ", sound)
            tested += 1
        }
        Assert.equal(1, tested)
    }
    
    func test391() {
        let path = [NSBundle.mainBundle().resourcePath!, "391-Sebulsik.txt"].joinWithSeparator("/")
        let rows = jamo_mapper_rows(path)
        Assert.equal(4, rows.count)
        var tested = 0
        if case let .종(sym, sound) = rows[0][2] {
            Assert.equal("!", sym)
            Assert.equal("ㄲ", sound)
            tested += 1
        }
        Assert.equal(1, tested)
    }
    
    func test3_2015() {
        let path = [NSBundle.mainBundle().resourcePath!, "3-2015.txt"].joinWithSeparator("/")
        let rows = jamo_mapper_rows(path)
        Assert.equal(4, rows.count)
        var tested = 0
        if case let .갈(sym, _, a, _, b) = rows[1][7] {
            Assert.equal("e", sym)
            Assert.equal("ㅕ", a)
            Assert.equal("ㅈ", b)
            tested += 1
        }
        Assert.equal(1, tested)
    }
    
    func testShinSebulsik_P() {
        let path = [NSBundle.mainBundle().resourcePath!, "ShinSebulsik-P.txt"].joinWithSeparator("/")
        let rows = jamo_mapper_rows(path)
        Assert.equal(4, rows.count)
        var tested = 0
        if case let .갈(sym, _, a, btype, b) = rows[1][17] {
            Assert.equal("i", sym)
            Assert.equal("ㅡ", a)
            Assert.equal("초", btype)
            Assert.equal("ㅁ", b)
            tested += 1
        }
        Assert.equal(1, tested)
    }

}