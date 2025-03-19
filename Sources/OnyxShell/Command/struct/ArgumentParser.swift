import Foundation

extension Onyx {
    public struct ArgumentParser {
        
        public var command: OnyxCommand!
        
        var values: [String: Any] = [:]
        var positionalArguments: [Any] = []
        var options: [String: Any] = [:]
        var flags: [String: Any] = [:]
        var nameIndexes: [String: (Onyx.NameType, String)] = [:]
        
        public mutating func parse(commandType: OnyxCommand.Type, arguments: ArraySlice<String>, parentCommand: OnyxCommand? = nil) throws {
            command = commandType.init()
            command.parentCommand = parentCommand
            
            if let config = command.commandConfiguration {
                if arguments.isEmpty {
                    // empty
                    if let defaultSubcommand = config.defaultSubcommand {
                        // parse command
                        try parseCommand(command: command, arguments: arguments)
                        // setup
                        do {
                            try command.setup()
                        } catch  {
                            command.handleSetupError(error: error)
                            exit(EXIT_FAILURE)
                        }
                        // parse default subcommand
                        try parse(commandType: config.subcommands![defaultSubcommand]!, arguments: arguments, parentCommand: command)
                        return
                    }
                } else {
                    // not empty
                    if let subcommands = config.subcommands {
                        for (index, argument) in arguments.enumerated() {
                            if argument.first! != "-" {
                                // found subcommand
                                if let subcommandType = subcommands[argument] {
                                    // parse command
                                    try parseCommand(command: command, arguments: Array(arguments)[0..<index])
                                    // setup
                                    do {
                                        try command.setup()
                                    } catch  {
                                        command.handleSetupError(error: error)
                                        exit(EXIT_FAILURE)
                                    }
                                    // parse subcommand
                                    try parse(commandType: subcommandType, arguments: arguments.dropFirst(index + 1), parentCommand: command)
                                    return
                                }
                                break
                            }
                        }
                    }
                }
            }
            // parse command
            try parseCommand(command: command, arguments: arguments)
            // setup
            do {
                try command.setup()
            } catch  {
                command.handleSetupError(error: error)
                exit(EXIT_FAILURE)
            }
        }
        
        mutating func parseCommand(command: OnyxCommand, arguments: ArraySlice<String>) throws {
            mirror(command: command)
            
            var parsingStrategy: Onyx.ParsingStrategy = .normal
            var currentOptionName: String? = nil
            var hasEqualSign: Bool = false
            var positionalArgumentIndex = 0

            // loop
            for arg in arguments {
                if arg.count == 0 {
                    continue
                }

                switch parsingStrategy {
                case .normal:
                    let c0 = arg.first!

                    if c0 != "-" {
                        // *
                        if let optionNameIndex = currentOptionName {
                            // =
                            if arg.count == 1 && c0 == "=" && !hasEqualSign {
                                hasEqualSign = true
                                continue
                            }
                            let (_, optionName) = nameIndexes[optionNameIndex]!
                            let option = options[optionName]!
                            let value = c0 == "=" && !hasEqualSign ? String(arg.dropFirst()) : arg
                            
                            do {
                                try setValue(option: option, value: value)
                            } catch {
                                throw ArgumentParserError.invalidOptionValue(option: "--\(optionNameIndex)", value: value, reason: error)
                            }
                            
                            currentOptionName = nil
                            hasEqualSign = false
                            continue
                        }
                        
                        // positional
                        break
                    }

                    // -

                    if arg.count == 1 {
                        // "-" only
                        throw Onyx.ArgumentParserError.unknownOption(arg)
                    }

                    // arg.count >= 2

                    if let optionNameIndex = currentOptionName {
                        let (_, optionName) = nameIndexes[optionNameIndex]!
                        let option = options[optionName]!
                        do {
                            try setDefaultValue(option: option)
                        } catch {
                            throw Onyx.ArgumentParserError.invalidOptionDefaultValue(option: "--\(optionNameIndex)", reason: error)
                        }
                        
                        currentOptionName = nil
                        hasEqualSign = false
                    }

                    if arg[arg.index(after: arg.startIndex)] == "-" {
                        if arg.count == 2 {
                            // "--" only
                            parsingStrategy = .allPositional
                            continue
                        }
                        // arg.count > 2
                        let nameStartIndex = arg.index(arg.startIndex, offsetBy: 2)
                        let lastIndex = arg.index(before: arg.endIndex)
                        if let equalIndex = arg.firstIndex(of: "=") {
                            if equalIndex == nameStartIndex {
                                // --=*
                                throw Onyx.ArgumentParserError.unknownOption(arg)
                            } else if equalIndex == lastIndex {
                                // --*=
                                let nameIndex = String(arg[nameStartIndex..<equalIndex])
                                guard let (nameType, _) = nameIndexes[nameIndex] else {
                                    // option not found
                                    throw Onyx.ArgumentParserError.unknownOption("--\(nameIndex)")
                                }
                                switch nameType {
                                case .flag:
                                    throw Onyx.ArgumentParserError.unknownFlag("--\(nameIndex)")
                                case .option:
                                    currentOptionName = nameIndex
                                    hasEqualSign = true
                                    continue
                                }
                            } else {
                                // --*=*
                                let nameIndex = String(arg[nameStartIndex..<equalIndex])
                                guard let (nameType, name) = nameIndexes[nameIndex] else {
                                    throw Onyx.ArgumentParserError.unknownOption("--\(nameIndex)")
                                }
                                switch nameType {
                                case .flag:
                                    throw Onyx.ArgumentParserError.unknownFlag("--\(nameIndex)")
                                case .option:
                                    let option = options[name]!
                                    let value = String(arg.suffix(from: arg.index(after: equalIndex)))
                                    
                                    do {
                                        try setValue(option: option, value: value)
                                    } catch {
                                        throw ArgumentParserError.invalidOptionValue(option: "--\(nameIndex)", value: value, reason: error)
                                    }
                                    
                                    continue
                                }
                            }
                        } else {
                            // --*
                            let nameIndex = String(arg.suffix(from: nameStartIndex))
                            guard let (nameType, name) = nameIndexes[nameIndex] else {
                                // option not found
                                throw Onyx.ArgumentParserError.unknownOption("--\(nameIndex)")
                            }

                            switch nameType {
                            case .flag:
                                let flag = flags[name]!
                                
                                do {
                                    try setValue(flag: flag)
                                } catch {
                                    throw Onyx.ArgumentParserError.invalidFlagValue(flag: "--\(nameIndex)", reason: error)
                                }
                                
                                continue
                            case .option:
                                currentOptionName = nameIndex
                                hasEqualSign = false
                                continue
                            }
                        }
                    } else {
                        let nameStartIndex = arg.index(after: arg.startIndex)
                        let lastIndex = arg.index(before: arg.endIndex)
                        if let equalIndex = arg.firstIndex(of: "=") {
                            if equalIndex == nameStartIndex {
                                // -=*
                                throw Onyx.ArgumentParserError.unknownOption(arg)
                            } else if equalIndex == lastIndex {
                                // -*=
                                let nameIndex = String(arg[nameStartIndex..<equalIndex])
                                guard let (nameType, _) = nameIndexes[nameIndex] else {
                                    // option not found
                                    throw Onyx.ArgumentParserError.unknownOption(arg)
                                }
                                switch nameType {
                                case .flag:
                                    throw Onyx.ArgumentParserError.unknownFlag(arg)
                                case .option:
                                    currentOptionName = nameIndex
                                    hasEqualSign = true
                                    continue
                                }
                            } else {
                                // -*=*
                                let nameIndex = String(arg[nameStartIndex..<equalIndex])
                                guard let (nameType, name) = nameIndexes[nameIndex] else {
                                    throw Onyx.ArgumentParserError.unknownOption("-\(nameIndex)")
                                }
                                switch nameType {
                                case .flag:
                                    throw Onyx.ArgumentParserError.unknownFlag("-\(nameIndex)")
                                case .option:
                                    let option = options[name]!
                                    let value = String(arg.suffix(from: arg.index(after: equalIndex)))
                                    
                                    do {
                                        try setValue(option: option, value: value)
                                    } catch {
                                        throw ArgumentParserError.invalidOptionValue(option: "-\(nameIndex)", value: value, reason: error)
                                    }
                                    
                                    continue
                                }
                            }
                        } else {
                            // -*
                            let nameIndex = String(arg.suffix(from: nameStartIndex))
                            if let (nameType, name) = nameIndexes[nameIndex] {
                                switch nameType {
                                case .flag:
                                    let flag = flags[name]!
                                    do {
                                        try setValue(flag: flag)
                                    } catch {
                                        throw Onyx.ArgumentParserError.invalidFlagValue(flag: "-\(nameIndex)", reason: error)
                                    }
                                    continue
                                case .option:
                                    currentOptionName = nameIndex
                                    hasEqualSign = false
                                    continue
                                }
                            }
                            
                            // is number?
                            if Double(arg) != nil {
                                break
                            }

                            // is compound?
                            for c in nameIndex {
                                guard let (nameType, name) = nameIndexes[String(c)], nameType == .flag else {
                                    throw Onyx.ArgumentParserError.unknownFlag("-\(String(c))")
                                }
                                let flag = flags[name]!
                                do {
                                    try setValue(flag: flag)
                                } catch {
                                    throw Onyx.ArgumentParserError.invalidFlagValue(flag: "-\(String(c))", reason: error)
                                }
                                continue
                            }
                        }
                    }
                    continue
                case .allPositional:
                    break
                }

                // positional
                guard positionalArgumentIndex < positionalArguments.count else {
                    throw Onyx.ArgumentParserError.unexpectedArgument(arg)
                }
                let argument = positionalArguments[positionalArgumentIndex]
                do {
                    try setValue(argument: argument, from: arg)
                } catch {
                    throw ArgumentParserError.invalidArgumentValue(index: positionalArgumentIndex, value: arg, reason: error)
                }
                
                if isCollection(argument: argument) {
                    continue
                }

                positionalArgumentIndex += 1
            }
            
            // unassigned option
            if let optionNameIndex = currentOptionName {
                let (_, optionName) = nameIndexes[optionNameIndex]!
                let option = options[optionName]!
                
                do {
                    try setDefaultValue(option: option)
                } catch {
                    throw Onyx.ArgumentParserError.invalidOptionDefaultValue(option: "--\(optionNameIndex)", reason: error)
                }
                
                currentOptionName = nil
                hasEqualSign = false
            }

            // set default values for values
            for (_, value) in values {
                try valueSetDefaultIfNeeded(value: value)
            }
            
            // set default values for values positionalArguments
            for (index, argument) in positionalArguments.enumerated() {
                do {
                    try setDefaultIfNeeded(argument: argument)
                } catch {
                    throw Onyx.ArgumentParserError.invalidArgumentDefaultValue(index: index, reason: error)
                }
            }
        }
    }
}
