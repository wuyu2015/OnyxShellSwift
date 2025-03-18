import XCTest
import OnyxShell

final class DemoTests: XCTestCase {
    
    func testDemo1() {
        struct DemoCommand: OnyxCommand {
            var parentCommand: OnyxCommand?
            let commandConfiguration: Onyx.CommandConfiguration? = .init(
                name: "demo",
                usage: """
                    [-c | --Counter | -C | --no-counter]
                    [--repeat=<count> | -n <count>]
                    [<name>]
                    """,
                helpText: """
                    This is a demo command that demonstrates how to use OnyxShell to parse command-line arguments.

                    Arguments:
                    -c, --Counter           Enable the counter feature. Each output will include an incrementing counter.
                    -C, --no-counter        Disable the counter feature. Outputs will not include a counter.

                    --repeat=<count>,
                    -n <count>              Specify the number of times the output should repeat. Default is 3.

                    <name>                  The name to be printed in the output.
                    """
            )
            
            @Value(default: false)
            var useCounter: Bool?
            
            @Flag(true, ref: "useCounter", aliases: ["c"])
            var counter: Bool?
            
            @Flag(false, ref: "useCounter", aliases: ["C"])
            var noCounter: Bool?
            
            @Value(default: 3)
            var count: Int?
            
            @Option(ref: "count", name: "repeat", shortName: "n")
            var repeatOption: Int?
            
            @Argument var name: String?
            
            func run() throws {
                if let name = name {
                    if useCounter! {
                        for i in 0..<count! {
                            print("\(i + 1): Hi, \(name.capitalized)")
                        }
                    } else {
                        for _ in 0..<count! {
                            print("Hi, \(name.capitalized)")
                        }
                    }
                }
            }
        }
        
        DemoCommand.main(arguments: ["_", "alice"])
        // print:
        // Hi, Alice
        // Hi, Alice
        // Hi, Alice
        
        DemoCommand.main(arguments: ["_", "-c", "--repeat", "5", "bob"])
        // print:
        // 1: Hi, Bob
        // 2: Hi, Bob
        // 3: Hi, Bob
        // 4: Hi, Bob
        // 5: Hi, Bob
    }
}
