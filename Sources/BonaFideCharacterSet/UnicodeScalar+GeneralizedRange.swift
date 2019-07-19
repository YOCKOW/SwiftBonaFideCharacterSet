/***************************************************************************************************
 UnicodeScalar+GeneralizedRange.swift
   © 2018-2019 YOCKOW.
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

extension Unicode.Scalar {
  fileprivate var _next: Unicode.Scalar? {
    for vv: UInt32 in (self.value + 1)...0x10FFFF {
      if let scalar = Unicode.Scalar(vv) { return scalar }
    }
    return nil
  }
}

extension Unicode.Scalar._Range {
  internal init<R>(_ range:R) where R:GeneralizedRange, R.Bound == Unicode.Scalar {
    guard let bounds = range.bounds else { self = .empty; return }
    
    func _lowerScalar(_ lowerBoundary: Boundary<Unicode.Scalar>) -> Unicode.Scalar? {
      switch lowerBoundary {
      case .unbounded: return Unicode.Scalar(0 as UInt8)
      case .included(let scalar): return scalar
      case .excluded(let scalar): return scalar._next
      }
    }
    
    guard let lowerScalar = _lowerScalar(bounds.lower) else { self = .empty; return }
    
    switch bounds.upper {
    case .unbounded:
      self = .closedRange(ClosedRange(uncheckedBounds: (lower:lowerScalar,
                                                        upper:Unicode.Scalar(0x10FFFF)!)))
    case .included(let scalar):
      self = .closedRange(ClosedRange(uncheckedBounds: (lower:lowerScalar,
                                                        upper:scalar)))
    case .excluded(let scalar):
      self = .range(Range(uncheckedBounds: (lower:lowerScalar,
                                            upper:scalar)))
    }
  }
}
