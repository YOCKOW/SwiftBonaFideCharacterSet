/* *************************************************************************************************
 StringProtocol+CharacterExpressionSetTests.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import BonaFideCharacterSet

import Ranges

final class StringProtocol_CharacterExpressionSetTests: XCTestCase {
  func testSplit() {
    let string = "AA01BB23CC45DD67"
    XCTAssertEqual(
      string.components(separatedBy:CharacterSet(charactersIn:"01234567890")),
      string.components(separatedBy:PrecomposedCharacterSet(charactersIn:"0"..."9"))
    )
  }
  
  static var allTests = [
    ("testSplit", testSplit),
  ]
}


