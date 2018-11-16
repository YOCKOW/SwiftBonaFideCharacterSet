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
  
  func test_consistsOf() {
    let string = "AB⃝CD"
    
    let characters = BonaFideCharacterSet(charactersIn:"A"..."D")
    XCTAssertTrue(string.consists(of:characters))
    
    let scalars = UnicodeScalarSet(unicodeScalarsIn:"A"..."D")
    XCTAssertFalse(string.consists(of:scalars))
  }
  
  func test_trimming() {
    let string = "ABCDEFGFEDCBA"
    
    let characters = BonaFideCharacterSet(charactersIn:"A"..."D")
    let scalars = UnicodeScalarSet(unicodeScalarsIn:"A"..."D")
    
    XCTAssertEqual(string.trimmingCharacters(in:characters), "EFGFE")
    XCTAssertEqual(string.trimmingUnicodeScalars(in:scalars), "EFGFE")
    
    
    let characters2 = BonaFideCharacterSet(charactersIn:"A"..."Z")
    let scalars2 = UnicodeScalarSet(unicodeScalarsIn:"A"..."Z")
    
    XCTAssertEqual(string.trimmingCharacters(in:characters2), "")
    XCTAssertEqual(string.trimmingUnicodeScalars(in:scalars2), "")
  }
  
  static var allTests = [
    ("testSplit", testSplit),
    ("test_consistsOf", test_consistsOf),
    ("test_trimming", test_trimming),
  ]
}


