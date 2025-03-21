@propertyWrapper
public struct Argument<T> {
    
    @Value public var wrappedValue: T?
    public var projectedValue: Self {
        get { self }
        set { self = newValue }
    }
    
    public let ref: String?
    public let required: Bool
    
    public init(wrappedValue: T?) {
        self.init(
            wrappedValue: wrappedValue,
            default: nil,
            exclusivity: .exclusive,
            ref: nil,
            required: true
        )
    }
    
    public init(default defaultValue: T) {
        self.init(
            wrappedValue: nil,
            default: defaultValue,
            exclusivity: .exclusive,
            ref: nil,
            required: true
        )
    }
    
    public init(exclusivity: Onyx.ValueExclusivity) {
        self.init(
            wrappedValue: nil,
            default: nil,
            exclusivity: exclusivity,
            ref: nil,
            required: true
        )
    }
    
    public init(ref: String) {
        self.init(
            wrappedValue: nil,
            default: nil,
            exclusivity: .exclusive,
            ref: ref,
            required: true
        )
    }
    
    public init(required: Bool) {
        self.init(
            wrappedValue: nil,
            default: nil,
            exclusivity: .exclusive,
            ref: nil,
            required: required
        )
    }
    
    public init(
        wrappedValue: T? = nil,
        default defaultValue: T? = nil,
        exclusivity: Onyx.ValueExclusivity = .exclusive,
        ref: String? = nil,
        required: Bool = true
    ) {
        // ref
        precondition(ref == nil || !ref!.isEmpty)
        precondition(ref == nil || Onyx.Utils.Str.isIdentifier(ref!))
        
        self._wrappedValue = Value(wrappedValue: wrappedValue, default: defaultValue, exclusivity: exclusivity)
        
        self.ref = ref
        self.required = required
    }
    
    func parseValue(from rawValue: String) throws -> T? {
        return try _wrappedValue.parseValue(from: rawValue)
    }
    
    func setValue(from rawValue: String) throws -> T? {
        return try _wrappedValue.setValue(from: rawValue)
    }
    
    func setDefaultIfNeeded() -> T? {
        return _wrappedValue.setDefaultIfNeeded()
    }
}
