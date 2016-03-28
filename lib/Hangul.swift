//
//  Hangul.swift
//  HangulSwift
//
//  Created by wookyoung on 2/1/16.
//  Copyright © 2016 factorcat. All rights reserved.
//

import Foundation

extension JamoArea {
    func johab_list() -> [(String, String, String, String)] {
        return [
            ("초", "ㄲ", "ㄱ" ,"ㄱ"),
            ("초", "ㄸ", "ㄷ" ,"ㄷ"),
            ("초", "ㅃ", "ㅂ" ,"ㅂ"),
            ("초", "ㅆ", "ㅅ" ,"ㅅ"),
            ("초", "ㅉ", "ㅈ" ,"ㅈ"),
            
            ("중", "ㅘ", "ㅗ", "ㅏ"),
            ("중", "ㅙ", "ㅗ", "ㅐ"),
            ("중", "ㅚ", "ㅗ", "ㅣ"),
            ("중", "ㅝ", "ㅜ", "ㅓ"),
            ("중", "ㅞ", "ㅜ", "ㅔ"),
            ("중", "ㅟ", "ㅜ", "ㅣ"),
            ("중", "ㅢ", "ㅡ", "ㅣ"),
            ("중", "ㅘ", "ㅏ", "ㅗ"), // rev
            ("중", "ㅙ", "ㅐ", "ㅗ"), // rev
            ("중", "ㅚ", "ㅣ", "ㅗ"), // rev
            ("중", "ㅝ", "ㅓ", "ㅜ"), // rev
            ("중", "ㅞ", "ㅔ", "ㅜ"), // rev
            ("중", "ㅟ", "ㅣ", "ㅜ"), // rev
            ("중", "ㅢ", "ㅣ", "ㅡ"), // rev
            ("중", "ㅔ", "ㅓ", "ㅣ"),
            ("중", "ㅐ", "ㅏ", "ㅣ"),
            ("중", "ㅖ", "ㅕ", "ㅣ"),
            ("중", "ㅒ", "ㅑ", "ㅣ"),
            ("중", "ㅙ", "ㅘ", "ㅣ"),
            ("중", "ㅞ", "ㅝ", "ㅣ"),
            
            ("종", "ㄲ", "ㄱ" ,"ㄱ"),
            ("종", "ㄳ", "ㄱ" ,"ㅅ"),
            ("종", "ㄵ", "ㄴ" ,"ㅈ"),
            ("종", "ㄶ", "ㄴ" ,"ㅎ"),
            ("종", "ㄺ", "ㄹ" ,"ㄱ"),
            ("종", "ㄻ", "ㄹ" ,"ㅁ"),
            ("종", "ㄼ", "ㄹ" ,"ㅂ"),
            ("종", "ㄽ", "ㄹ" ,"ㅅ"),
            ("종", "ㄾ", "ㄹ" ,"ㅌ"),
            ("종", "ㄿ", "ㄹ" ,"ㅍ"),
            ("종", "ㅀ", "ㄹ" ,"ㅎ"),
            ("종", "ㅄ", "ㅂ" ,"ㅅ"),
            ("종", "ㅆ", "ㅅ" ,"ㅅ"),
            ("종", "ㄳ", "ㅅ" ,"ㄱ"), // rev
            ("종", "ㄵ", "ㅈ" ,"ㄴ"), // rev
            ("종", "ㄶ", "ㅎ" ,"ㄴ"), // rev
            ("종", "ㄺ", "ㄱ" ,"ㄹ"), // rev
            ("종", "ㄻ", "ㅁ" ,"ㄹ"), // rev
            ("종", "ㄼ", "ㅂ" ,"ㄹ"), // rev
            ("종", "ㄽ", "ㅅ" ,"ㄹ"), // rev
            ("종", "ㄾ", "ㅌ" ,"ㄹ"), // rev
            ("종", "ㄿ", "ㅍ" ,"ㄹ"), // rev
            ("종", "ㅀ", "ㅎ" ,"ㄹ"), // rev
            ("종", "ㅄ", "ㅅ" ,"ㅂ"), // rev
        ]
    }
    
    func yethangul_list() -> [(String, String, String)] {
        return [
            ("초", "ㅿ", "\u{1140}"), // 317F
            ("초", "ㆁ", "\u{114C}"), // 3181
            ("초", "ㆆ", "\u{1159}"), // 3186
            ("초", "ㅥ", "\u{1114}"), // 3165
            ("초", "ㅦ", "\u{1115}"), // 3166
            ("초", "ㅧ", "\u{115B}"), // 3167
            ("초", "ㄵ", "\u{115C}"), // 3135
            ("초", "ㄶ", "\u{115D}"), // 3136
            ("초", "ㄺ", "\u{A964}"), // 313A
            ("초", "ㅪ", "\u{A966}"), // 316A
            ("초", "ㄻ", "\u{A968}"), // 313B
            ("초", "ㄼ", "\u{A969}"), // 313C
            ("초", "ㄽ", "\u{A96C}"), // 313D
            ("초", "ㅀ", "\u{111A}"), // 3140
            ("초", "ㅮ", "\u{111C}"), // 316E
            ("초", "ㅯ", "\u{A971}"), // 316F
            ("초", "ㅱ", "\u{111D}"), // 3171
            ("초", "ㅲ", "\u{111E}"), // 3172
            ("초", "ㅳ", "\u{1120}"), // 3173
            ("초", "ㅄ", "\u{1121}"), // 3144
            ("초", "ㅴ", "\u{1122}"), // 3174
            ("초", "ㅵ", "\u{1123}"), // 3175
            ("초", "ㅶ", "\u{1127}"), // 3176
            ("초", "ㅷ", "\u{1129}"), // 3177
            ("초", "ㅸ", "\u{112B}"), // 3178
            ("초", "ㅹ", "\u{112C}"), // 3179
            ("초", "ㅺ", "\u{112D}"), // 317A
            ("초", "ㅻ", "\u{112E}"), // 317B
            ("초", "ㅼ", "\u{112F}"), // 317C
            ("초", "ㅽ", "\u{1132}"), // 317D
            ("초", "ㅾ", "\u{1136}"), // 317E
            ("초", "ㆄ", "\u{1157}"), // 3184
            ("초", "ㆅ", "\u{1158}"), // 3185
            
            ("중", "ㆍ", "\u{119E}"), // 318D
            ("중", "ㆎ", "\u{11A1}"), // 318E
            ("중", "ㆇ", "\u{1184}"), // 3187
            
            ("종", "ㅿ", "\u{11EB}"), // 317F
            ("종", "ㆁ", "\u{11F0}"), // 3181
            ("종", "ㆆ", "\u{11F9}"), // 3186
            ("종", "ㅸ", "\u{11E6}"), // 3178
        ]
    }

}