HangulSwift
===========

  * Hangul Automata for Sebul Keyboard
    https://itunes.apple.com/en/app/id428835384?mt=8


  [![Build Status](https://api.travis-ci.org/wookay/HangulSwift.svg?branch=master)](https://travis-ci.org/wookay/HangulSwift)


```sh
$ open App/HangulSwift.xcodeproj
```

```swift
        let system = HangulInputSystem()
        system.input(Jamo(type: .초, sound: "ㄱ"))
        XCTAssertEqual("ㄱ", system.text)
        system.input(Jamo(type: .중, sound: "ㅏ"))
        XCTAssertEqual("가", system.text)
        system.input(Jamo(type: .종, sound: "ㅁ"))
        XCTAssertEqual("감", system.text)
```
