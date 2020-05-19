import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(BBHelperKitTests.allTests),
    ]
}
#endif
