/* *************************************************************************************************
 StringProtocol+CharacterExpressionSet.swift
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
}
