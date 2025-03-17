@propertyWrapper
public struct Argument<T> {
    
    @Value public var wrappedValue: T?
    public var projectedValue: Self {
        get { self }
        set { self = newValue }
    }
    
    public let abstract: String?
    public let discussion: String?
    public let ref: String?
    
    public init(wrappedValue: T?) {
        self.init(
            wrappedValue: wrappedValue,
            default: nil,
            exclusivity: .exclusive,
            abstract: nil,
            discussion: nil,
            ref: nil
        )
    }
    
    public init(default defaultValue: T) {
        self.init(
            wrappedValue: nil,
            default: defaultValue,
            exclusivity: .exclusive,
            abstract: nil,
            discussion: nil,
            ref: nil
        )
    }
    
    public init(exclusivity: Onyx.ValueExclusivity) {
        self.init(
            wrappedValue: nil,
            default: nil,
            exclusivity: exclusivity,
            abstract: nil,
            discussion: nil,
            ref: nil
        )
    }
    
    public init(abstract: String) {
        self.init(
            wrappedValue: nil,
            default: nil,
            exclusivity: .exclusive,
            abstract: abstract,
            discussion: nil,
            ref: nil
        )
    }
    
    public init(abstract: String, discussion: String) {
        self.init(
            wrappedValue: nil,
            default: nil,
            exclusivity: .exclusive,
            abstract: abstract,
            discussion: discussion,
            ref: nil
        )
    }
    
    public init(ref: String) {
        self.init(
            wrappedValue: nil,
            default: nil,
            exclusivity: .exclusive,
            abstract: nil,
            discussion: nil,
            ref: ref
        )
    }
    
    public init(
        wrappedValue: T? = nil,
        default defaultValue: T? = nil,
        exclusivity: Onyx.ValueExclusivity = .exclusive,
        abstract: String? = nil,
        discussion: String? = nil,
        ref: String? = nil
    ) {
        // abstract
        precondition(abstract == nil || !abstract!.isEmpty)
        
        // discussion
        precondition(discussion == nil || !discussion!.isEmpty)
        
        // ref
        precondition(ref == nil || !ref!.isEmpty)
        precondition(ref == nil || Onyx.Utils.Str.isIdentifier(ref!))
        
        self._wrappedValue = Value(wrappedValue: wrappedValue, default: defaultValue, exclusivity: exclusivity)
        
        self.abstract = abstract
        self.discussion = discussion
        self.ref = ref
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
