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
}


private let _hex: [Unicode.Scalar] = ["0", "1", "2", "3", "4", "5", "6", "7",
                                      "8", "9", "A", "B", "C", "D", "E", "F"]
extension UInt8 {
  fileprivate var _percentEncoded: String.UnicodeScalarView {
    return .init(["%", _hex[Int(self >> 4)], _hex[Int(self & 0x0F)]])
  }
}
extension Unicode.Scalar {
  fileprivate var _utf8: AnyRandomAccessCollection<UInt8> {
    #if compiler(>=5.1)
    if #available(macOS 10.15, *) {
      return .init(self.utf8)
    }
    #endif
    
    let value = self.value
    if value <= 0x7F {
      return .init([UInt8(value)])
    } else if value <= 0x07FF {
      return .init([UInt8(0b11000000) | UInt8(value >> 6),
                    UInt8(0b10000000) | UInt8(value & 0b00111111)])
    } else if value <= 0xFFFF {
      return .init([UInt8(0b11100000) | UInt8(value >> 12),
                    UInt8(0b10000000) | UInt8(value >> 6 & 0b00111111),
                    UInt8(0b10000000) | UInt8(value & 0b00111111)])
    } else if value <= 0x1FFFFF {
      return .init([UInt8(0b11110000) | UInt8(value >> 18),
                    UInt8(0b10000000) | UInt8(value >> 12 & 0b00111111),
                    UInt8(0b10000000) | UInt8(value >> 6 & 0b00111111),
                    UInt8(0b10000000) | UInt8(value & 0b00111111)])
    } else {
      fatalError("Unexpected Unicode Scalar Value.")
    }
  }
  
  fileprivate var _percentEncoded: String.UnicodeScalarView {
    return .init(self._utf8.flatMap({ $0._percentEncoded }))
  }
}
extension StringProtocol {
  /// like `func addingPercentEncoding(withAllowedCharacters allowedCharacters: CharacterSet) -> String?`
  public func addingPercentEncoding(withAllowedUnicodeScalars allowedScalars:UnicodeScalarSet) -> String? {
    var output = String.UnicodeScalarView()
    for scalar in self.unicodeScalars {
      if allowedScalars.contains(scalar) {
        output.append(scalar)
      } else {
        output.append(contentsOf: scalar._percentEncoded)
      }
    }
    return String(output)
  }
}
