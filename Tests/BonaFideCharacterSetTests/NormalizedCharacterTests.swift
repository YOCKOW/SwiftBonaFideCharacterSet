/* *************************************************************************************************
 NormalizedCharacterTests.swift
   © 2018-2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import BonaFideCharacterSet

import Ranges

final class NormalizedCharacterTests: XCTestCase {
  func testComparison() {
    let character_u = Character("u") // U+0075
    let character_v = Character("v") // U+0076
    let character_uDiaeresisMacron = Character("\u{01D6}")
    let character_uDiaeresisMacron_circle = Character("\u{01D6}\u{20DD}")
    
    XCTAssertTrue(character_u < character_uDiaeresisMacron)
    #if swift(>=4.1.50)
    XCTAssertTrue(character_v < character_uDiaeresisMacron)
    XCTAssertTrue(character_v < character_uDiaeresisMacron_circle)
    #else
    XCTAssertFalse(character_v < character_uDiaeresisMacron)
    XCTAssertFalse(character_v < character_uDiaeresisMacron_circle)
    #endif
    
    let decomposed_u = DecomposedCharacter(character_u)
    let decomposed_v = DecomposedCharacter(character_v)
    let decomposed_uDiaeresisMacron = DecomposedCharacter(character_uDiaeresisMacron) // U+0075 U+0308 U+0304
    let decomposed_uDiaeresisMacron_circle = DecomposedCharacter(character_uDiaeresisMacron_circle) // U+0075 U+0308 U+0304 U+20DD
    
    XCTAssertTrue(decomposed_u < decomposed_uDiaeresisMacron)
    XCTAssertTrue(decomposed_v > decomposed_uDiaeresisMacron)
    XCTAssertTrue(decomposed_uDiaeresisMacron < decomposed_uDiaeresisMacron_circle)
    XCTAssertTrue(decomposed_v > decomposed_uDiaeresisMacron_circle)
    
    let precomposed_u = PrecomposedCharacter(character_u)
    let precomposed_v = PrecomposedCharacter(character_v)
    let precomposed_uDiaeresisMacron = PrecomposedCharacter(character_uDiaeresisMacron) // U+01D6
    let precomposed_uDiaeresisMacron_circle = PrecomposedCharacter(character_uDiaeresisMacron_circle) // U+01D6 U+20DD
    
    XCTAssertTrue(precomposed_u < precomposed_uDiaeresisMacron)
    XCTAssertTrue(precomposed_v < precomposed_uDiaeresisMacron)
    XCTAssertTrue(precomposed_uDiaeresisMacron < precomposed_uDiaeresisMacron_circle)
    XCTAssertTrue(precomposed_v < precomposed_uDiaeresisMacron_circle)
  }
}
