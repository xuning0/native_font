//
//  SwiftUsage.swift
//  Runner
//
//  Created by XuNing on 2023/3/2.
//

import Foundation
import native_font

@objc public class SwiftUsage : NSObject {
  @objc public static func configNativeFontForFlutterInSwift() {
    NativeFontPlugin.fontDataHandler = { (familyName, weight, isItalic, callback) in
      if familyName == "Roboto" {
        var fileName = "Roboto-Regular.ttf"
        if weight == FlutterFontWeight.weight700 {
          fileName = isItalic ? "Roboto-BoldItalic.ttf" : "Roboto-Bold.ttf"
        } else if weight == FlutterFontWeight.weight400 {
          fileName = isItalic ? "Roboto-Italic.ttf" : "Roboto-Regular.ttf"
        } else if weight == FlutterFontWeight.weight500 {
          fileName = "Roboto-Medium.ttf"
        }
        callback(try! Data(contentsOf: Bundle.main.url(forResource: fileName, withExtension: nil)!))
      } else if familyName == "Caveat" {
        mockDownload(completion: callback)
      }
    }
  }
  
  static func mockDownload(completion: @escaping (Data) -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
      completion(try! Data(contentsOf: Bundle.main.url(forResource: "Caveat-Regular.ttf", withExtension: nil)!))
    }
  }
}

