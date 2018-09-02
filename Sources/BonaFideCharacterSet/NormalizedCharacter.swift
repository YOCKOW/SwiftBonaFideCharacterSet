/* *************************************************************************************************
 NormalizedCharacter.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation

public protocol NormalizedCharacter: CharacterExpression {
  
}

extension NormalizedCharacter {
  internal func _compare(_ other:Self) -> ComparisonResult {
    let myScalars = self.unicodeScalars
    let otherScalars = other.unicodeScalars
    
    var mi = myScalars.startIndex
    var oi = otherScalars.startIndex
    
    while true {
      if mi == myScalars.endIndex {
        return oi == otherScalars.endIndex ? .orderedSame : .orderedAscending
      } else if oi == otherScalars.endIndex {
        return .orderedDescending
      }
      
      let myScalar = myScalars[mi]
      let otherScalar = otherScalars[oi]
      
      if myScalar < otherScalar { return .orderedAscending }
      if myScalar > otherScalar { return .orderedDescending }
      
      
      mi = myScalars.index(after:mi)
      oi = otherScalars.index(after:oi)
    }
    
    preconditionFailure("Must not reach here.")
  }
}

extension NormalizedCharacter {
  /// Returns whether two characters are equal or not.
  /// Unlike `Character`, this method returns `true` only if all of unicode scalars
  /// contained in them are the same.
  public static func ==(lhs:Self, rhs:Self) -> Bool {
    return lhs._compare(rhs) == .orderedSame
  }
  
  /// Returns whether the left character is less than the right character or not.
  /// Unlike `Character`, this method compares each unicode scalar in two characters.
  public static func < (lhs: Self, rhs: Self) -> Bool {
    return lhs._compare(rhs) == .orderedAscending
  }
  
  public static func <= (lhs:Self, rhs:Self) -> Bool {
    let result = lhs._compare(rhs)
    return result == .orderedSame || result == .orderedAscending
  }
  
  public static func > (lhs:Self, rhs:Self) -> Bool {
    return lhs._compare(rhs) == .orderedDescending
  }
  
  public static func >= (lhs:Self, rhs:Self) -> Bool {
    let result = lhs._compare(rhs)
    return result == .orderedSame || result == .orderedDescending
  }
}

extension NormalizedCharacter {
  #if swift(>=4.2)
  public func hash(into hasher:inout Hasher) {
    for scalar in self.unicodeScalars {
      hasher.combine(scalar)
    }
  }
  #else
  public var hashValue:Int {
    var hh = 0
    for scalar in self.unicodeScalars {
      hh ^= scalar.hashValue
    }
    return hh
  }
  #endif
}
