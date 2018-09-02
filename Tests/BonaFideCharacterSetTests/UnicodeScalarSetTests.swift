/***************************************************************************************************
 UnicodeScalarSetTests.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import XCTest
@testable import BonaFideCharacterSet

import Ranges

final class UnicodeScalarSetTests: XCTestCase {
  func testInitialization() {
    let set1 = UnicodeScalarSet(unicodeScalarsIn:"0123456789")
    let set2 = UnicodeScalarSet(unicodeScalarsIn:"\u{0030}"..."\u{0039}")
    let set3 = UnicodeScalarSet(unicodeScalarsIn:"\u{002F}"<.<"\u{003A}")
    XCTAssertEqual(set1, set2)
    XCTAssertEqual(set1, set3)
  }
  
  static var allTests = [
    ("testInitialization", testInitialization),
  ]
}


