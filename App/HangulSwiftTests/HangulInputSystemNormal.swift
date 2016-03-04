//
//  HangulInputSystemNormal.swift
//  HangulSwift
//
//  Created by wookyoung on 2/1/16.
//  Copyright © 2016 factorcat. All rights reserved.
//

//import XCTest

class HangulInputSystemNormal: WTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test감() {
        let system = HangulInputSystem()
        system.input(Jamo(type: .초, sound: "ㄱ"))
        Assert.equal("ㄱ", system.text)
        system.input("A")
        Assert.equal("ㄱA", system.text)
        system.input(.BACKSPACE)
        Assert.equal("ㄱ", system.text)
        system.input(Jamo(type: .중, sound: "ㅏ"))
        Assert.equal("ㄱㅏ", system.text)
        system.input(Jamo(type: .종, sound: "ㅁ"))
        Assert.equal("ㄱㅏ", system.text)
    }
    
    func test감자() {
        let system = HangulInputSystem()
        system.input(.BACKSPACE)
        system.input(Jamo(type: .초, sound: "ㄱ"))
        Assert.equal("ㄱ", system.text)
        system.input(.BACKSPACE)
        system.input(.BACKSPACE)
        Assert.equal("", system.text)
        system.input(Jamo(type: .중, sound: "ㅏ"))
        Assert.equal("ㅏ", system.text)
        system.input("A")
        Assert.equal("ㅏA", system.text)
        system.input(Jamo(type: .종, sound: "ㅁ"))
        Assert.equal("ㅏA", system.text)
        system.input("B")
        Assert.equal("ㅏAB", system.text)
        system.input(.BACKSPACE)
        Assert.equal("ㅏA", system.text)
        system.input(.BACKSPACE)
        Assert.equal("ㅏ", system.text)
        system.input(Jamo(type: .초, sound: "ㄱ"))
        Assert.equal("ㅏㄱ", system.text)
        system.input(.BACKSPACE)
        Assert.equal("ㅏ", system.text)
        system.input(.BACKSPACE)
        Assert.equal("", system.text)
        system.input(Jamo(type: .종, sound: "ㅁ"))
        Assert.equal("", system.text)
        system.input(Jamo(type: .중, sound: "ㅏ"))
        Assert.equal("ㅏ", system.text)
        system.input(Jamo(type: .초, sound: "ㄱ"))
        Assert.equal("감", system.text)
        system.input(Jamo(type: .초, sound: "ㅈ"))
        Assert.equal("감ㅈ", system.text)
        system.input(Jamo(type: .중, sound: "ㅏ"))
        Assert.equal("감자", system.text)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
