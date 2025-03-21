extension Onyx {
    
    public struct CommandConfiguration {
        public static let emptyConfiguration = Self()
        
        public let name: String?
        public let usage: String?
        public let helpText: String?
        
        public let subcommands: [String: OnyxCommand.Type]?
        public let defaultSubcommand: String?
        
        public init(
            name: String? = nil,
            usage: String? = nil,
            helpText: String? = nil,
            subcommands: [String: OnyxCommand.Type]? = nil,
            defaultSubcommand: String? = nil
        ) {
            precondition(name == nil || !(name!.isEmpty))
            precondition(name == nil || Onyx.Utils.Str.isValidName(name!))
            
            precondition(usage == nil || !(usage!.isEmpty))
            precondition(helpText == nil || !(helpText!.isEmpty))
            
            precondition(subcommands == nil || !(subcommands!.isEmpty))
            precondition(subcommands == nil || subcommands!.allSatisfy { !$0.key.isEmpty && Onyx.Utils.Str.isValidName($0.key) })
            
            if defaultSubcommand != nil {
                precondition(!(defaultSubcommand!.isEmpty))
                precondition(Onyx.Utils.Str.isValidName(defaultSubcommand!))
                precondition(subcommands != nil)
                precondition(subcommands![defaultSubcommand!] != nil)
            }
            
            self.name = name
            self.usage = usage
            self.helpText = helpText
            self.subcommands = subcommands
            self.defaultSubcommand = defaultSubcommand
        }
    }
}
