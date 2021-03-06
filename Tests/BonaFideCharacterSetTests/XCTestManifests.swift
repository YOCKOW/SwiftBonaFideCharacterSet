#if !canImport(ObjectiveC)
import XCTest

extension BonaFideCharacterSetTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__BonaFideCharacterSetTests = [
        ("test_initWithSequence", test_initWithSequence),
        ("testExample", testExample),
        ("testFlags", testFlags),
    ]
}

extension NormalizedCharacterTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__NormalizedCharacterTests = [
        ("testComparison", testComparison),
    ]
}

extension StringProtocol_CharacterExpressionSet_UnicodeScalarSet_Tests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__StringProtocol_CharacterExpressionSet_UnicodeScalarSet_Tests = [
        ("test_consistsOf", test_consistsOf),
        ("test_percentEncoding", test_percentEncoding),
        ("test_trimming", test_trimming),
        ("testSplit", testSplit),
    ]
}

extension UnicodeScalarSetTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__UnicodeScalarSetTests = [
        ("testInitialization", testInitialization),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(BonaFideCharacterSetTests.__allTests__BonaFideCharacterSetTests),
        testCase(NormalizedCharacterTests.__allTests__NormalizedCharacterTests),
        testCase(StringProtocol_CharacterExpressionSet_UnicodeScalarSet_Tests.__allTests__StringProtocol_CharacterExpressionSet_UnicodeScalarSet_Tests),
        testCase(UnicodeScalarSetTests.__allTests__UnicodeScalarSetTests),
    ]
}
#endif
