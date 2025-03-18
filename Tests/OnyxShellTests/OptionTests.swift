import XCTest
@testable import OnyxShell

final class OptionTests: XCTestCase {
    
    func test() {
        struct Demo {
            @Value
            var value1: String?
            
            @Option
            var s1: String?
            
            @Option
            var s2: String? = "string"
            
            @Option(default: "default string")
            var s3: String?
            
            @Option(exclusivity: .chooseFirst)
            var s4: String?
            
            @Option(abstract: "abstract")
            var s5: String?
            
            @Option(abstract: "abstract", discussion: "discussion")
            var s6: String?
            
            @Option(ref: "value1")
            var s7: String?
            
            @Option(name: "name")
            var s8: String?
            
            @Option(shortName: "n")
            var s9: String?
            
            @Option(aliases: ["alias1", "alias2"])
            var s10: String?
            
            @Option(hidden: true)
            var s11: String?
        }
        
        let demo = Demo()
        XCTAssertEqual(demo.s1, nil)
        XCTAssertEqual(demo.s2, "string")
        XCTAssertEqual(demo.$s2.$wrappedValue.defaultValue, nil)
        XCTAssertEqual(demo.s3, nil)
        XCTAssertEqual(demo.$s3.setDefaultIfNeeded(), "default string")
        XCTAssertEqual(demo.s3, "default string")
        XCTAssertEqual(demo.$s4.$wrappedValue.exclusivity, .chooseFirst)
        XCTAssertEqual(demo.$s5.abstract, "abstract")
        XCTAssertEqual(demo.$s6.abstract, "abstract")
        XCTAssertEqual(demo.$s6.discussion, "discussion")
        XCTAssertEqual(demo.$s7.ref, "value1")
        XCTAssertEqual(demo.$s8.name, "name")
        XCTAssertEqual(demo.$s9.shortName, "n")
        XCTAssertEqual(demo.$s10.aliases, ["alias1", "alias2"])
        XCTAssertEqual(demo.$s11.hidden, true)
    }
}
