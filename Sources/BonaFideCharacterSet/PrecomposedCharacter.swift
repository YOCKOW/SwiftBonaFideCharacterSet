/* *************************************************************************************************
 PrecomposedCharacter.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
 
/**
 
 # PrecomposedCharacter
 
 A character always normalized with the Unicode Normalization Form C.
 
 e.g.) ǖ: "\u{0075}\u{0308}\u{0304}" -> "\u{01D6}"
 
 The result of comparison may differ from `Character`:
 
 ```
 let character_u = Character("u") // U+0075
 let character_v = Character("v") // U+0076
 let character_uDiaeresisMacron = Character("\u{01D6}")
 print(character_u < character_uDiaeresisMacron) // Prints "true"
 print(character_v < character_uDiaeresisMacron) // Prints "true" in Swift>=4.1.50, otherwize "false".
 
 let precomposed_u = PrecomposedCharacter("u") // U+0075
 let precomposed_v = PrecomposedCharacter("v") // U+0076
 let precomposed_uDiaeresisMacron = PrecomposedCharacter("\u{0075}\u{0308}\u{0304}") // U+01D6
 print(precomposed_u < precomposed_uDiaeresisMacron) // Prints "true"
 print(precomposed_v < precomposed_uDiaeresisMacron) // Prints "true"
 ```
 
 */
public struct PrecomposedCharacter: NormalizedCharacter {
  public typealias ExtendedGraphemeClusterLiteralType = Character
  
  private let _precomposed: Character
  
  public init(extendedGraphemeClusterLiteral character:Character) {
    self._precomposed = Character(String(character).precomposedStringWithCanonicalMapping)
  }
  
  public var character: Character {
    return self._precomposed
  }
}
