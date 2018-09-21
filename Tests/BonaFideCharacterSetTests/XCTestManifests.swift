import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
  return [
    testCase(BonaFideCharacterSetTests.allTests),
    testCase(NormalizedCharacterTests.allTests),
    testCase(StringProtocol_CharacterExpressionSet_UnicodeScalarSet_Tests.allTests),
    testCase(UnicodeScalarSetTests.allTests),
  ]
}
#endif

