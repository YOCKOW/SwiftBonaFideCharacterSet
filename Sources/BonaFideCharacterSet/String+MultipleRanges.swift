/***************************************************************************************************
 String+MultipleRanges.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import Ranges

extension String {
  internal func characterRanges<C>(using typeOfCharacter:C.Type) -> MultipleRanges<C>
    where C:CharacterExpression
  {
    var ranges = MultipleRanges<C>()
    for character in self {
      ranges.insert(singleValue:C(character))
    }
    return ranges
  }
}
