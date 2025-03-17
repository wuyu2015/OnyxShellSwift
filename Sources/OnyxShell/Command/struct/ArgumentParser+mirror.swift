extension Onyx.ArgumentParser {
    
    mutating func mirror(command: OnyxCommand) {
        self.values.removeAll(keepingCapacity: true)
        self.positionalArguments.removeAll(keepingCapacity: true)
        self.options.removeAll(keepingCapacity: true)
        self.flags.removeAll(keepingCapacity: true)
        self.nameIndexes.removeAll(keepingCapacity: true)
        
        var foundCollectionPositionalArgument = false
        
        for case let (label?, value) in Mirror(reflecting: command).children {
            
            if label.isEmpty || label.first! != "_" {
                continue
            }
            
            let name = String(label.dropFirst())
            switch value {
                
            // MARK: values
            case is Value<String>, is Value<Int>, is Value<Double>, is Value<Bool>, is Value<[String]>, is Value<[Int]>, is Value<[Double]>, is Value<[Bool]>, is Value<[String: String]>:
                values[name] = value
                
            // MARK: positionalArguments
            case is Argument<String>, is Argument<Int>, is Argument<Double>, is Argument<Bool>:
                positionalArguments.append(value)
                
            case is Argument<[String]>, is Argument<[Int]>, is Argument<[Double]>, is Argument<[Bool]>, is Argument<[String: String]>:
                precondition(!foundCollectionPositionalArgument)
                foundCollectionPositionalArgument = true
                positionalArguments.append(value)
                
            // MARK: options, nameIndexes
            case is Option<String>:
                options[name] = value
                let option = value as! Option<String>
                let optionName = option.name ?? Onyx.Utils.Str.toKebabCase(name)
                precondition(nameIndexes[optionName] == nil)
                nameIndexes[optionName] = (.option, name)
                if let shortName = option.shortName {
                    precondition(nameIndexes[shortName] == nil)
                    nameIndexes[shortName] = (.option, name)
                }
                if let aliases = option.aliases {
                    for alias in aliases {
                        precondition(nameIndexes[alias] == nil)
                        nameIndexes[alias] = (.option, name)
                    }
                }
            case is Option<Int>:
                options[name] = value
                let option = value as! Option<Int>
                let optionName = option.name ?? Onyx.Utils.Str.toKebabCase(name)
                precondition(nameIndexes[optionName] == nil)
                nameIndexes[optionName] = (.option, name)
                if let shortName = option.shortName {
                    precondition(nameIndexes[shortName] == nil)
                    nameIndexes[shortName] = (.option, name)
                }
                if let aliases = option.aliases {
                    for alias in aliases {
                        precondition(nameIndexes[alias] == nil)
                        nameIndexes[alias] = (.option, name)
                    }
                }
            case is Option<Double>:
                options[name] = value
                let option = value as! Option<Double>
                let optionName = option.name ?? Onyx.Utils.Str.toKebabCase(name)
                precondition(nameIndexes[optionName] == nil)
                nameIndexes[optionName] = (.option, name)
                if let shortName = option.shortName {
                    precondition(nameIndexes[shortName] == nil)
                    nameIndexes[shortName] = (.option, name)
                }
                if let aliases = option.aliases {
                    for alias in aliases {
                        precondition(nameIndexes[alias] == nil)
                        nameIndexes[alias] = (.option, name)
                    }
                }
            case is Option<Bool>:
                options[name] = value
                let option = value as! Option<Bool>
                let optionName = option.name ?? Onyx.Utils.Str.toKebabCase(name)
                precondition(nameIndexes[optionName] == nil)
                nameIndexes[optionName] = (.option, name)
                if let shortName = option.shortName {
                    precondition(nameIndexes[shortName] == nil)
                    nameIndexes[shortName] = (.option, name)
                }
                if let aliases = option.aliases {
                    for alias in aliases {
                        precondition(nameIndexes[alias] == nil)
                        nameIndexes[alias] = (.option, name)
                    }
                }
            case is Option<[String]>:
                options[name] = value
                let option = value as! Option<[String]>
                let optionName = option.name ?? Onyx.Utils.Str.toKebabCase(name)
                precondition(nameIndexes[optionName] == nil)
                nameIndexes[optionName] = (.option, name)
                if let shortName = option.shortName {
                    precondition(nameIndexes[shortName] == nil)
                    nameIndexes[shortName] = (.option, name)
                }
                if let aliases = option.aliases {
                    for alias in aliases {
                        precondition(nameIndexes[alias] == nil)
                        nameIndexes[alias] = (.option, name)
                    }
                }
            case is Option<[Int]>:
                options[name] = value
                let option = value as! Option<[Int]>
                let optionName = option.name ?? Onyx.Utils.Str.toKebabCase(name)
                precondition(nameIndexes[optionName] == nil)
                nameIndexes[optionName] = (.option, name)
                if let shortName = option.shortName {
                    precondition(nameIndexes[shortName] == nil)
                    nameIndexes[shortName] = (.option, name)
                }
                if let aliases = option.aliases {
                    for alias in aliases {
                        precondition(nameIndexes[alias] == nil)
                        nameIndexes[alias] = (.option, name)
                    }
                }
            case is Option<[Double]>:
                options[name] = value
                let option = value as! Option<[Double]>
                let optionName = option.name ?? Onyx.Utils.Str.toKebabCase(name)
                precondition(nameIndexes[optionName] == nil)
                nameIndexes[optionName] = (.option, name)
                if let shortName = option.shortName {
                    precondition(nameIndexes[shortName] == nil)
                    nameIndexes[shortName] = (.option, name)
                }
                if let aliases = option.aliases {
                    for alias in aliases {
                        precondition(nameIndexes[alias] == nil)
                        nameIndexes[alias] = (.option, name)
                    }
                }
            case is Option<[Bool]>:
                options[name] = value
                let option = value as! Option<[Bool]>
                let optionName = option.name ?? Onyx.Utils.Str.toKebabCase(name)
                precondition(nameIndexes[optionName] == nil)
                nameIndexes[optionName] = (.option, name)
                if let shortName = option.shortName {
                    precondition(nameIndexes[shortName] == nil)
                    nameIndexes[shortName] = (.option, name)
                }
                if let aliases = option.aliases {
                    for alias in aliases {
                        precondition(nameIndexes[alias] == nil)
                        nameIndexes[alias] = (.option, name)
                    }
                }
            case is Option<[String: String]>:
                options[name] = value
                let option = value as! Option<[String: String]>
                let optionName = option.name ?? Onyx.Utils.Str.toKebabCase(name)
                precondition(nameIndexes[optionName] == nil)
                nameIndexes[optionName] = (.option, name)
                if let shortName = option.shortName {
                    precondition(nameIndexes[shortName] == nil)
                    nameIndexes[shortName] = (.option, name)
                }
                if let aliases = option.aliases {
                    for alias in aliases {
                        precondition(nameIndexes[alias] == nil)
                        nameIndexes[alias] = (.option, name)
                    }
                }
                
            // MARK: flags, nameIndexes
            case is Flag<String>:
                flags[name] = value
                let flag = value as! Flag<String>
                let flagName = flag.name ?? Onyx.Utils.Str.toKebabCase(name)
                precondition(nameIndexes[flagName] == nil)
                nameIndexes[flagName] = (.flag, name)
                if let shortName = flag.shortName {
                    precondition(nameIndexes[shortName] == nil)
                    nameIndexes[shortName] = (.flag, name)
                }
                if let aliases = flag.aliases {
                    for alias in aliases {
                        precondition(nameIndexes[alias] == nil)
                        nameIndexes[alias] = (.flag, name)
                    }
                }
            case is Flag<Int>:
                flags[name] = value
                let flag = value as! Flag<Int>
                let flagName = flag.name ?? Onyx.Utils.Str.toKebabCase(name)
                precondition(nameIndexes[flagName] == nil)
                nameIndexes[flagName] = (.flag, name)
                if let shortName = flag.shortName {
                    precondition(nameIndexes[shortName] == nil)
                    nameIndexes[shortName] = (.flag, name)
                }
                if let aliases = flag.aliases {
                    for alias in aliases {
                        precondition(nameIndexes[alias] == nil)
                        nameIndexes[alias] = (.flag, name)
                    }
                }
            case is Flag<Double>:
                flags[name] = value
                let flag = value as! Flag<Double>
                let flagName = flag.name ?? Onyx.Utils.Str.toKebabCase(name)
                precondition(nameIndexes[flagName] == nil)
                nameIndexes[flagName] = (.flag, name)
                if let shortName = flag.shortName {
                    precondition(nameIndexes[shortName] == nil)
                    nameIndexes[shortName] = (.flag, name)
                }
                if let aliases = flag.aliases {
                    for alias in aliases {
                        precondition(nameIndexes[alias] == nil)
                        nameIndexes[alias] = (.flag, name)
                    }
                }
            case is Flag<Bool>:
                flags[name] = value
                let flag = value as! Flag<Bool>
                let flagName = flag.name ?? Onyx.Utils.Str.toKebabCase(name)
                precondition(nameIndexes[flagName] == nil)
                nameIndexes[flagName] = (.flag, name)
                if let shortName = flag.shortName {
                    precondition(nameIndexes[shortName] == nil)
                    nameIndexes[shortName] = (.flag, name)
                }
                if let aliases = flag.aliases {
                    for alias in aliases {
                        precondition(nameIndexes[alias] == nil)
                        nameIndexes[alias] = (.flag, name)
                    }
                }
            case is Flag<[String]>:
                flags[name] = value
                let flag = value as! Flag<[String]>
                let flagName = flag.name ?? Onyx.Utils.Str.toKebabCase(name)
                precondition(nameIndexes[flagName] == nil)
                nameIndexes[flagName] = (.flag, name)
                if let shortName = flag.shortName {
                    precondition(nameIndexes[shortName] == nil)
                    nameIndexes[shortName] = (.flag, name)
                }
                if let aliases = flag.aliases {
                    for alias in aliases {
                        precondition(nameIndexes[alias] == nil)
                        nameIndexes[alias] = (.flag, name)
                    }
                }
            case is Flag<[Int]>:
                flags[name] = value
                let flag = value as! Flag<[Int]>
                let flagName = flag.name ?? Onyx.Utils.Str.toKebabCase(name)
                precondition(nameIndexes[flagName] == nil)
                nameIndexes[flagName] = (.flag, name)
                if let shortName = flag.shortName {
                    precondition(nameIndexes[shortName] == nil)
                    nameIndexes[shortName] = (.flag, name)
                }
                if let aliases = flag.aliases {
                    for alias in aliases {
                        precondition(nameIndexes[alias] == nil)
                        nameIndexes[alias] = (.flag, name)
                    }
                }
            case is Flag<[Double]>:
                flags[name] = value
                let flag = value as! Flag<[Double]>
                let flagName = flag.name ?? Onyx.Utils.Str.toKebabCase(name)
                precondition(nameIndexes[flagName] == nil)
                nameIndexes[flagName] = (.flag, name)
                if let shortName = flag.shortName {
                    precondition(nameIndexes[shortName] == nil)
                    nameIndexes[shortName] = (.flag, name)
                }
                if let aliases = flag.aliases {
                    for alias in aliases {
                        precondition(nameIndexes[alias] == nil)
                        nameIndexes[alias] = (.flag, name)
                    }
                }
            case is Flag<[Bool]>:
                flags[name] = value
                let flag = value as! Flag<[Bool]>
                let flagName = flag.name ?? Onyx.Utils.Str.toKebabCase(name)
                precondition(nameIndexes[flagName] == nil)
                nameIndexes[flagName] = (.flag, name)
                if let shortName = flag.shortName {
                    precondition(nameIndexes[shortName] == nil)
                    nameIndexes[shortName] = (.flag, name)
                }
                if let aliases = flag.aliases {
                    for alias in aliases {
                        precondition(nameIndexes[alias] == nil)
                        nameIndexes[alias] = (.flag, name)
                    }
                }
            case is Flag<[String: String]>:
                flags[name] = value
                let flag = value as! Flag<[String: String]>
                let flagName = flag.name ?? Onyx.Utils.Str.toKebabCase(name)
                precondition(nameIndexes[flagName] == nil)
                nameIndexes[flagName] = (.flag, name)
                if let shortName = flag.shortName {
                    precondition(nameIndexes[shortName] == nil)
                    nameIndexes[shortName] = (.flag, name)
                }
                if let aliases = flag.aliases {
                    for alias in aliases {
                        precondition(nameIndexes[alias] == nil)
                        nameIndexes[alias] = (.flag, name)
                    }
                }
            default:
                continue
            }
        }
    }
}
