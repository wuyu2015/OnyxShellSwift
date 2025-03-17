import XCTest
@testable import OnyxShell

final class UtilsStrTest: XCTestCase {

    func testToKebabCase() {
        XCTAssertEqual(Onyx.Utils.Str.toKebabCase("someOne"), "some-one")
        XCTAssertEqual(Onyx.Utils.Str.toKebabCase("HTTPRequest"), "http-request")
        XCTAssertEqual(Onyx.Utils.Str.toKebabCase("JSONParser"), "json-parser")
        XCTAssertEqual(Onyx.Utils.Str.toKebabCase("XMLHTTPRequest"), "xmlhttp-request")
        XCTAssertEqual(Onyx.Utils.Str.toKebabCase("parseJSONData"), "parse-json-data")
        XCTAssertEqual(Onyx.Utils.Str.toKebabCase("aBcDeFgHijk"), "a-bc-de-fg-hijk")
        XCTAssertEqual(Onyx.Utils.Str.toKebabCase("noReplaceObjects"), "no-replace-objects")
    }
}
