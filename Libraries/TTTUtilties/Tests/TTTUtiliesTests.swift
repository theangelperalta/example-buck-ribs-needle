import XCTest
@testable import TTTUtilties

final class SomeASwiftModuleTests: XCTestCase {

  func testTTTUtiliesAdding() {
    let sut = localizedString("HI", "HI")
    XCTAssertEqual(!sut.isEmpty, true)
  }

}
