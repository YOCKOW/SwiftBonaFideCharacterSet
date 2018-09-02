/* *************************************************************************************************
 CharacterExpression.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 

/// A protocol for types that represent Character.
public protocol CharacterExpression: ExpressibleByExtendedGraphemeClusterLiteral,
                                     CustomStringConvertible, CustomDebugStringConvertible,
                                     TextOutputStreamable,
                                     Comparable, Hashable
{
  init(_ character:Character)
  var character:Character { get }
  func isEqual(to character:Character) -> Bool
}

extension CharacterExpression where ExtendedGraphemeClusterLiteralType == Character {
  public init(_ character:Character) {
    self.init(extendedGraphemeClusterLiteral:character)
  }
}

extension CharacterExpression {
  public func isEqual(to character:Character) -> Bool {
    return self.character == character
  }
  
  public var unicodeScalars: Character.UnicodeScalarView {
    return self.character.unicodeScalars
  }
}

extension CharacterExpression {
  public var description: String { return self.character.description }
  public var debugDescription: String { return self.character.debugDescription }
}

extension CharacterExpression {
  public func write<Target>(to target: inout Target) where Target: TextOutputStream {
    target.write(String(self.character))
  }
}
