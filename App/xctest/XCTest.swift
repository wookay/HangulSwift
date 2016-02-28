//
//  XCTest.swift
//  Test
//
//  Created by wookyoung on 2/22/16.
//  Copyright © 2016 factorcat. All rights reserved.
//

import Foundation

import XCTest
typealias WTestCase = XCTestCase

class AssertBase {

    func equal<T: Equatable>(expression1: T?, _ expression2: T?, _ message: String = "", file: StaticString = __FILE__, function: String = __FUNCTION__, line: UInt = __LINE__) {
        XCTAssertEqual(expression1, expression2, message)
    }
    
    func equal<T: Equatable>(expression1: T, _ expression2: T, _ message: String = "", file: StaticString = __FILE__, function: String = __FUNCTION__, line: UInt = __LINE__) {
        XCTAssertEqual(expression1, expression2, message)
    }
 
    func equal<T: Equatable>(expression1: [T], _ expression2: [T], _ message: String = "", file: StaticString = __FILE__, function: String = __FUNCTION__, line: UInt = __LINE__) {
        XCTAssertEqual(expression1, expression2, message)
    }
    
    func equal<T: Equatable>(expression1: ArraySlice<T>, _ expression2: ArraySlice<T>, _ message: String = "", file: StaticString = __FILE__, function: String = __FUNCTION__, line: UInt = __LINE__) {
        XCTAssertEqual(expression1, expression2, message)
    }
    
    func True(expression: BooleanType, _ message: String = "", file: StaticString = __FILE__, function: String = __FUNCTION__, line: UInt = __LINE__) {
        XCTAssertTrue(expression, message)
    }
    
    // (Int, Int)
    func equal(expression1: (Int,Int), _ expression2: (CGFloat, CGFloat), _ message: String = "", file: StaticString = __FILE__, function: String = __FUNCTION__, line: UInt = __LINE__) {
        let a = (CGFloat(expression1.0), CGFloat(expression1.1))
        equal(a, expression2)
    }
    
    func equal(expression1: (CGFloat,CGFloat), _ expression2: (CGFloat, CGFloat), _ message: String = "", file: StaticString = __FILE__, function: String = __FUNCTION__, line: UInt = __LINE__) {
        XCTAssertEqual(String(expression1), String(expression2), message)
    }

    // NSRange
    func equal(expression1: NSRange, _ expression2: NSRange, _ message: String = "", file: StaticString = __FILE__, function: String = __FUNCTION__, line: UInt = __LINE__) {
        XCTAssertEqual(String(expression1), String(expression2), message)
    }
}

let Assert = AssertBase()