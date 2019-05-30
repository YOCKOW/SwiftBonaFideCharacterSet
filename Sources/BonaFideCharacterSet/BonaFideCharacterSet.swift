/***************************************************************************************************
 BonaFideCharacterSet.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import Ranges
import Predicate

/// A set of `CharacterExpression`s.
public typealias CharacterExpressionSet<C> = TotallyOrderedSet<C> where C:CharacterExpression

/// # BonaFideCharacterSet
///
/// A set of characters.
/// This will not be necessary in the future.
///
/// ## Feature
///
/// Unlike `Foundation.CharacterSet`, this may be really a set of `Character`s.
///
public typealias BonaFideCharacterSet = CharacterExpressionSet<Character>

/// # DecomposedCharacterSet
///
/// A set of `DecomposedCharacter`s.
public typealias DecomposedCharacterSet = CharacterExpressionSet<DecomposedCharacter>

/// # PrecomposedCharacterSet
///
/// A set of `PrecomposedCharacter`s.
public typealias PrecomposedCharacterSet = CharacterExpressionSet<PrecomposedCharacter>

extension TotallyOrderedSet where Element: CharacterExpression {
  /// Initializes with characters contained in `string`.
  public init(charactersIn string:String) {
    let ranges = string.characterRanges(using:Element.self)
    self.init(elementsIn:ranges)
  }
  
  public init<S>(charactersIn characters: S) where S: Sequence, S.Element == Element {
    self.init()
    for character in characters {
      self.insert(character)
    }
  }
  
  /// Initializes with characters contained in `ranges`.
  public init(charactersIn ranges:MultipleRanges<Element>) {
    self.init(elementsIn:ranges)
  }
  
  /// Initializes with characters contained in `range`.
  public init<R>(charactersIn range:R) where R:GeneralizedRange, R.Bound == Element {
    self.init(elementsIn:range)
  }
  
  /// Creates a set that contains all characters.
  public init(charactersIn _:UnboundedRange) { self.init(elementsIn:...) }
  
  /// Inserts characters in the specified `ranges`.
  public mutating func insert(charactersIn ranges:MultipleRanges<Element>) {
    self.insert(elementsIn:ranges)
  }
  
  /// Inserts characters in the specified `range`.
  public mutating func insert<R>(charactersIn range:R) where R:GeneralizedRange, R.Bound == Element {
    self.insert(elementsIn:range)
  }
  
  /// Inserts all characters.
  public mutating func insert(charactersIn _:UnboundedRange) {
    self.insert(elementsIn:...)
  }
  
  /// Remove characters in the specified `ranges`.
  public mutating func remove(charactersIn ranges:MultipleRanges<Element>) {
    self.remove(elementsIn:ranges)
  }
  
  /// Remove characters in the specified `range`.
  public mutating func remove<R>(charactersIn range:R) where R:GeneralizedRange, R.Bound == Element {
    self.remove(elementsIn:range)
  }
  
  /// Remove all characters.
  public mutating func remove(charactersIn _:UnboundedRange) {
    self.remove(elementsIn:...)
  }
}
