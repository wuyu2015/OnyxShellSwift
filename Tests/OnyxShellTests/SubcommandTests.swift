import XCTest
import XCTestDelayPrinter
@testable import OnyxShell

final class SubcommandTests: XCTestCase {
    
    struct CommandMain: OnyxCommand {
        var parentCommand: OnyxCommand?
        let commandConfiguration: Onyx.CommandConfiguration? = nil
        
        public func run() throws {
            CommandResult.string = "CommandMain"
        }
    }
    
    struct CommandWithDefaultSubcommand: OnyxCommand {
        let commandConfiguration: Onyx.CommandConfiguration? = .init(
            subcommands: ["sub1": Subcommand1.self, "sub2": Subcommand2.self],
            defaultSubcommand: "sub1"
        )
        var parentCommand: OnyxCommand?
    }
    
    struct Subcommand1: OnyxCommand {
        let commandConfiguration: Onyx.CommandConfiguration? = nil
        var parentCommand: OnyxCommand?
        
        public func run() throws {
            CommandResult.string = "Subcommand1"
        }
    }
    
    struct Subcommand2: OnyxCommand {
        let commandConfiguration: Onyx.CommandConfiguration? = nil
        var parentCommand: OnyxCommand?
        
        public func run() throws {
            CommandResult.string = "Subcommand2"
        }
    }
    
    struct CommandWithDefaultSubcommandChainStart: OnyxCommand {
        let commandConfiguration: Onyx.CommandConfiguration? = .init(
            subcommands: ["sub1": CommandWithDefaultSubcommandChain1.self],
            defaultSubcommand: "sub1"
        )
        var parentCommand: OnyxCommand?
    }
    
    struct CommandWithDefaultSubcommandChain1: OnyxCommand {
        let commandConfiguration: Onyx.CommandConfiguration? = .init(
            subcommands: ["sub2": CommandWithDefaultSubcommandChain2.self],
            defaultSubcommand: "sub2"
        )
        var parentCommand: OnyxCommand?
    }
    
    struct CommandWithDefaultSubcommandChain2: OnyxCommand {
        let commandConfiguration: Onyx.CommandConfiguration? = .init(
            subcommands: ["sub3": CommandWithDefaultSubcommandChainEnd.self],
            defaultSubcommand: "sub3"
        )
        var parentCommand: OnyxCommand?
    }
    
    struct CommandWithDefaultSubcommandChainEnd: OnyxCommand {
        let commandConfiguration: Onyx.CommandConfiguration? = nil
        func run() throws {
            CommandResult.string = "CommandWithDefaultSubcommandChainEnd"
        }
        var parentCommand: OnyxCommand?
    }
    
    func testCommandMain1() {
        CommandMain.main(arguments: ["_"])
        XCTAssertEqual(CommandResult.string, "CommandMain")
    }
    
    func testCommandMain2() throws {
        let cmd = CommandMain()
        try cmd.run()
        XCTAssertNil(cmd.parentCommand)
        XCTAssertEqual(CommandResult.string, "CommandMain")
    }
    
    func testCommandWithDefaultSubcommand1() {
        let cmd = CommandWithDefaultSubcommand.main(arguments: ["_"])
        XCTAssertTrue(cmd is Subcommand1)
        XCTAssertTrue(cmd.parentCommand! is CommandWithDefaultSubcommand)
        XCTAssertEqual(CommandResult.string, "Subcommand1")
    }
    
    func testCommandWithDefaultSubcommand2() {
        let cmd = CommandWithDefaultSubcommand.main(arguments: ["_", "sub2"])
        XCTAssertTrue(cmd is Subcommand2)
        XCTAssertTrue(cmd.parentCommand! is CommandWithDefaultSubcommand)
        XCTAssertEqual(CommandResult.string, "Subcommand2")
    }
    
    func testSubcommand1() {
        let cmd = Subcommand1.main(arguments: ["_"])
        XCTAssertTrue(cmd is Subcommand1)
        XCTAssertNil(cmd.parentCommand)
        XCTAssertEqual(CommandResult.string, "Subcommand1")
    }
    
    func testCommandWithDefaultSubcommandChain1() {
        let cmd = CommandWithDefaultSubcommandChainStart.main(arguments: ["_"])
        XCTAssertTrue(cmd is CommandWithDefaultSubcommandChainEnd)
        XCTAssertTrue(cmd.parentCommand! is CommandWithDefaultSubcommandChain2)
        XCTAssertTrue(cmd.parentCommand!.parentCommand! is CommandWithDefaultSubcommandChain1)
        XCTAssertTrue(cmd.parentCommand!.parentCommand!.parentCommand! is CommandWithDefaultSubcommandChainStart)
        XCTAssertNil(cmd.parentCommand!.parentCommand!.parentCommand!.parentCommand)
        XCTAssertEqual(CommandResult.string, "CommandWithDefaultSubcommandChainEnd")
    }
    
    func testCommandWithDefaultSubcommandChain2() {
        let cmd = CommandWithDefaultSubcommandChainStart.main(arguments: ["_", "sub1"])
        XCTAssertTrue(cmd is CommandWithDefaultSubcommandChainEnd)
        XCTAssertTrue(cmd.parentCommand! is CommandWithDefaultSubcommandChain2)
        XCTAssertTrue(cmd.parentCommand!.parentCommand! is CommandWithDefaultSubcommandChain1)
        XCTAssertTrue(cmd.parentCommand!.parentCommand!.parentCommand! is CommandWithDefaultSubcommandChainStart)
        XCTAssertNil(cmd.parentCommand!.parentCommand!.parentCommand!.parentCommand)
        XCTAssertEqual(CommandResult.string, "CommandWithDefaultSubcommandChainEnd")
    }
}
