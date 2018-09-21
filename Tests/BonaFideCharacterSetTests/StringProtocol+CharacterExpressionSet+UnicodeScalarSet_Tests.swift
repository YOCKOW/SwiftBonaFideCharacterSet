/* *************************************************************************************************
 StringProtocol+CharacterExpressionSet+UnicodeScalarSet_Tests.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import BonaFideCharacterSet

import Ranges

final class StringProtocol_CharacterExpressionSet_UnicodeScalarSet_Tests: XCTestCase {
  func testSplit() {
    let string = "AA01BB23CC45DD67"
    XCTAssertEqual(
      string.components(separatedBy:CharacterSet(charactersIn:"01234567890")),
      string.components(separatedBy:PrecomposedCharacterSet(charactersIn:"0"..."9"))
    )
    XCTAssertEqual(
      string.components(separatedBy:UnicodeScalarSet(unicodeScalarsIn:"0123456789")),
      string.components(separatedBy:PrecomposedCharacterSet(charactersIn:"0"..."9"))
    )
  }
  
  static var allTests = [
    ("testSplit", testSplit),
  ]
}


