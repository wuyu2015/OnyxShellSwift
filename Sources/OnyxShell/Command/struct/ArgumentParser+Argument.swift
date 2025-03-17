extension Onyx.ArgumentParser {
    
    func setDefaultIfNeeded(argument: Any) throws {
        switch argument.self {
        case is Argument<String>:
            let arg = argument as! Argument<String>
            if let v = arg.setDefaultIfNeeded(), let ref = arg.ref {
                (values[ref]! as! Value<String>).setValueIfNeeded(v)
            }
            guard arg.wrappedValue != nil else {
                throw Onyx.InternalError.invalidArgumentDefaultValue
            }
        case is Argument<Int>:
            let arg = argument as! Argument<Int>
            if let v = arg.setDefaultIfNeeded(), let ref = arg.ref {
                (values[ref]! as! Value<Int>).setValueIfNeeded(v)
            }
            guard arg.wrappedValue != nil else {
                throw Onyx.InternalError.invalidArgumentDefaultValue
            }
        case is Argument<Double>:
            let arg = argument as! Argument<Double>
            if let v = arg.setDefaultIfNeeded(), let ref = arg.ref {
                (values[ref]! as! Value<Double>).setValueIfNeeded(v)
            }
            guard arg.wrappedValue != nil else {
                throw Onyx.InternalError.invalidArgumentDefaultValue
            }
        case is Argument<Bool>:
            let arg = argument as! Argument<Bool>
            if let v = arg.setDefaultIfNeeded(), let ref = arg.ref {
                (values[ref]! as! Value<Bool>).setValueIfNeeded(v)
            }
            guard arg.wrappedValue != nil else {
                throw Onyx.InternalError.invalidArgumentDefaultValue
            }
        case is Argument<[String]>:
            let arg = argument as! Argument<[String]>
            if let v = arg.setDefaultIfNeeded(), let ref = arg.ref {
                (values[ref]! as! Value<[String]>).setValueIfNeeded(v)
            }
            guard arg.wrappedValue != nil else {
                throw Onyx.InternalError.invalidArgumentDefaultValue
            }
        case is Argument<[Int]>:
            let arg = argument as! Argument<[Int]>
            if let v = arg.setDefaultIfNeeded(), let ref = arg.ref {
                (values[ref]! as! Value<[Int]>).setValueIfNeeded(v)
            }
            guard arg.wrappedValue != nil else {
                throw Onyx.InternalError.invalidArgumentDefaultValue
            }
        case is Argument<[Double]>:
            let arg = argument as! Argument<[Double]>
            if let v = arg.setDefaultIfNeeded(), let ref = arg.ref {
                (values[ref]! as! Value<[Double]>).setValueIfNeeded(v)
            }
            guard arg.wrappedValue != nil else {
                throw Onyx.InternalError.invalidArgumentDefaultValue
            }
        case is Argument<[Bool]>:
            let arg = argument as! Argument<[Bool]>
            if let v = arg.setDefaultIfNeeded(), let ref = arg.ref {
                (values[ref]! as! Value<[Bool]>).setValueIfNeeded(v)
            }
            guard arg.wrappedValue != nil else {
                throw Onyx.InternalError.invalidArgumentDefaultValue
            }
        case is Argument<[String: String]>:
            let arg = argument as! Argument<[String: String]>
            if let v = arg.setDefaultIfNeeded(), let ref = arg.ref {
                (values[ref]! as! Value<[String: String]>).setValueIfNeeded(v)
            }
            guard arg.wrappedValue != nil else {
                throw Onyx.InternalError.invalidArgumentDefaultValue
            }
        default:
            throw Onyx.InternalError.wrongType
        }
    }
    
    func setValue(argument: Any, from rawValue: String) throws {
        switch argument.self {
        case is Argument<String>:
            let arg = argument as! Argument<String>
            if let v = try arg.setValue(from: rawValue), let ref = arg.ref {
                try (values[ref]! as! Value<String>).setValue(v)
            }
        case is Argument<Int>:
            let arg = argument as! Argument<Int>
            if let v = try arg.setValue(from: rawValue), let ref = arg.ref {
                try (values[ref]! as! Value<Int>).setValue(v)
            }
        case is Argument<Double>:
            let arg = argument as! Argument<Double>
            if let v = try arg.setValue(from: rawValue), let ref = arg.ref {
                try (values[ref]! as! Value<Double>).setValue(v)
            }
        case is Argument<Bool>:
            let arg = argument as! Argument<Bool>
            if let v = try arg.setValue(from: rawValue), let ref = arg.ref {
                try (values[ref]! as! Value<Bool>).setValue(v)
            }
        case is Argument<[String]>:
            let arg = argument as! Argument<[String]>
            if let v = try arg.setValue(from: rawValue), let ref = arg.ref {
                try (values[ref]! as! Value<[String]>).setValue(v)
            }
        case is Argument<[Int]>:
            let arg = argument as! Argument<[Int]>
            if let v = try arg.setValue(from: rawValue), let ref = arg.ref {
                try (values[ref]! as! Value<[Int]>).setValue(v)
            }
        case is Argument<[Double]>:
            let arg = argument as! Argument<[Double]>
            if let v = try arg.setValue(from: rawValue), let ref = arg.ref {
                try (values[ref]! as! Value<[Double]>).setValue(v)
            }
        case is Argument<[Bool]>:
            let arg = argument as! Argument<[Bool]>
            if let v = try arg.setValue(from: rawValue), let ref = arg.ref {
                try (values[ref]! as! Value<[Bool]>).setValue(v)
            }
        case is Argument<[String: String]>:
            let arg = argument as! Argument<[String: String]>
            if let v = try arg.setValue(from: rawValue), let ref = arg.ref {
                try (values[ref]! as! Value<[String: String]>).setValue(v)
            }
        default:
            throw Onyx.InternalError.wrongType
        }
    }
    
    func isCollection(argument: Any) -> Bool {
        switch argument.self {
        case is Argument<String>:
            return (argument as! Argument<String>).$wrappedValue.isCollection
        case is Argument<Int>:
            return (argument as! Argument<Int>).$wrappedValue.isCollection
        case is Argument<Double>:
            return (argument as! Argument<Double>).$wrappedValue.isCollection
        case is Argument<Bool>:
            return (argument as! Argument<Bool>).$wrappedValue.isCollection
        case is Argument<[String]>:
            return (argument as! Argument<[String]>).$wrappedValue.isCollection
        case is Argument<[Int]>:
            return (argument as! Argument<[Int]>).$wrappedValue.isCollection
        case is Argument<[Double]>:
            return (argument as! Argument<[Double]>).$wrappedValue.isCollection
        case is Argument<[Bool]>:
            return (argument as! Argument<[Bool]>).$wrappedValue.isCollection
        case is Argument<[String: String]>:
            return (argument as! Argument<[String: String]>).$wrappedValue.isCollection
        default:
            fatalError("Unsupported argument data type: \(type(of: argument))")
        }
    }
}
