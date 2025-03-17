@propertyWrapper
public struct Option<T> {
    
    @Value public var wrappedValue: T?
    public var projectedValue: Self {
        get { self }
        set { self = newValue }
    }
    
    public let ref: String?
    public let name: String?
    public let shortName: String?
    public let aliases: [String]?
    public let abstract: String?
    public let discussion: String?
    public let hidden: Bool
    
    public init(wrappedValue: T?) {
        self.init(
            wrappedValue: wrappedValue,
            exclusivity: .exclusive,
            ref: nil,
            name: nil,
            shortName: nil,
            aliases: nil,
            default: nil,
            abstract: nil,
            discussion: nil,
            hidden: false
        )
    }
    
    public init(default defaultValue: T) {
        self.init(
            wrappedValue: nil,
            exclusivity: .exclusive,
            ref: nil,
            name: nil,
            shortName: nil,
            aliases: nil,
            default: defaultValue,
            abstract: nil,
            discussion: nil,
            hidden: false
        )
    }
    
    public init(exclusivity: Onyx.ValueExclusivity) {
        self.init(
            wrappedValue: nil,
            exclusivity: exclusivity,
            ref: nil,
            name: nil,
            shortName: nil,
            aliases: nil,
            default: nil,
            abstract: nil,
            discussion: nil,
            hidden: false
        )
    }
    
    public init(abstract: String) {
        self.init(
            wrappedValue: nil,
            exclusivity: .exclusive,
            ref: nil,
            name: nil,
            shortName: nil,
            aliases: nil,
            default: nil,
            abstract: abstract,
            discussion: nil,
            hidden: false
        )
    }
    
    public init(abstract: String, discussion: String) {
        self.init(
            wrappedValue: nil,
            exclusivity: .exclusive,
            ref: nil,
            name: nil,
            shortName: nil,
            aliases: nil,
            default: nil,
            abstract: abstract,
            discussion: discussion,
            hidden: false
        )
    }
    
    public init(ref: String) {
        self.init(
            wrappedValue: nil,
            exclusivity: .exclusive,
            ref: ref,
            name: nil,
            shortName: nil,
            aliases: nil,
            default: nil,
            abstract: nil,
            discussion: nil,
            hidden: false
        )
    }
    
    public init(name: String) {
        self.init(
            wrappedValue: nil,
            exclusivity: .exclusive,
            ref: nil,
            name: name,
            shortName: nil,
            aliases: nil,
            default: nil,
            abstract: nil,
            discussion: nil,
            hidden: false
        )
    }
    
    public init(shortName: String) {
        self.init(
            wrappedValue: nil,
            exclusivity: .exclusive,
            ref: nil,
            name: nil,
            shortName: shortName,
            aliases: nil,
            default: nil,
            abstract: nil,
            discussion: nil,
            hidden: false
        )
    }
    
    public init(aliases: [String]) {
        self.init(
            wrappedValue: nil,
            exclusivity: .exclusive,
            ref: nil,
            name: nil,
            shortName: nil,
            aliases: aliases,
            default: nil,
            abstract: nil,
            discussion: nil,
            hidden: false
        )
    }
    
    public init(hidden: Bool) {
        self.init(
            wrappedValue: nil,
            exclusivity: .exclusive,
            ref: nil,
            name: nil,
            shortName: nil,
            aliases: nil,
            default: nil,
            abstract: nil,
            discussion: nil,
            hidden: hidden
        )
    }
    
    public init(
        wrappedValue: T? = nil,
        exclusivity: Onyx.ValueExclusivity = .exclusive,
        ref: String? = nil,
        name: String? = nil,
        shortName: String? = nil,
        aliases: [String]? = nil,
        default defaultValue: T? = nil,
        abstract: String? = nil,
        discussion: String? = nil,
        hidden: Bool = false
    ) {
        // ref
        precondition(ref == nil || !ref!.isEmpty)
        precondition(ref == nil || Onyx.Utils.Str.isIdentifier(ref!))
        
        // name
        precondition(name == nil || !name!.isEmpty)
        precondition(name == nil || Onyx.Utils.Str.isValidName(name!))
        
        // shortName
        precondition(shortName == nil || (shortName!.count == 1 && Onyx.Utils.Str.isValidName(shortName!)))
        
        // aliases
        precondition(aliases == nil || !aliases!.isEmpty)
        precondition(aliases == nil || aliases!.allSatisfy { !$0.isEmpty && Onyx.Utils.Str.isValidName($0) })
        
        // abstract
        precondition(abstract == nil || !abstract!.isEmpty)
        
        // discussion
        precondition(discussion == nil || !discussion!.isEmpty)
        
        self._wrappedValue = Value(wrappedValue: wrappedValue, default: defaultValue, exclusivity: exclusivity)
        
        self.ref = ref
        self.name = name
        self.shortName = shortName
        self.aliases = aliases
        self.abstract = abstract
        self.discussion = discussion
        self.hidden = hidden
    }
    
    public func parseValue(from rawValue: String) throws -> T? {
        return try _wrappedValue.parseValue(from: rawValue)
    }
    
    public func setValue(from rawValue: String) throws -> T? {
        return try _wrappedValue.setValue(from: rawValue)
    }
    
    public func setDefaultIfNeeded() -> T? {
        return _wrappedValue.setDefaultIfNeeded()
    }
}
