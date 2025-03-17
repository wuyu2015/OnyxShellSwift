import Foundation

extension Onyx {
    public enum ValueError: LocalizedError {
        case duplicateExclusiveValues(Any)
        case wrongType(Any)
        
        public var errorDescription: String? {
            switch self {
            case .duplicateExclusiveValues(let value):
                return "Duplicate assignment is not allowed for exclusive value: \(value)"
            case .wrongType(let value):
                return "Incorrect value type for \(value)"
            }
        }
    }
}
