import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
  return [
    testCase(BonaFideCharacterSetTests.allTests),
    testCase(NormalizedCharacterTests.allTests),
    testCase(UnicoeScalarSetTests.allTests),
  ]
}
#endif

