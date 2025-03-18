import XCTest
@testable import OnyxShell

final class FlagTests: XCTestCase {
    
    func test() {
        struct Demo {
            @Value
            var value1: String?
            
            @Flag
            var b: Bool?
            
            @Flag
            var s0: String?
            
            @Flag("flag")
            var s1: String?
            
            @Flag("flag")
            var s2: String? = "string"
            
            @Flag("flag", exclusivity: .chooseFirst)
            var s4: String?
            
            @Flag("flag", abstract: "abstract")
            var s5: String?
            
            @Flag("flag", abstract: "abstract", discussion: "discussion")
            var s6: String?
            
            @Flag("flag", ref: "value1")
            var s7: String?
            
            @Flag("flag", name: "name")
            var s8: String?
            
            @Flag("flag", aliases: ["alias1", "alias2"])
            var s10: String?
            
            @Flag("flag", hidden: true)
            var s11: String?
        }
        
        let demo = Demo()
        XCTAssertEqual(demo.b, nil)
        XCTAssertEqual(demo.$b.$wrappedValue.defaultValue, true)
        XCTAssertEqual(demo.s0, nil)
        XCTAssertEqual(demo.$s0.$wrappedValue.defaultValue, "")
        XCTAssertEqual(demo.s1, nil)
        XCTAssertEqual(demo.s2, "string")
        XCTAssertEqual(demo.$s2.$wrappedValue.defaultValue, "flag")
        XCTAssertEqual(demo.$s4.$wrappedValue.exclusivity, .chooseFirst)
        XCTAssertEqual(demo.$s5.abstract, "abstract")
        XCTAssertEqual(demo.$s6.abstract, "abstract")
        XCTAssertEqual(demo.$s6.discussion, "discussion")
        XCTAssertEqual(demo.$s7.ref, "value1")
        XCTAssertEqual(demo.$s8.name, "name")
        XCTAssertEqual(demo.$s10.aliases, ["alias1", "alias2"])
        XCTAssertEqual(demo.$s11.hidden, true)
    }
}
