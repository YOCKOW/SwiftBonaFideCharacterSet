/***************************************************************************************************
 UnicodeScalar+GeneralizedRange.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import Ranges

extension Unicode.Scalar {
  internal enum _Range {
    case empty
    case closedRange(ClosedRange<Unicode.Scalar>)
    case range(Range<Unicode.Scalar>)
  }
}

extension Unicode.Scalar._Range {
  internal init<R>(_ range:R) where R:GeneralizedRange, R.Bound == Unicode.Scalar {
    guard let bounds = range.bounds else {
      self = .empty
      return
    }
    
    let nilableLower = ({ (_boundary:Boundary<Unicode.Scalar>?) -> Unicode.Scalar? in
      guard let boundary = _boundary else {
        return Unicode.Scalar(UInt8(0))
      }
      
      if boundary.isIncluded {
        return boundary.bound
      }
      
      // There may be a invalid value as a unicode scalar...
      guard boundary.bound.value < 0x10FFFF else { return nil }
      for value in (boundary.bound.value + 1)...0x10FFFF {
        if let scalar = Unicode.Scalar(value) { return scalar }
      }
      
      return nil
    })(bounds.lower)
    
    guard let lower = nilableLower else {
      self = .empty
      return
    }
    
    let lowerBoundary = Boundary(bound:lower, isIncluded:true)
    let upperBoundary = bounds.upper ?? Boundary(bound:Unicode.Scalar(0x10FFFF)!, isIncluded:true)
    
    if upperBoundary.isIncluded {
      self = .closedRange(ClosedRange(uncheckedBounds:(lower:lowerBoundary.bound,
                                                       upper:upperBoundary.bound)))
    } else {
      self = .range(Range(uncheckedBounds:(lower:lowerBoundary.bound,
                                           upper:upperBoundary.bound)))
    }
  }
}
