extension Onyx.ArgumentParser {
    
    func setValue(option: Any, value rawValue: String) throws {
        switch option.self {
        case is Option<String>:
            let op = option as! Option<String>
            if let v = try op.setValue(from: rawValue), let ref = op.ref {
                try (values[ref]! as! Value<String>).setValue(v)
            }
        case is Option<Int>:
            let op = option as! Option<Int>
            if let v = try op.setValue(from: rawValue), let ref = op.ref {
                try (values[ref]! as! Value<Int>).setValue(v)
            }
        case is Option<Double>:
            let op = option as! Option<Double>
            if let v = try op.setValue(from: rawValue), let ref = op.ref {
                try (values[ref]! as! Value<Double>).setValue(v)
            }
        case is Option<Bool>:
            let op = option as! Option<Bool>
            if let v = try op.setValue(from: rawValue), let ref = op.ref {
                try (values[ref]! as! Value<Bool>).setValue(v)
            }
        case is Option<[String]>:
            let op = option as! Option<[String]>
            if let v = try op.setValue(from: rawValue), let ref = op.ref {
                try (values[ref]! as! Value<[String]>).setValue(v)
            }
        case is Option<[Int]>:
            let op = option as! Option<[Int]>
            if let v = try op.setValue(from: rawValue), let ref = op.ref {
                try (values[ref]! as! Value<[Int]>).setValue(v)
            }
        case is Option<[Double]>:
            let op = option as! Option<[Double]>
            if let v = try op.setValue(from: rawValue), let ref = op.ref {
                try (values[ref]! as! Value<[Double]>).setValue(v)
            }
        case is Option<[Bool]>:
            let op = option as! Option<[Bool]>
            if let v = try op.setValue(from: rawValue), let ref = op.ref {
                try (values[ref]! as! Value<[Bool]>).setValue(v)
            }
        case is Option<[String: String]>:
            let op = option as! Option<[String: String]>
            if let v = try op.setValue(from: rawValue), let ref = op.ref {
                try (values[ref]! as! Value<[String: String]>).setValue(v)
            }
        default:
            throw Onyx.InternalError.wrongType
        }
    }
    
    func setDefaultValue(option: Any) throws {
        switch option.self {
        case is Option<String>:
            let op = option as! Option<String>
            guard op.$wrappedValue.defaultValue != nil else {
                throw Onyx.InternalError.invalidOptionDefaultValue
            }
            if let v = op.setDefaultIfNeeded() {
                op.$wrappedValue.setValueIfNeeded(v)
            }
        case is Option<Int>:
            let op = option as! Option<Int>
            guard op.$wrappedValue.defaultValue != nil else {
                throw Onyx.InternalError.invalidOptionDefaultValue
            }
            if let v = op.setDefaultIfNeeded() {
                op.$wrappedValue.setValueIfNeeded(v)
            }
        case is Option<Double>:
            let op = option as! Option<Double>
            guard op.$wrappedValue.defaultValue != nil else {
                throw Onyx.InternalError.invalidOptionDefaultValue
            }
            if let v = op.setDefaultIfNeeded() {
                op.$wrappedValue.setValueIfNeeded(v)
            }
        case is Option<Bool>:
            let op = option as! Option<Bool>
            guard op.$wrappedValue.defaultValue != nil else {
                throw Onyx.InternalError.invalidOptionDefaultValue
            }
            if let v = op.setDefaultIfNeeded() {
                op.$wrappedValue.setValueIfNeeded(v)
            }
        case is Option<[String]>:
            let op = option as! Option<[String]>
            guard op.$wrappedValue.defaultValue != nil else {
                throw Onyx.InternalError.invalidOptionDefaultValue
            }
            if let v = op.setDefaultIfNeeded() {
                op.$wrappedValue.setValueIfNeeded(v)
            }
        case is Option<[Int]>:
            let op = option as! Option<[Int]>
            guard op.$wrappedValue.defaultValue != nil else {
                throw Onyx.InternalError.invalidOptionDefaultValue
            }
            if let v = op.setDefaultIfNeeded() {
                op.$wrappedValue.setValueIfNeeded(v)
            }
        case is Option<[Double]>:
            let op = option as! Option<[Double]>
            guard op.$wrappedValue.defaultValue != nil else {
                throw Onyx.InternalError.invalidOptionDefaultValue
            }
            if let v = op.setDefaultIfNeeded() {
                op.$wrappedValue.setValueIfNeeded(v)
            }
        case is Option<[Bool]>:
            let op = option as! Option<[Bool]>
            guard op.$wrappedValue.defaultValue != nil else {
                throw Onyx.InternalError.invalidOptionDefaultValue
            }
            if let v = op.setDefaultIfNeeded() {
                op.$wrappedValue.setValueIfNeeded(v)
            }
        case is Option<[String: String]>:
            let op = option as! Option<[String: String]>
            guard op.$wrappedValue.defaultValue != nil else {
                throw Onyx.InternalError.invalidOptionDefaultValue
            }
            if let v = op.setDefaultIfNeeded() {
                op.$wrappedValue.setValueIfNeeded(v)
            }
        default:
            throw Onyx.InternalError.wrongType
        }
    }
}
