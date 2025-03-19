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
        
        Onyx.commands.removeAll()
        let command = parser.command!
        var cmd = command
        while true {
            Onyx.commands.insert(cmd, at: 0)
            if cmd.parentCommand == nil {
                break
            }
            cmd = cmd.parentCommand!
        }
        
        do {
            try command.run()
        } catch  {
            command.handleRunError(error: error)
            exit(EXIT_FAILURE)
        }
        return command
    }
    
    public func handleParseError(error: Error) {
        if !error.localizedDescription.isEmpty {
            print(error.localizedDescription)
        }
        printUsageAndHelpText()
    }
    
    public func handleRunError(error: Error) {
        print(error.localizedDescription)
    }
    
    public func run() throws {}
}
