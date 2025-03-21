extension OnyxCommand {
    
    static func parse(arguments: [String]) throws -> OnyxCommand {
        precondition(!arguments.isEmpty, "arguments cannot be empty.")
        var parser = Onyx.ArgumentParser()
        try parser.parse(commandType: Self.self, arguments: arguments.dropFirst())
        return parser.command
    }
    
    @discardableResult
    public func printUsage(withLeadingNewline: Bool = false) -> Bool {
        guard let usage = commandConfiguration?.usage else {
            return false
        }
        if withLeadingNewline {
            print()
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
        let prefixCount =  min(prefix.count, 24)
        let blankPrefix = String(repeating: " ", count: prefixCount)
        // print
        let lines = usage.split(separator: "\n")
        if prefixCount < 24 {
            print(prefix, lines[0], separator: "")
            for line in lines.dropFirst() {
                print(blankPrefix, line, separator: "")
            }
        } else {
            print(prefix)
            for line in lines {
                print(blankPrefix, line, separator: "")
            }
        }
        return true
    }
    
    @discardableResult
    public func printHelpText(withLeadingNewline leadingNewline: Bool = false) -> Bool {
        guard let helpText = commandConfiguration?.helpText else {
            return false
        }
        if leadingNewline {
            print()
        }
        // found helpText
        print(helpText)
        return true
    }
    
    @discardableResult
    public func printUsageAndHelpText(withLeadingNewline leadingNewline: Bool = false) -> Bool {
        if commandConfiguration?.usage == nil && commandConfiguration?.helpText == nil {
            if let parentCommand = parentCommand {
                return parentCommand.printUsageAndHelpText(withLeadingNewline: leadingNewline)
            }
            return false
        }
        // found usage or documentation
        printHelpText(withLeadingNewline: printUsage(withLeadingNewline: leadingNewline))
        return true
    }
}
