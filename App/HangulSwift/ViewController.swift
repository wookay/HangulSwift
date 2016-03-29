//
//  ViewController.swift
//  HangulSwift
//
//  Created by wookyoung on 2/1/16.
//  Copyright © 2016 factorcat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let result = UnitTest.run(only: ["JamoAreaTests", "KeyMapperTests", "HanCharTests", "HangulGalmadlyTests", "YetHangulInputSystem", "YetHangulInputSystemUnicode52", "HangulInputSystemTests"])
        if result.failed > 0 {
            self.view.backgroundColor = UIColor(red: 215/255, green: 50/255, blue: 50/255, alpha: 1)
        } else if result.passed > 0 {
            self.view.backgroundColor = UIColor(red: 0, green: 155/255, blue: 0, alpha: 1)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

