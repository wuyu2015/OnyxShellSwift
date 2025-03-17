import XCTest
import XCTestDelayPrinter
@testable import OnyxShell

final class ArgumentPaserTests: XCTestCase {
    
    func test() throws {
        struct Demo: OnyxCommand {
            var parentCommand: OnyxCommand?
            let commandConfiguration: Onyx.CommandConfiguration? = nil
            
            @Value(exclusivity: .chooseLast)
            var vs: String?
            
            @Value(exclusivity: .chooseLast)
            var vi: Int?
            
            @Value(exclusivity: .chooseLast)
            var vd: Double?
            
            @Value(exclusivity: .chooseLast)
            var vb: Bool?
            
            @Value(exclusivity: .chooseLast)
            var vsa: [String]?
            
            @Value(exclusivity: .chooseLast)
            var via: [Int]?
            
            @Value(exclusivity: .chooseLast)
            var vda: [Double]?
            
            @Value(exclusivity: .chooseLast)
            var vba: [Bool]?
            
            @Argument(default: "s", ref: "vs")
            var args: String?

            @Argument(default: 1, ref: "vi")
            var argi: Int?

            @Argument(default: 1.0, ref: "vd")
            var argd: Double?

            @Argument(default: true, ref: "vb")
            var argb: Bool?

            @Argument(default: ["s"], ref: "vsa")
            var argsa: [String]?
            
            @Option(ref: "vs", aliases: ["oas"])
            var ops: String?

            @Option(ref: "vi", aliases: ["oai"])
            var opi: Int?

            @Option(ref: "vd", aliases: ["oad"])
            var opd: Double?

            @Option(ref: "vb", aliases: ["oab"])
            var opb: Bool?

            @Option(ref: "vsa", shortName: "z", aliases: ["oasa"])
            var opsa: [String]?

            @Option(ref: "via", aliases: ["oaia"])
            var opia: [Int]?

            @Option(ref: "vda", aliases: ["oada"])
            var opda: [Double]?

            @Option(ref: "vba", aliases: ["oaba"])
            var opba: [Bool]?
            
            @Flag("flag", ref: "vs",  aliases: ["fas"])
            var a: String?

            @Flag(3, ref: "vi", aliases: ["fai"])
            var b: Int?

            @Flag(3.0, ref: "vd", aliases: ["fad"])
            var c: Double?

            @Flag(false, ref: "vb", aliases: ["fab"])
            var d: Bool?

            @Flag(["flag"], ref: "vsa", aliases: ["fasa"])
            var e: [String]?

            @Flag([3], ref: "via", aliases: ["faia"])
            var f: [Int]?

            @Flag([3.0], ref: "vda", aliases: ["fada"])
            var g: [Double]?

            @Flag([false], ref: "vba", aliases: ["faba"])
            var h: [Bool]?
        }
        
        var parser = Onyx.ArgumentParser()
        var cmd: Demo
        
        cmd = Demo()
        try parser.parseCommand(command: cmd, arguments: ["_"].dropFirst())
        XCTAssertEqual(cmd.args, "s")
        XCTAssertEqual(cmd.vs, "s")
        XCTAssertEqual(cmd.argi, 1)
        XCTAssertEqual(cmd.vi, 1)
        XCTAssertEqual(cmd.argd, 1.0)
        XCTAssertEqual(cmd.vd, 1.0)
        XCTAssertEqual(cmd.argb, true)
        XCTAssertEqual(cmd.vb, true)
        XCTAssertEqual(cmd.argsa, ["s"])
        XCTAssertEqual(cmd.vsa, ["s"])
        
        cmd = Demo()
        try parser.parseCommand(command: cmd, arguments: [
            "_", "a", "2", "2.0", "false", "a", "b", "c"
            ].dropFirst())
        XCTAssertEqual(cmd.args, "a")
        XCTAssertEqual(cmd.vs, "a")
        XCTAssertEqual(cmd.argi, 2)
        XCTAssertEqual(cmd.vi, 2)
        XCTAssertEqual(cmd.argd, 2.0)
        XCTAssertEqual(cmd.vd, 2.0)
        XCTAssertEqual(cmd.argb, false)
        XCTAssertEqual(cmd.vb, false)
        XCTAssertEqual(cmd.argsa, ["a", "b", "c"])
        XCTAssertEqual(cmd.vsa, ["a", "b", "c"])
        
        cmd = Demo()
        try parser.parseCommand(command: cmd, arguments: [
            "_",
            "--ops=a", "--opi=2", "--opd=2.0", "--opb=false",
            "--opsa", "a", "--opsa=b", "--opsa=", "c", "--opsa", "=d", "--opsa", "=", "e",
            "--z=f", "--oasa=g",
            "--opia=1", "--opia=2",
            "--opda=1.0", "--opda=2.0",
            "--opba=true", "--opba=false",
            ].dropFirst())
        XCTAssertEqual(cmd.ops, "a")
        XCTAssertEqual(cmd.vs, "a")
        XCTAssertEqual(cmd.opi, 2)
        XCTAssertEqual(cmd.vi, 2)
        XCTAssertEqual(cmd.opd, 2.0)
        XCTAssertEqual(cmd.vd, 2.0)
        XCTAssertEqual(cmd.opb, false)
        XCTAssertEqual(cmd.vb, false)
        XCTAssertEqual(cmd.opsa, ["a", "b", "c", "d", "e", "f", "g"])
        XCTAssertEqual(cmd.vsa, ["a", "b", "c", "d", "e", "f", "g"])
        XCTAssertEqual(cmd.opia, [1, 2])
        XCTAssertEqual(cmd.via, [1, 2])
        XCTAssertEqual(cmd.opda, [1.0, 2.0])
        XCTAssertEqual(cmd.vda, [1.0, 2.0])
        XCTAssertEqual(cmd.opba, [true, false])
        XCTAssertEqual(cmd.vba, [true, false])
        XCTAssertEqual(cmd.args, "s")
        XCTAssertEqual(cmd.argi, 1)
        XCTAssertEqual(cmd.argd, 1.0)
        XCTAssertEqual(cmd.argb, true)
        XCTAssertEqual(cmd.argsa, ["s"])
        
        cmd = Demo()
        try parser.parseCommand(command: cmd, arguments: [
            "_",
            "-ops=a", "-opi=2", "-opd=2.0", "-opb=false",
            "-opsa", "a", "-opsa=b", "-opsa=", "c", "-opsa", "=d", "-opsa", "=", "e",
            "-z=f", "-oasa=g",
            "-opia=1", "-opia=2",
            "-opda=1.0", "-opda=2.0",
            "-opba=true", "-opba=false",
            ].dropFirst())
        XCTAssertEqual(cmd.ops, "a")
        XCTAssertEqual(cmd.vs, "a")
        XCTAssertEqual(cmd.opi, 2)
        XCTAssertEqual(cmd.vi, 2)
        XCTAssertEqual(cmd.opd, 2.0)
        XCTAssertEqual(cmd.vd, 2.0)
        XCTAssertEqual(cmd.opb, false)
        XCTAssertEqual(cmd.vb, false)
        XCTAssertEqual(cmd.opsa, ["a", "b", "c", "d", "e", "f", "g"])
        XCTAssertEqual(cmd.vsa, ["a", "b", "c", "d", "e", "f", "g"])
        XCTAssertEqual(cmd.opia, [1, 2])
        XCTAssertEqual(cmd.via, [1, 2])
        XCTAssertEqual(cmd.opda, [1.0, 2.0])
        XCTAssertEqual(cmd.vda, [1.0, 2.0])
        XCTAssertEqual(cmd.opba, [true, false])
        XCTAssertEqual(cmd.vba, [true, false])
        XCTAssertEqual(cmd.args, "s")
        XCTAssertEqual(cmd.argi, 1)
        XCTAssertEqual(cmd.argd, 1.0)
        XCTAssertEqual(cmd.argb, true)
        XCTAssertEqual(cmd.argsa, ["s"])
        
        cmd = Demo()
        try parser.parseCommand(command: cmd, arguments: [
            "_",
            "-a", "-b", "-c", "-d", "-e", "-f", "-g", "-h",
        ].dropFirst())
        XCTAssertEqual(cmd.a, "flag")
        XCTAssertEqual(cmd.vs, "flag")
        XCTAssertEqual(cmd.b, 3)
        XCTAssertEqual(cmd.vi, 3)
        XCTAssertEqual(cmd.c, 3.0)
        XCTAssertEqual(cmd.vd, 3.0)
        XCTAssertEqual(cmd.d, false)
        XCTAssertEqual(cmd.vb, false)
        XCTAssertEqual(cmd.e, ["flag"])
        XCTAssertEqual(cmd.vsa, ["flag"])
        XCTAssertEqual(cmd.f, [3])
        XCTAssertEqual(cmd.via, [3])
        XCTAssertEqual(cmd.g, [3.0])
        XCTAssertEqual(cmd.vda, [3.0])
        XCTAssertEqual(cmd.h, [false])
        XCTAssertEqual(cmd.vba, [false])
        XCTAssertEqual(cmd.args, "s")
        XCTAssertEqual(cmd.argi, 1)
        XCTAssertEqual(cmd.argd, 1.0)
        XCTAssertEqual(cmd.argb, true)
        XCTAssertEqual(cmd.argsa, ["s"])
        
        cmd = Demo()
        try parser.parseCommand(command: cmd, arguments: [
            "_",
            "-a", "-b", "-c", "-d", "-e", "-f", "-g", "-h",
            "-a", "-b", "-c", "-d", "-e", "-f", "-g", "-h",
        ].dropFirst())
        XCTAssertEqual(cmd.a, "flag")
        XCTAssertEqual(cmd.vs, "flag")
        XCTAssertEqual(cmd.b, 3)
        XCTAssertEqual(cmd.vi, 3)
        XCTAssertEqual(cmd.c, 3.0)
        XCTAssertEqual(cmd.vd, 3.0)
        XCTAssertEqual(cmd.d, false)
        XCTAssertEqual(cmd.vb, false)
        XCTAssertEqual(cmd.e, ["flag"])
        XCTAssertEqual(cmd.vsa, ["flag"])
        XCTAssertEqual(cmd.f, [3])
        XCTAssertEqual(cmd.via, [3])
        XCTAssertEqual(cmd.g, [3.0])
        XCTAssertEqual(cmd.vda, [3.0])
        XCTAssertEqual(cmd.h, [false])
        XCTAssertEqual(cmd.vba, [false])
        XCTAssertEqual(cmd.args, "s")
        XCTAssertEqual(cmd.argi, 1)
        XCTAssertEqual(cmd.argd, 1.0)
        XCTAssertEqual(cmd.argb, true)
        XCTAssertEqual(cmd.argsa, ["s"])
        
        cmd = Demo()
        try parser.parseCommand(command: cmd, arguments: [
            "_",
            "--a", "--b", "--c", "--d", "--e", "--f", "--g", "--h",
        ].dropFirst())
        XCTAssertEqual(cmd.a, "flag")
        XCTAssertEqual(cmd.vs, "flag")
        XCTAssertEqual(cmd.b, 3)
        XCTAssertEqual(cmd.vi, 3)
        XCTAssertEqual(cmd.c, 3.0)
        XCTAssertEqual(cmd.vd, 3.0)
        XCTAssertEqual(cmd.d, false)
        XCTAssertEqual(cmd.vb, false)
        XCTAssertEqual(cmd.e, ["flag"])
        XCTAssertEqual(cmd.vsa, ["flag"])
        XCTAssertEqual(cmd.f, [3])
        XCTAssertEqual(cmd.via, [3])
        XCTAssertEqual(cmd.g, [3.0])
        XCTAssertEqual(cmd.vda, [3.0])
        XCTAssertEqual(cmd.h, [false])
        XCTAssertEqual(cmd.vba, [false])
        XCTAssertEqual(cmd.args, "s")
        XCTAssertEqual(cmd.argi, 1)
        XCTAssertEqual(cmd.argd, 1.0)
        XCTAssertEqual(cmd.argb, true)
        XCTAssertEqual(cmd.argsa, ["s"])
        
        cmd = Demo()
        try parser.parseCommand(command: cmd, arguments: [
            "_",
            "-abcdefgh",
        ].dropFirst())
        XCTAssertEqual(cmd.a, "flag")
        XCTAssertEqual(cmd.vs, "flag")
        XCTAssertEqual(cmd.b, 3)
        XCTAssertEqual(cmd.vi, 3)
        XCTAssertEqual(cmd.c, 3.0)
        XCTAssertEqual(cmd.vd, 3.0)
        XCTAssertEqual(cmd.d, false)
        XCTAssertEqual(cmd.vb, false)
        XCTAssertEqual(cmd.e, ["flag"])
        XCTAssertEqual(cmd.vsa, ["flag"])
        XCTAssertEqual(cmd.f, [3])
        XCTAssertEqual(cmd.via, [3])
        XCTAssertEqual(cmd.g, [3.0])
        XCTAssertEqual(cmd.vda, [3.0])
        XCTAssertEqual(cmd.h, [false])
        XCTAssertEqual(cmd.vba, [false])
        XCTAssertEqual(cmd.args, "s")
        XCTAssertEqual(cmd.argi, 1)
        XCTAssertEqual(cmd.argd, 1.0)
        XCTAssertEqual(cmd.argb, true)
        XCTAssertEqual(cmd.argsa, ["s"])
        
        cmd = Demo()
        try parser.parseCommand(command: cmd, arguments: [
            "_",
            "--ops=hello", "-a",
            "--",
            "-abcdefgh", "-4", "-5.0", "false", "-a", "--b", "---c"
        ].dropFirst())
        XCTAssertEqual(cmd.ops, "hello")
        XCTAssertEqual(cmd.a, "flag")
        XCTAssertEqual(cmd.b, nil)
        XCTAssertEqual(cmd.c, nil)
        XCTAssertEqual(cmd.d, nil)
        XCTAssertEqual(cmd.e, nil)
        XCTAssertEqual(cmd.f, nil)
        XCTAssertEqual(cmd.g, nil)
        XCTAssertEqual(cmd.vda, nil)
        XCTAssertEqual(cmd.h, nil)
        XCTAssertEqual(cmd.vba, nil)
        XCTAssertEqual(cmd.args, "-abcdefgh")
        XCTAssertEqual(cmd.argi, -4)
        XCTAssertEqual(cmd.argd, -5.0)
        XCTAssertEqual(cmd.argb, false)
        XCTAssertEqual(cmd.argsa, ["-a", "--b", "---c"])
    }
}
