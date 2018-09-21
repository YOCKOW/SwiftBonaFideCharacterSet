/* *************************************************************************************************
 StringProtocol+CharacterExpressionSet+UnicodeScalarSet.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

extension StringProtocol {
  /// Returns the longest possible subsequences of the collection, in order,
  /// around elements equal to the given element.
  public func split<C>(separator:CharacterExpressionSet<C>,
                       maxSplits:Int = Int.max,
                       omittingEmptySubsequences:Bool = true) -> [SubSequence]
    where C:CharacterExpression
  {
    return self.split(maxSplits:maxSplits,
                      omittingEmptySubsequences:omittingEmptySubsequences,
                      whereSeparator:{ separator.contains(C($0)) })
  }
  
  /// Returns an array containing substrings from the string
  /// that have been divided by characters in the given set.
  public func components<C>(separatedBy separator:CharacterExpressionSet<C>) -> [String]
    where C: CharacterExpression
  {
    return self.split(separator:separator, omittingEmptySubsequences:false).map{ String($0) }
  }
  
  /// Returns true if all of characters are contained in `characters`
  public func consists<C>(of characters:CharacterExpressionSet<C>) -> Bool
    where C:CharacterExpression
  {
    for character in self {
      guard characters.contains(C(character)) else { return false }
    }
    return true
  }
}

extension StringProtocol {
  /// Returns the longest possible subsequences of the collection, in order,
  /// around elements equal to the given element.
  public func split(separator:UnicodeScalarSet,
                    maxSplits:Int = Int.max,
                    omittingEmptySubsequences:Bool = true) -> [String]

  {
    let array = self.unicodeScalars.split(maxSplits:maxSplits,
                                          omittingEmptySubsequences:omittingEmptySubsequences,
                                          whereSeparator:{ separator.contains($0) })
    return array.map { String(String.UnicodeScalarView($0)) }
  }
  
  /// Returns an array containing substrings from the string
  /// that have been divided by characters in the given set.
  public func components(separatedBy separator:UnicodeScalarSet) -> [String] {
    return self.split(separator:separator, omittingEmptySubsequences:false).map{ String($0) }
  }
  
  /// Returns true if all of Unicode scalars are contained in `scalars`
  public func consists(of scalars:UnicodeScalarSet) -> Bool {
    for scalar in self.unicodeScalars {
      guard scalars.contains(scalar) else { return false }
    }
    return true
  }
}
