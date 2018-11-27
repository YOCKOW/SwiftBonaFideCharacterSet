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
  
  /// Returns a new string made by removing from both ends of the characters
  /// contained in a given character set.
  public func trimmingCharacters<C>(in set:CharacterExpressionSet<C>) -> String 
    where C:CharacterExpression
  {
    var ii = self.startIndex
    while true {
      if ii == self.endIndex { return "" }
      if !set.contains(C(self[ii])) { break }
      ii = self.index(after:ii)
    }
    
    let start = ii
    
    ii = self.endIndex
    while true {
      ii = self.index(before:ii)
      if !set.contains(C(self[ii])) { break }
      
      if ii == self.startIndex { return "" }
    }
    
    return String(self[start...ii])
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
  
  /// Returns a new string made by removing from both ends of the characters
  /// contained in a given character set.
  public func trimmingUnicodeScalars(in set:UnicodeScalarSet) -> String {
    let scalars = self.unicodeScalars
    var ii = scalars.startIndex
    
    while true {
      if ii == scalars.endIndex { return "" }
      if !set.contains(scalars[ii]) { break }
      ii = scalars.index(after:ii)
    }
    
    let start = ii
    
    ii = scalars.endIndex
    while true {
      ii = scalars.index(before:ii)
      if !set.contains(scalars[ii]) { break }
      if ii == scalars.startIndex { return "" }
    }
    
    return String(String.UnicodeScalarView(scalars[start...ii]))
  }
  
  /// like `func addingPercentEncoding(withAllowedCharacters allowedCharacters: CharacterSet) -> String?`
  public func addingPercentEncoding(withAllowedUnicodeScalars allowedScalars:UnicodeScalarSet) -> String? {
    var output = String.UnicodeScalarView()
    for scalar in self.unicodeScalars {
      if allowedScalars.contains(scalar) {
        output.append(scalar)
      } else {
        let value = scalar.value
        if value <= 0x007F {
          output.append("%")
          output.append(contentsOf:String(value, radix:16).uppercased().unicodeScalars)
        } else if value <= 0x07FF {
          let bytes:(UInt8, UInt8) = (UInt8(0b11000000) | UInt8(value >> 6),
                                      UInt8(0b10000000) | UInt8(value & 0b00111111))
          output.append("%")
          output.append(contentsOf:String(bytes.0, radix:16).uppercased().unicodeScalars)
          output.append("%")
          output.append(contentsOf:String(bytes.1, radix:16).uppercased().unicodeScalars)
        } else if value <= 0xFFFF {
          let bytes:(UInt8, UInt8, UInt8) = (UInt8(0b11100000) | UInt8(value >> 12),
                                             UInt8(0b10000000) | UInt8(value >> 6 & 0b00111111),
                                             UInt8(0b10000000) | UInt8(value & 0b00111111))
          output.append("%")
          output.append(contentsOf:String(bytes.0, radix:16).uppercased().unicodeScalars)
          output.append("%")
          output.append(contentsOf:String(bytes.1, radix:16).uppercased().unicodeScalars)
          output.append("%")
          output.append(contentsOf:String(bytes.2, radix:16).uppercased().unicodeScalars)
        } else if value <= 0x1FFFFF {
          let bytes:(UInt8, UInt8, UInt8, UInt8) = (UInt8(0b11110000) | UInt8(value >> 18),
                                                    UInt8(0b10000000) | UInt8(value >> 12 & 0b00111111),
                                                    UInt8(0b10000000) | UInt8(value >> 6 & 0b00111111),
                                                    UInt8(0b10000000) | UInt8(value & 0b00111111))
          output.append("%")
          output.append(contentsOf:String(bytes.0, radix:16).uppercased().unicodeScalars)
          output.append("%")
          output.append(contentsOf:String(bytes.1, radix:16).uppercased().unicodeScalars)
          output.append("%")
          output.append(contentsOf:String(bytes.2, radix:16).uppercased().unicodeScalars)
          output.append("%")
          output.append(contentsOf:String(bytes.3, radix:16).uppercased().unicodeScalars)
        } else {
          return nil
        }
      }
    }
    return String(output)
  }
}
