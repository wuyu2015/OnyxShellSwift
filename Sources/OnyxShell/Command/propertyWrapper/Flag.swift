@propertyWrapper
public struct Flag<T> {
    
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
    
    public init() {
        let value: T
        switch T.self {
        case is String.Type:
            value = "" as! T
        case is Int.Type:
            value = 1 as! T
        case is Double.Type:
            value = 1.0 as! T
        case is Bool.Type:
            value = true as! T
        case is [String].Type:
            value = [""] as! T
        case is [Int].Type:
            value = [1] as! T
        case is [Double].Type:
            value = [1.0] as! T
        case is [Bool].Type:
            value = [true] as! T
        default:
            fatalError()
        }
        
        self.init(
            wrappedValue: nil,
            value,
            exclusivity: .exclusive,
            ref: nil,
            name: nil,
            shortName: nil,
            aliases: nil,
            abstract: nil,
            discussion: nil,
            hidden: false
        )
    }
    
    public init(_ value: T) {
        self.init(
            wrappedValue: nil,
            value,
            exclusivity: .exclusive,
            ref: nil,
            name: nil,
            shortName: nil,
            aliases: nil,
            abstract: nil,
            discussion: nil,
            hidden: false
        )
    }
    
    public init(wrappedValue: T?, _ value: T) {
        self.init(
            wrappedValue: wrappedValue,
            value,
            exclusivity: .exclusive,
            ref: nil,
            name: nil,
            shortName: nil,
            aliases: nil,
            abstract: nil,
            discussion: nil,
            hidden: false
        )
    }
    
    public init(_ value: T, exclusivity: Onyx.ValueExclusivity) {
        self.init(
            wrappedValue: nil,
            value,
            exclusivity: exclusivity,
            ref: nil,
            name: nil,
            shortName: nil,
            aliases: nil,
            abstract: nil,
            discussion: nil,
            hidden: false
        )
    }
    
    public init(_ value: T, abstract: String) {
        self.init(
            wrappedValue: nil,
            value,
            exclusivity: .exclusive,
            ref: nil,
            name: nil,
            shortName: nil,
            aliases: nil,
            abstract: abstract,
            discussion: nil,
            hidden: false
        )
    }
    
    public init(_ value: T, abstract: String, discussion: String) {
        self.init(
            wrappedValue: nil,
            value,
            exclusivity: .exclusive,
            ref: nil,
            name: nil,
            shortName: nil,
            aliases: nil,
            abstract: abstract,
            discussion: discussion,
            hidden: false
        )
    }
    
    public init(_ value: T, ref: String) {
        self.init(
            wrappedValue: nil,
            value,
            exclusivity: .exclusive,
            ref: ref,
            name: nil,
            shortName: nil,
            aliases: nil,
            abstract: nil,
            discussion: nil,
            hidden: false
        )
    }
    
    public init(_ value: T, name: String) {
        self.init(
            wrappedValue: nil,
            value,
            exclusivity: .exclusive,
            ref: nil,
            name: name,
            shortName: nil,
            aliases: nil,
            abstract: nil,
            discussion: nil,
            hidden: false
        )
    }
    
    public init(_ value: T, shortName: String) {
        self.init(
            wrappedValue: nil,
            value,
            exclusivity: .exclusive,
            ref: nil,
            name: nil,
            shortName: shortName,
            aliases: nil,
            abstract: nil,
            discussion: nil,
            hidden: false
        )
    }
    
    public init(_ value: T, aliases: [String]) {
        self.init(
            wrappedValue: nil,
            value,
            exclusivity: .exclusive,
            ref: nil,
            name: nil,
            shortName: nil,
            aliases: aliases,
            abstract: nil,
            discussion: nil,
            hidden: false
        )
    }
    
    public init(_ value: T, hidden: Bool) {
        self.init(
            wrappedValue: nil,
            value,
            exclusivity: .exclusive,
            ref: nil,
            name: nil,
            shortName: nil,
            aliases: nil,
            abstract: nil,
            discussion: nil,
            hidden: hidden
        )
    }
    
    public init(
        wrappedValue: T? = nil,
        _ value: T,
        exclusivity: Onyx.ValueExclusivity = .exclusive,
        ref: String? = nil,
        name: String? = nil,
        shortName: String? = nil,
        aliases: [String]? = nil,
        abstract: String? = nil,
        discussion: String? = nil,
        hidden: Bool = false
    ) {
        // ref
        precondition(ref == nil || !ref!.isEmpty)
        precondition(ref == nil || Onyx.Utils.Str.isValidName(ref!))
        
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
        
        self._wrappedValue = Value(wrappedValue: wrappedValue, default: value, exclusivity: exclusivity)
        
        self.ref = ref
        self.name = name
        self.shortName = shortName
        self.aliases = aliases
        self.abstract = abstract
        self.discussion = discussion
        self.hidden = hidden
    }
    
    func setValue() -> T? {
        return _wrappedValue.setDefaultIfNeeded()
    }
}
