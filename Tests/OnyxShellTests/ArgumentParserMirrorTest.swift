import XCTest
import XCTestDelayPrinter
@testable import OnyxShell

final class ArgumentParserMirrorTest: XCTestCase {
    
    func test() {
        struct Demo: OnyxCommand {
            var parentCommand: OnyxCommand?
            var commandConfiguration: Onyx.CommandConfiguration? = nil
            
            @Value
            var vs: String?
            
            @Value
            var vi: Int?
            
            @Value
            var vd: Double?
            
            @Value
            var vb: Bool?
            
            @Value
            var vsa: [String]?
            
            @Value
            var via: [Int]?
            
            @Value
            var vda: [Double]?
            
            @Value
            var vba: [Bool]?
            
            @Argument
            var args: String?

            @Argument
            var argi: Int?

            @Argument
            var argd: Double?

            @Argument
            var argb: Bool?

            @Argument
            var argsa: [String]?
            
            @Option(shortName: "a", aliases: ["oas"])
            var ops: String?

            @Option(shortName: "b", aliases: ["oai"])
            var opi: Int?

            @Option(shortName: "c", aliases: ["oad"])
            var opd: Double?

            @Option(shortName: "d", aliases: ["oab"])
            var opb: Bool?

            @Option(shortName: "e", aliases: ["oasa"])
            var opsa: [String]?

            @Option(shortName: "f", aliases: ["oaia"])
            var opia: [Int]?

            @Option(shortName: "g", aliases: ["oada"])
            var opda: [Double]?

            @Option(shortName: "h", aliases: ["oaba"])
            var opba: [Bool]?
            
            @Flag("s", aliases: ["fas"])
            var fs: String?

            @Flag(1, aliases: ["fai"])
            var fi: Int?

            @Flag(1.0, aliases: ["fad"])
            var fd: Double?

            @Flag(true, aliases: ["fab"])
            var fb: Bool?

            @Flag(["s"], aliases: ["fasa"])
            var fsa: [String]?

            @Flag([1], aliases: ["faia"])
            var fia: [Int]?

            @Flag([1.0], aliases: ["fada"])
            var fda: [Double]?

            @Flag([true], aliases: ["faba"])
            var fba: [Bool]?
        }
        
        var parser = Onyx.ArgumentParser()
        parser.mirror(command: Demo())
        
        XCTAssertNotNil(parser.values["vs"]! as? Value<String>)
        XCTAssertNotNil(parser.values["vi"]! as? Value<Int>)
        XCTAssertNotNil(parser.values["vd"]! as? Value<Double>)
        XCTAssertNotNil(parser.values["vb"]! as? Value<Bool>)
        XCTAssertNotNil(parser.values["vsa"]! as? Value<[String]>)
        XCTAssertNotNil(parser.values["via"]! as? Value<[Int]>)
        XCTAssertNotNil(parser.values["vda"]! as? Value<[Double]>)
        XCTAssertNotNil(parser.values["vba"]! as? Value<[Bool]>)
        
        XCTAssertNotNil(parser.positionalArguments[0] as? Argument<String>)
        XCTAssertNotNil(parser.positionalArguments[1] as? Argument<Int>)
        XCTAssertNotNil(parser.positionalArguments[2] as? Argument<Double>)
        XCTAssertNotNil(parser.positionalArguments[3] as? Argument<Bool>)
        XCTAssertNotNil(parser.positionalArguments[4] as? Argument<[String]>)
        
        XCTAssertNotNil(parser.options["ops"]! as? Option<String>)
        XCTAssertNotNil(parser.options["opi"]! as? Option<Int>)
        XCTAssertNotNil(parser.options["opd"]! as? Option<Double>)
        XCTAssertNotNil(parser.options["opb"]! as? Option<Bool>)
        XCTAssertNotNil(parser.options["opsa"]! as? Option<[String]>)
        XCTAssertNotNil(parser.options["opia"]! as? Option<[Int]>)
        XCTAssertNotNil(parser.options["opda"]! as? Option<[Double]>)
        XCTAssertNotNil(parser.options["opba"]! as? Option<[Bool]>)
        
        XCTAssertEqual(parser.nameIndexes["ops"]!.0, .option)
        XCTAssertEqual(parser.nameIndexes["ops"]!.1, "ops")
        XCTAssertEqual(parser.nameIndexes["opi"]!.0, .option)
        XCTAssertEqual(parser.nameIndexes["opi"]!.1, "opi")
        XCTAssertEqual(parser.nameIndexes["opd"]!.0, .option)
        XCTAssertEqual(parser.nameIndexes["opd"]!.1, "opd")
        XCTAssertEqual(parser.nameIndexes["opb"]!.0, .option)
        XCTAssertEqual(parser.nameIndexes["opb"]!.1, "opb")
        XCTAssertEqual(parser.nameIndexes["opsa"]!.0, .option)
        XCTAssertEqual(parser.nameIndexes["opsa"]!.1, "opsa")
        XCTAssertEqual(parser.nameIndexes["opia"]!.0, .option)
        XCTAssertEqual(parser.nameIndexes["opia"]!.1, "opia")
        XCTAssertEqual(parser.nameIndexes["opda"]!.0, .option)
        XCTAssertEqual(parser.nameIndexes["opda"]!.1, "opda")
        XCTAssertEqual(parser.nameIndexes["opba"]!.0, .option)
        XCTAssertEqual(parser.nameIndexes["opba"]!.1, "opba")
        
        XCTAssertEqual(parser.nameIndexes["oas"]!.0, .option)
        XCTAssertEqual(parser.nameIndexes["oas"]!.1, "ops")
        XCTAssertEqual(parser.nameIndexes["oai"]!.0, .option)
        XCTAssertEqual(parser.nameIndexes["oai"]!.1, "opi")
        XCTAssertEqual(parser.nameIndexes["oad"]!.0, .option)
        XCTAssertEqual(parser.nameIndexes["oad"]!.1, "opd")
        XCTAssertEqual(parser.nameIndexes["oab"]!.0, .option)
        XCTAssertEqual(parser.nameIndexes["oab"]!.1, "opb")
        XCTAssertEqual(parser.nameIndexes["oasa"]!.0, .option)
        XCTAssertEqual(parser.nameIndexes["oasa"]!.1, "opsa")
        XCTAssertEqual(parser.nameIndexes["oaia"]!.0, .option)
        XCTAssertEqual(parser.nameIndexes["oaia"]!.1, "opia")
        XCTAssertEqual(parser.nameIndexes["oada"]!.0, .option)
        XCTAssertEqual(parser.nameIndexes["oada"]!.1, "opda")
        XCTAssertEqual(parser.nameIndexes["oaba"]!.0, .option)
        XCTAssertEqual(parser.nameIndexes["oaba"]!.1, "opba")
        
        XCTAssertEqual(parser.nameIndexes["a"]!.0, .option)
        XCTAssertEqual(parser.nameIndexes["a"]!.1, "ops")
        XCTAssertEqual(parser.nameIndexes["b"]!.0, .option)
        XCTAssertEqual(parser.nameIndexes["b"]!.1, "opi")
        XCTAssertEqual(parser.nameIndexes["c"]!.0, .option)
        XCTAssertEqual(parser.nameIndexes["c"]!.1, "opd")
        XCTAssertEqual(parser.nameIndexes["d"]!.0, .option)
        XCTAssertEqual(parser.nameIndexes["d"]!.1, "opb")
        XCTAssertEqual(parser.nameIndexes["e"]!.0, .option)
        XCTAssertEqual(parser.nameIndexes["e"]!.1, "opsa")
        XCTAssertEqual(parser.nameIndexes["f"]!.0, .option)
        XCTAssertEqual(parser.nameIndexes["f"]!.1, "opia")
        XCTAssertEqual(parser.nameIndexes["g"]!.0, .option)
        XCTAssertEqual(parser.nameIndexes["g"]!.1, "opda")
        XCTAssertEqual(parser.nameIndexes["h"]!.0, .option)
        XCTAssertEqual(parser.nameIndexes["h"]!.1, "opba")
        
        XCTAssertNotNil(parser.flags["fs"]! as? Flag<String>)
        XCTAssertNotNil(parser.flags["fi"]! as? Flag<Int>)
        XCTAssertNotNil(parser.flags["fd"]! as? Flag<Double>)
        XCTAssertNotNil(parser.flags["fb"]! as? Flag<Bool>)
        XCTAssertNotNil(parser.flags["fsa"]! as? Flag<[String]>)
        XCTAssertNotNil(parser.flags["fia"]! as? Flag<[Int]>)
        XCTAssertNotNil(parser.flags["fda"]! as? Flag<[Double]>)
        XCTAssertNotNil(parser.flags["fba"]! as? Flag<[Bool]>)
        
        XCTAssertEqual(parser.nameIndexes["fs"]!.0, .flag)
        XCTAssertEqual(parser.nameIndexes["fs"]!.1, "fs")
        XCTAssertEqual(parser.nameIndexes["fi"]!.0, .flag)
        XCTAssertEqual(parser.nameIndexes["fi"]!.1, "fi")
        XCTAssertEqual(parser.nameIndexes["fd"]!.0, .flag)
        XCTAssertEqual(parser.nameIndexes["fd"]!.1, "fd")
        XCTAssertEqual(parser.nameIndexes["fb"]!.0, .flag)
        XCTAssertEqual(parser.nameIndexes["fb"]!.1, "fb")
        XCTAssertEqual(parser.nameIndexes["fsa"]!.0, .flag)
        XCTAssertEqual(parser.nameIndexes["fsa"]!.1, "fsa")
        XCTAssertEqual(parser.nameIndexes["fia"]!.0, .flag)
        XCTAssertEqual(parser.nameIndexes["fia"]!.1, "fia")
        XCTAssertEqual(parser.nameIndexes["fda"]!.0, .flag)
        XCTAssertEqual(parser.nameIndexes["fda"]!.1, "fda")
        XCTAssertEqual(parser.nameIndexes["fba"]!.0, .flag)
        XCTAssertEqual(parser.nameIndexes["fba"]!.1, "fba")
        
        XCTAssertEqual(parser.nameIndexes["fas"]!.0, .flag)
        XCTAssertEqual(parser.nameIndexes["fas"]!.1, "fs")
        XCTAssertEqual(parser.nameIndexes["fai"]!.0, .flag)
        XCTAssertEqual(parser.nameIndexes["fai"]!.1, "fi")
        XCTAssertEqual(parser.nameIndexes["fad"]!.0, .flag)
        XCTAssertEqual(parser.nameIndexes["fad"]!.1, "fd")
        XCTAssertEqual(parser.nameIndexes["fab"]!.0, .flag)
        XCTAssertEqual(parser.nameIndexes["fab"]!.1, "fb")
        XCTAssertEqual(parser.nameIndexes["fasa"]!.0, .flag)
        XCTAssertEqual(parser.nameIndexes["fasa"]!.1, "fsa")
        XCTAssertEqual(parser.nameIndexes["faia"]!.0, .flag)
        XCTAssertEqual(parser.nameIndexes["faia"]!.1, "fia")
        XCTAssertEqual(parser.nameIndexes["fada"]!.0, .flag)
        XCTAssertEqual(parser.nameIndexes["fada"]!.1, "fda")
        XCTAssertEqual(parser.nameIndexes["faba"]!.0, .flag)
        XCTAssertEqual(parser.nameIndexes["faba"]!.1, "fba")
    }
}
