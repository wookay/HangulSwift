//
//  ViewController.swift
//  HangulSwift
//
//  Created by wookyoung on 2/1/16.
//  Copyright © 2016 factorcat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//         UnitTest.run(only: ["HangulGalmadlyTests"])
        UnitTest.run(only: ["JamoAreaTests", "KeyMapperTests", "HanCharTests", "HangulGalmadlyTests", "YetHangulInputSystem", "YetHangulInputSystemUnicode52", "HangulInputSystemTests"])
        
        let a = JamoArea()        
        
        let 나 = a.decompose_hangul("나")
        let 랏 = YetHanChar.yethangul(set: YetJamoSet(초: 옛초("\u{1105}"), 중: 옛중("\u{1161}"), 종: 옛종("\u{11BA}")), 방점: .거성)
        let 말 = YetHanChar.yethangul(set: YetJamoSet(초: 옛초("\u{1106}"), 중: 옛중("\u{1161}"), 종: 옛종("\u{11AF}")), 방점: .상성)
        let 싸 = YetHanChar.yethangul(set: YetJamoSet(초: 옛초("\u{110A}"), 중: 옛중("\u{119E}"), 종: 빈종), 방점: nil)
        let 미 = YetHanChar.yethangul(set: YetJamoSet(초: 옛초("\u{1106}"), 중: 옛중("\u{1175}"), 종: 빈종), 방점: .거성)
        
        label.text = [나,랏,말,싸,미].map({ set in a.compose(set) }).joinWithSeparator("")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

