extension Onyx.ArgumentParser {
    
    func valueSetValue(value: Any, from rawValue: String) throws {
        switch value.self {
        case is Value<String>:
            try (value as! Value<String>).setValue(from: rawValue)
        case is Value<Int>:
            try (value as! Value<Int>).setValue(from: rawValue)
        case is Value<Double>:
            try (value as! Value<Double>).setValue(from: rawValue)
        case is Value<Bool>:
            try (value as! Value<Bool>).setValue(from: rawValue)
        case is Value<[String]>:
            try (value as! Value<[String]>).setValue(from: rawValue)
        case is Value<[Int]>:
            try (value as! Value<[Int]>).setValue(from: rawValue)
        case is Value<[Double]>:
            try (value as! Value<[Double]>).setValue(from: rawValue)
        case is Value<[Bool]>:
            try (value as! Value<[Bool]>).setValue(from: rawValue)
        case is Value<[String: String]>:
            try (value as! Value<[String: String]>).setValue(from: rawValue)
        default:
            throw Onyx.InternalError.wrongType
        }
    }
    
    func valueSetDefaultIfNeeded(value: Any) throws {
        switch value.self {
        case is Value<String>:
            (value as! Value<String>).setDefaultIfNeeded()
        case is Value<Int>:
            (value as! Value<Int>).setDefaultIfNeeded()
        case is Value<Double>:
            (value as! Value<Double>).setDefaultIfNeeded()
        case is Value<Bool>:
            (value as! Value<Bool>).setDefaultIfNeeded()
        case is Value<[String]>:
            (value as! Value<[String]>).setDefaultIfNeeded()
        case is Value<[Int]>:
            (value as! Value<[Int]>).setDefaultIfNeeded()
        case is Value<[Double]>:
            (value as! Value<[Double]>).setDefaultIfNeeded()
        case is Value<[Bool]>:
            (value as! Value<[Bool]>).setDefaultIfNeeded()
        case is Value<[String: String]>:
            (value as! Value<[String: String]>).setDefaultIfNeeded()
        default:
            throw Onyx.InternalError.wrongType
        }
    }
}
