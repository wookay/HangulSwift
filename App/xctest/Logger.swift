//
//  Logger.swift
//  HangulSwift
//
//  Created by wookyoung on 3/27/16.
//  Copyright © 2016 factorcat. All rights reserved.
//

import Foundation


// MARK: Logger

class Logger {
    func info(args: Any..., file: StaticString = #file, function: String = #function, line: UInt = #line ) {
        let filename = (String(file) as NSString).lastPathComponent
        
        var str = ""
        str += "\(filename) #\(line) "
        str += "\(function)() "
        let length = args.count
        for (index, x) in args.enumerate() {
            str += String(x)
            if length==index+1 {
                
            } else {
                str += " "
            }
        }
        str += "\n"
        print(str)
    }
}

let Log = Logger()