import Foundation

extension OnyxCommand {
    
    @inline(__always)
    public static func main() {
        _ = main(arguments: CommandLine.arguments)
    }
    
    @discardableResult
    public static func main(arguments: [String]) -> OnyxCommand {
        precondition(!arguments.isEmpty, "arguments cannot be empty.")
        
        var parser = Onyx.ArgumentParser()
        do {
            try parser.parse(commandType: Self.self, arguments: arguments.dropFirst())
        } catch {
            parser.command.handleParseError(error: error)
            exit(EXIT_FAILURE)
        }
        
        let command = parser.command!
        do {
            try command.run()
        } catch  {
            command.handleRunError(error: error)
            exit(EXIT_FAILURE)
        }
        return command
    }
    
    public func handleParseError(error: Error) {
        if let cmd = parentCommand {
            cmd.handleParseError(error: error)
            return
        }
        print(error.localizedDescription)
        print()
        printUsageAndHelpText()
    }
    
    public func handleRunError(error: Error) {
        if let cmd = parentCommand {
            cmd.handleRunError(error: error)
            return
        }
        print(error.localizedDescription)
    }
    
    public func run() throws {}
}
