/***************************************************************************************************
 UnicodeScalarSet.swift
   © 2017-2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import Foundation
private typealias LegacyCharacterSet = Foundation.CharacterSet

import Ranges

/// # UnicodeScalarSet
/// 
/// A set of `Unicode.Scalar`s.
/// This will not be necessary in the future.
///
/// ## Feature
///
/// `UnicodeScalarSet` is just a wrapper of [`Foundation.CharacterSet`](https://developer.apple.com/documentation/foundation/characterset).
public struct UnicodeScalarSet {
  private var _legacyCharacterSet: LegacyCharacterSet
  
  private init(_ legacyCharacterSet: LegacyCharacterSet) {
    self._legacyCharacterSet = legacyCharacterSet
  }
  
  public init(unicodeScalarsIn string: String) {
    self.init(LegacyCharacterSet(charactersIn:string))
  }
}


extension UnicodeScalarSet {
  public init<R>(unicodeScalarsIn range:R) where R:GeneralizedRange, R.Bound == Unicode.Scalar {
    let _range = Unicode.Scalar._Range(range)
    switch _range {
    case .empty:
      self.init(LegacyCharacterSet())
    case .closedRange(let closed):
      self.init(LegacyCharacterSet(charactersIn:closed))
    case .range(let range):
      self.init(LegacyCharacterSet(charactersIn:range))
    }
  }
}

extension UnicodeScalarSet {
  public static let alphanumerics = UnicodeScalarSet(LegacyCharacterSet.alphanumerics)
  public static let capitalizedLetters = UnicodeScalarSet(LegacyCharacterSet.capitalizedLetters)
  public static let controlCharacters = UnicodeScalarSet(LegacyCharacterSet.controlCharacters)
  public static let decimalDigits = UnicodeScalarSet(LegacyCharacterSet.decimalDigits)
  public static let decomposables = UnicodeScalarSet(LegacyCharacterSet.decomposables)
  public static let illegalCharacters = UnicodeScalarSet(LegacyCharacterSet.illegalCharacters)
  public static let letters = UnicodeScalarSet(LegacyCharacterSet.letters)
  public static let lowercaseLetters = UnicodeScalarSet(LegacyCharacterSet.lowercaseLetters)
  public static let newlines = UnicodeScalarSet(LegacyCharacterSet.newlines)
  public static let nonBaseCharacters = UnicodeScalarSet(LegacyCharacterSet.nonBaseCharacters)
  public static let punctuationCharacters = UnicodeScalarSet(LegacyCharacterSet.punctuationCharacters)
  public static let symbols = UnicodeScalarSet(LegacyCharacterSet.symbols)
  public static let uppercaseLetters = UnicodeScalarSet(LegacyCharacterSet.uppercaseLetters)
  public static let whitespaces = UnicodeScalarSet(LegacyCharacterSet.whitespaces)
  public static let whitespacesAndNewlines = UnicodeScalarSet(LegacyCharacterSet.whitespacesAndNewlines)
}

extension UnicodeScalarSet {
  public static let urlFragmentAllowed = UnicodeScalarSet(LegacyCharacterSet.urlFragmentAllowed)
  public static let urlHostAllowed = UnicodeScalarSet(LegacyCharacterSet.urlHostAllowed)
  public static let urlPasswordAllowed = UnicodeScalarSet(LegacyCharacterSet.urlPasswordAllowed)
  public static let urlPathAllowed = UnicodeScalarSet(LegacyCharacterSet.urlPathAllowed)
  public static let urlQueryAllowed = UnicodeScalarSet(LegacyCharacterSet.urlQueryAllowed)
  public static let urlUserAllowed = UnicodeScalarSet(LegacyCharacterSet.urlUserAllowed)
}

extension UnicodeScalarSet: CustomDebugStringConvertible, CustomStringConvertible {
  public var debugDescription: String {
    return self._legacyCharacterSet.debugDescription
  }
  public var description: String {
    return self._legacyCharacterSet.description
  }
}

extension UnicodeScalarSet: Equatable {
  public static func ==(lhs: UnicodeScalarSet, rhs: UnicodeScalarSet) -> Bool {
    return lhs._legacyCharacterSet == rhs._legacyCharacterSet
  }
}

extension UnicodeScalarSet: Hashable {
  #if compiler(>=4.2)
  public func hash(into hasher:inout Hasher) {
    hasher.combine(self._legacyCharacterSet)
  }
  #else
  public var hashValue: Int {
    return self._legacyCharacterSet.hashValue
  }
  #endif
}

extension UnicodeScalarSet: SetAlgebra {
  public typealias Element = Unicode.Scalar
  
  public init() {
    self.init(LegacyCharacterSet())
  }
  
  public func contains(_ member: Unicode.Scalar) -> Bool {
    return self._legacyCharacterSet.contains(member)
  }
  
  public func union(_ other: UnicodeScalarSet) -> UnicodeScalarSet {
    return UnicodeScalarSet(self._legacyCharacterSet.union(other._legacyCharacterSet))
  }
  
  public func intersection(_ other: UnicodeScalarSet) -> UnicodeScalarSet {
    return UnicodeScalarSet(self._legacyCharacterSet.intersection(other._legacyCharacterSet))
  }
  
  public func symmetricDifference(_ other: UnicodeScalarSet) -> UnicodeScalarSet {
    return UnicodeScalarSet(self._legacyCharacterSet.symmetricDifference(other._legacyCharacterSet))
  }
  
  @discardableResult
  public mutating func insert(_ newMember: Unicode.Scalar) -> (inserted: Bool, memberAfterInsert: Unicode.Scalar) {
    return self._legacyCharacterSet.insert(newMember)
  }
  
  @discardableResult
  public mutating func remove(_ member: Unicode.Scalar) -> Unicode.Scalar? {
    return self._legacyCharacterSet.remove(member)
  }
  
  @discardableResult
  public mutating func update(with newMember: Unicode.Scalar) -> Unicode.Scalar? {
    return self._legacyCharacterSet.update(with:newMember)
  }
  
  public mutating func formUnion(_ other: UnicodeScalarSet) {
    self._legacyCharacterSet.formUnion(other._legacyCharacterSet)
  }
  
  public mutating func formIntersection(_ other: UnicodeScalarSet) {
    self._legacyCharacterSet.formIntersection(other._legacyCharacterSet)
  }
  
  public mutating func formSymmetricDifference(_ other: UnicodeScalarSet) {
    self._legacyCharacterSet.formSymmetricDifference(other._legacyCharacterSet)
  }
  
}

extension UnicodeScalarSet {
  /// Returns a representation of the `UnicodeScalarSet` in binary format.
  /// It is equal to `var bitmapRepresentation: Data { get }` of `Foundation.CharacterSet`.
  public var bitmapRepresentation: Data {
    return self._legacyCharacterSet.bitmapRepresentation
  }
  
  /// Initialize with a bitmap representation.
  public init(bitmapRepresentation data: Data) {
    self.init(LegacyCharacterSet(bitmapRepresentation:data))
  }
  
  /// Invert the contents of the `UnicodeScalarSet`.
  public mutating func invert() {
    self._legacyCharacterSet.invert()
  }
  
  /// Returns an inverted copy of the `UnicodeScalarSet`.
  public var inverted: UnicodeScalarSet {
    var set = self
    set.invert()
    return set
  }
  
  /// A Boolean value that indicates whether the set has no elements.
  public var isEmpty: Bool {
    return self._legacyCharacterSet.isEmpty
  }
  
  /// Returns true if the CharacterSet has a member in the specified plane.
  public func hasMember(inPlane plane: UInt8) -> Bool {
    return self._legacyCharacterSet.hasMember(inPlane:plane)
  }
}
