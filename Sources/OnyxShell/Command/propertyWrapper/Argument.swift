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
    public let required: Bool
    
    public init(wrappedValue: T?) {
        self.init(
            wrappedValue: wrappedValue,
            default: nil,
            exclusivity: .exclusive,
            abstract: nil,
            discussion: nil,
            ref: nil,
            required: true
        )
    }
    
    public init(default defaultValue: T) {
        self.init(
            wrappedValue: nil,
            default: defaultValue,
            exclusivity: .exclusive,
            abstract: nil,
            discussion: nil,
            ref: nil,
            required: true
        )
    }
    
    public init(exclusivity: Onyx.ValueExclusivity) {
        self.init(
            wrappedValue: nil,
            default: nil,
            exclusivity: exclusivity,
            abstract: nil,
            discussion: nil,
            ref: nil,
            required: true
        )
    }
    
    public init(abstract: String) {
        self.init(
            wrappedValue: nil,
            default: nil,
            exclusivity: .exclusive,
            abstract: abstract,
            discussion: nil,
            ref: nil,
            required: true
        )
    }
    
    public init(abstract: String, discussion: String) {
        self.init(
            wrappedValue: nil,
            default: nil,
            exclusivity: .exclusive,
            abstract: abstract,
            discussion: discussion,
            ref: nil,
            required: true
        )
    }
    
    public init(ref: String) {
        self.init(
            wrappedValue: nil,
            default: nil,
            exclusivity: .exclusive,
            abstract: nil,
            discussion: nil,
            ref: ref,
            required: true
        )
    }
    
    public init(required: Bool) {
        self.init(
            wrappedValue: nil,
            default: nil,
            exclusivity: .exclusive,
            abstract: nil,
            discussion: nil,
            ref: nil,
            required: required
        )
    }
    
    public init(
        wrappedValue: T? = nil,
        default defaultValue: T? = nil,
        exclusivity: Onyx.ValueExclusivity = .exclusive,
        abstract: String? = nil,
        discussion: String? = nil,
        ref: String? = nil,
        required: Bool = true
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
