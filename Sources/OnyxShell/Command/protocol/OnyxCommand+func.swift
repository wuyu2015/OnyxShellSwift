extension OnyxCommand {
    
    static func parse(arguments: [String]) throws -> OnyxCommand {
        precondition(!arguments.isEmpty, "arguments cannot be empty.")
        var parser = Onyx.ArgumentParser()
        try parser.parse(commandType: Self.self, arguments: arguments.dropFirst())
        return parser.command
    }
    
    public func printUsage() {
        guard let usage = commandConfiguration?.usage else {
            return
        }
        // found usage
        var cmd: OnyxCommand? = self
        var names: [String] = []
        while cmd != nil {
            if let name = cmd!.commandConfiguration?.name {
                names.insert(name, at: 0)
            }
            cmd = cmd!.parentCommand
        }
        // prefix
        let prefix = names.isEmpty ? "usage: " : "usage: \(names.joined(separator: " ")) "
        let blankPrefix = String(repeating: " ", count: prefix.count)
        // print
        let lines = usage.split(separator: "\n")
        print(prefix, lines[0], separator: "")
        for line in lines.dropFirst() {
            print(blankPrefix, line, separator: "")
        }
    }
    
    public func printHelpText() {
        guard let helpText = commandConfiguration?.helpText else {
            return
        }
        // found helpText
        print(helpText)
    }
    
    public func printUsageAndHelpText() {
        if commandConfiguration?.usage == nil && commandConfiguration?.helpText == nil {
            if let parentCommand = parentCommand {
                parentCommand.printUsageAndHelpText()
            }
            return
        }
        // found usage or documentation
        printUsage()
        print()
        printHelpText()
    }
}
