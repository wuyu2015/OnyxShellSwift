import Foundation

extension Onyx {
    public enum ParseValueError: LocalizedError {
        case duplicateExclusiveValues(String)
        case notABoolean(String)
        case notADictionary(String)
        case notADouble(String)
        case notAnInteger(String)
        
        public var errorDescription: String? {
            switch self {
            case .duplicateExclusiveValues(let s):
                return "Duplicate assignment is not allowed for exclusive option: \(s)"
            case .notABoolean(let s):
                return "Expected a boolean value, but got: \(s)"
            case .notADictionary(let s):
                return "Expected a dictionary value, but got: \(s)"
            case .notADouble(let s):
                return "Expected a double value, but got: \(s)"
            case .notAnInteger(let s):
                return "Expected an integer value, but got: \(s)"
            }
        }
    }
}
