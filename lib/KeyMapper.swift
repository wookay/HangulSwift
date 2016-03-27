//
//  JamoMapper.swift
//  HangulSwift
//
//  Created by wookyoung on 2/2/16.
//  Copyright © 2016 factorcat. All rights reserved.
//

import Foundation

public enum JamoLine {
//    case Empty
//    case Comment(String) // 주
    case Just(String)
    case Normal(String, String) // 외
    case 초(String, String)
    case 중(String, String)
    case 종(String, String)
    case 갈(String, String, String, String, String) // 갈마들이
    case 모(String, String) // 이중모음, 방점
    case 특(String)
}

func split_by(LF str: String) -> [String] {
    return str.componentsSeparatedByString("\n")
}

public class KeyMapper {

    public init() {
    }
    
    public func load_path(path: String) -> [[JamoLine]] {
        return parse(read_keymap_file(path))
    }
    
    public func load_string(str: String) -> [[JamoLine]] {
        return parse(str)
    }

    internal func read_keymap_file(path: String) -> String {
        do {
            return try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding) as String
        } catch {
        }
        return ""
    }
    
    internal func parse(str: String) -> [[JamoLine]] {
        let lines = split_by(LF: str)
        var rows = [[JamoLine]]()
        var row = [JamoLine]()
        for line in lines {
            if line == "" {
                // Empty
                if row.count > 0 {
                    rows.append(row)
                    row = [JamoLine]()
                }
            } else if line.hasPrefix("주") {
                // Comment
            } else {
                let item = line.componentsSeparatedByString(" ")
                switch item.count {
                case 1:
                    let sym = item[0]
                    row.append(.Just(sym))
                case 3,4:
                    let (sym, type, sound) = (item[0], item[1], item[2])
                    switch type {
                    case "초":
                         row.append(.초(sym, sound))
                    case "중":
                         row.append(.중(sym, sound))
                    case "종":
                         row.append(.종(sym, sound))
                    case "모":
                        row.append(.모(sym, sound))
                    case "특":
                        row.append(.특(sound))
                    default:
                        row.append(.Normal(sym, sound))
                    }
                case 6,7: // 갈마들이
                    let (sym, type, atype, a, btype, b) = (item[0], item[1], item[2], item[3], item[4], item[5])
                    if "갈" == type {
                        row.append(.갈(sym, atype, a, btype, b))
                    }
                default:
                    break
                }
            }
        }
        if row.count > 0 {
            rows.append(row)
        }
        return rows
    }
}

func jamo_mapper_rows(path: String) -> [[JamoLine]] {
    return KeyMapper().load_path(path)
}