import XCTest
@testable import Sample2

final class SamplePackageTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SamplePackage().text, "Hello, Sample2!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
