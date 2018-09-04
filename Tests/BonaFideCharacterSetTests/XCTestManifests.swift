import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
  return [
    testCase(BonaFideCharacterSetTests.allTests),
    testCase(NormalizedCharacterTests.allTests),
    testCase(StringProtocol_CharacterExpressionSetTests.allTests),
    testCase(UnicodeScalarSetTests.allTests),
  ]
}
#endif

