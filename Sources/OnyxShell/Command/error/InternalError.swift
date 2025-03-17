import Foundation

extension Onyx {
    public enum InternalError: LocalizedError {
        case invalidArgumentDefaultValue
        case invalidOptionDefaultValue
        case wrongType
        
        public var errorDescription: String? {
            switch self {
            case .invalidArgumentDefaultValue:
                return "Internal error: invalid argument default value"
            case .invalidOptionDefaultValue:
                return "Internal error: invalid option default value"
            case .wrongType:
                return "Internal error: incorrect value type"
            }
        }
    }
}
