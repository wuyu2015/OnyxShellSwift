import Foundation

extension Onyx {
    public enum ArgumentParserError: LocalizedError {
        case invalidArgumentDefaultValue(index: Int, reason: Error)
        case invalidArgumentValue(index: Int, value: String, reason: Error)
        case invalidFlagValue(flag: String, reason: Error)
        case invalidOptionDefaultValue(option: String, reason: Error)
        case invalidOptionValue(option: String, value: String, reason: Error)
        case missingArgument(Int)
        case missingOption(String)
        case missingOptionValue(String)
        case missingValue(String)
        case unexpectedArgument(String)
        case unknownFlag(String)
        case unknownOption(String)
        
        
        public var errorDescription: String? {
            switch self {
            case .invalidArgumentDefaultValue(let index, let reason):
                if let reason = reason as? LocalizedError, let s = reason.errorDescription {
                    return "invalid argument default value at position: \(index)\n\(s)"
                }
                return "invalid argument default value at position: \(index)"
            case .invalidArgumentValue(let index, let value, let reason):
                if let reason = reason as? LocalizedError, let s = reason.errorDescription {
                    return "Invalid Argument at position: \(index), value: '\(value)'\n\(s)"
                }
                return "invalid argument at position: \(index), value: '\(value)'"
            case .invalidFlagValue(let flag, let reason):
                if let reason = reason as? LocalizedError, let s = reason.errorDescription {
                    return "invalid default value for flag: \(flag)\n\(s)"
                }
                return "invalid default value for flag: \(flag)"
            case .invalidOptionDefaultValue(let option, let reason):
                if let reason = reason as? LocalizedError, let s = reason.errorDescription {
                    return "invalid default value for option: \(option)\n\(s)"
                }
                return "invalid default value for option: \(option)"
            case .invalidOptionValue(let option, let value, let reason):
                if let reason = reason as? LocalizedError, let s = reason.errorDescription {
                    return "invalid option: \(option), value: '\(value)'\n\(s)"
                }
                return "invalid option: \(option), value: '\(value)'"
            case .missingOptionValue(let s):
                return "option \(s) requires a value"
            case .missingArgument(let index):
                return "missing argument at position \(index)"
            case .missingOption(let s):
                return "missing required option: \(s)"
            case .missingValue(let s):
                return "missing value for: \(s)"
            case .unexpectedArgument(let s):
                return "unexpected argument: \(s)"
            case .unknownFlag(let flag):
                return "unknown flag: \(flag)"
            case .unknownOption(let s):
                return "unknown option: \(s)"
            }
        }
    }
}
