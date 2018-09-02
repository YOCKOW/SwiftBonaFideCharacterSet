/***************************************************************************************************
 BonaFideCharacterSetTests.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import XCTest
@testable import BonaFideCharacterSet

import Ranges

final class BonaFideCharacterSetTests: XCTestCase {
  func testExample() {
    let set = BonaFideCharacterSet(charactersIn:[AnyRange<Character>("A"..<"B"),
                                                 AnyRange<Character>("X"..<"Z")])
    
    XCTAssertTrue(set.contains("A"))
    
    #if swift(>=4.1.50)
    XCTAssertFalse(set.contains("A\u{0308}"))
    XCTAssertFalse(set.contains("\u{00C4}"))
    #else
    XCTAssertTrue(set.contains("A\u{0308}"))
    XCTAssertTrue(set.contains("\u{00C4}"))
    #endif
    
    XCTAssertFalse(set.contains("B"))
    
    XCTAssertTrue(set.contains("X"))
    XCTAssertFalse(set.contains("Z"))
  }
  
  func testFlags() {
    let flags = BonaFideCharacterSet(charactersIn:"\u{1f1e6}\u{1f1e6}"..."\u{1f1ff}\u{1f1ff}")
    XCTAssertTrue(flags.contains("🇯🇵"))
  }
  
  
  static var allTests = [
    ("testExample", testExample),
    ("testFlags", testFlags),
  ]
}

