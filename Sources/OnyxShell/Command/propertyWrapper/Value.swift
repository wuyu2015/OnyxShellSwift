@propertyWrapper
public class Value<T> {
    
    public var wrappedValue: T? {
        get { value }
        set {
            if value != nil {
                switch exclusivity {
                case .chooseLast:
                    break
                case .chooseFirst:
                    return
                case .exclusive:
                    fatalError("Duplicate assignment is not allowed in exclusive mode.")
                }
            }
            value = newValue
        }
    }
    
    public var projectedValue: Value {
        get { self }
    }
    
    private var value: T?
    public let defaultValue: T?
    public let exclusivity: Onyx.ValueExclusivity
    
    public convenience init(wrappedValue: T? = nil) {
        self.init(wrappedValue: wrappedValue, default: nil, exclusivity: .exclusive)
    }
    
    public convenience init(wrappedValue: T? = nil, default defaultValue: T) {
        self.init(wrappedValue: wrappedValue, default: defaultValue, exclusivity: .exclusive)
    }
    
    public convenience init(wrappedValue: T? = nil, exclusivity: Onyx.ValueExclusivity) {
        self.init(wrappedValue: wrappedValue, default: nil, exclusivity: exclusivity)
    }
    
    public init(
        wrappedValue: T? = nil,
        default defaultValue: T? = nil,
        exclusivity: Onyx.ValueExclusivity = .exclusive
    ) {
        self.value = wrappedValue
        self.defaultValue = defaultValue
        self.exclusivity = T.self is String.Type || T.self is Int.Type || T.self is Double.Type || T.self is Bool.Type ? exclusivity : .chooseLast
    }
    
    var isCollection: Bool {
        switch T.self {
        case is [String].Type, is [Int].Type, is [Double].Type, is [Bool].Type, is [String: String].Type:
            return true
        default:
            return false
        }
    }
    
    func parseValue(from rawValue: String) throws -> T? {
        switch T.self {
        case is String.Type:
            if value != nil {
                switch exclusivity {
                case .chooseFirst:
                    return nil
                case .chooseLast:
                    break
                case .exclusive:
                    throw Onyx.ParseValueError.duplicateExclusiveValues(rawValue)
                }
            }
            return (rawValue as! T)
        case is Int.Type:
            if value != nil {
                switch exclusivity {
                case .chooseFirst:
                    return nil
                case .chooseLast:
                    break
                case .exclusive:
                    throw Onyx.ParseValueError.duplicateExclusiveValues(rawValue)
                }
            }
            guard let v = Int(rawValue) as? T  else {
                throw Onyx.ParseValueError.notAnInteger(rawValue)
            }
            return v
        case is Double.Type:
            if value != nil {
                switch exclusivity {
                case .chooseFirst:
                    return nil
                case .chooseLast:
                    break
                case .exclusive:
                    throw Onyx.ParseValueError.duplicateExclusiveValues(rawValue)
                }
            }
            guard let v = Double(rawValue) as? T  else {
                throw Onyx.ParseValueError.notADouble(rawValue)
            }
            return v
        case is Bool.Type:
            if value != nil {
                switch exclusivity {
                case .chooseFirst:
                    return nil
                case .chooseLast:
                    break
                case .exclusive:
                    throw Onyx.ParseValueError.duplicateExclusiveValues(rawValue)
                }
            }
            switch rawValue.lowercased() {
            case "true", "yes", "y":
                return (true as! T)
            case "false", "no", "n":
                return (false as! T)
            default:
                throw Onyx.ParseValueError.notABoolean(rawValue)
            }
            
            
        case is [String].Type:
            if value == nil {
                return ([rawValue] as! T)
            }
            var arr = value as! [String]
            arr.append(rawValue)
            return (arr as! T)
        case is [Int].Type:
            guard let v = Int(rawValue) else { throw Onyx.ParseValueError.notAnInteger(rawValue) }
            if value == nil {
                return ([v] as! T)
            }
            var arr = value as! [Int]
            arr.append(v)
            return (arr as! T)
        case is [Double].Type:
            guard let v = Double(rawValue) else { throw Onyx.ParseValueError.notADouble(rawValue) }
            if value == nil {
                return ([v] as! T)
            }
            var arr = value as! [Double]
            arr.append(v)
            return (arr as! T)
        case is [Bool].Type:
            var v: Bool
            switch rawValue.lowercased() {
            case "true", "yes", "y", "1":
                v = true
            case "false", "no", "n", "0":
                v = false
            default:
                throw Onyx.ParseValueError.notABoolean(rawValue)
            }
            if value == nil {
                return ([v] as! T)
            }
            var arr = value as! [Bool]
            arr.append(v)
            return (arr as! T)
        case is [String: String].Type:
            if let range = rawValue.range(of: "=") ?? rawValue.range(of: ":") {
                let k = String(rawValue[..<range.lowerBound])
                let v = String(rawValue[range.upperBound...])
                if value == nil {
                    return ([k: v] as! T)
                }
                var map = value as! [String: String]
                map[k] = v
                return (map as! T)
            }
            if value == nil {
                return ([rawValue: ""] as! T)
            }
            var map = value as! [String: String]
            map[rawValue] = ""
            return (map as! T)
        default:
            throw Onyx.ValueError.wrongType(value as Any)
        }
    }
    
    @discardableResult
    func setValue(_ newValue: T) throws -> Bool {
        if value != nil {
            if !isCollection {
                switch exclusivity {
                case .chooseFirst:
                    return false
                case .chooseLast:
                    break
                case .exclusive:
                    throw Onyx.ValueError.duplicateExclusiveValues(newValue)
                }
            }
        }
        value = newValue
        return true
    }
    
    @discardableResult
    func setValueIfNeeded(_ newValue: T) -> Bool {
        if value == nil {
            value = newValue
            return true
        }
        return false
    }
    
    @discardableResult
    func setValue(from rawValue: String) throws -> T? {
        if let v = try parseValue(from: rawValue) {
            value = v
            return value
        }
        return nil
    }
    
    @discardableResult
    func setDefaultIfNeeded() -> T? {
        if value == nil {
            if let defaultValue = defaultValue {
                value = defaultValue
                return value
            }
        }
        return nil
    }
}
