/* *************************************************************************************************
 DecomposedCharacter.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/**
 
 # DecomposedCharacter
 
 A character always normalized with the Unicode Normalization Form D.
 
 e.g.) ǖ: "\u{01D6}" -> "\u{0075}\u{0308}\u{0304}"
 
 The result of comparison may differ from `Character`:
 
 ```
 let character_u = Character("u") // U+0075
 let character_v = Character("v") // U+0076
 let character_uDiaeresisMacron = Character("\u{01D6}")
 print(character_u < character_uDiaeresisMacron) // Prints "true"
 print(character_v < character_uDiaeresisMacron) // Prints "true" in Swift>=4.1.50, otherwize "false".
 
 let decomposed_u = DecomposedCharacter("u") // U+0075
 let decomposed_v = DecomposedCharacter("v") // U+0076
 let decomposed_uDiaeresisMacron = DecomposedCharacter("\u{01D6}") // U+0075 U+0308 U+0304
 print(decomposed_u < decomposed_uDiaeresisMacron) // Prints "true"
 print(decomposed_v < decomposed_uDiaeresisMacron) // Prints "false"
 // U+0075 < U+0075 + Combinings < U+0076
 ```
 
 */
public struct DecomposedCharacter: NormalizedCharacter {
  public typealias ExtendedGraphemeClusterLiteralType = Character
  
  private let _decomposed: Character
  
  public init(extendedGraphemeClusterLiteral character:Character) {
    self._decomposed = Character(String(character).decomposedStringWithCanonicalMapping)
  }
  
  public var character: Character {
    return self._decomposed
  }
}
