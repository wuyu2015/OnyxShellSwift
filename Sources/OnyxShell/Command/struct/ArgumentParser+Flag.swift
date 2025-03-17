extension Onyx.ArgumentParser {
    
    func setValue(flag: Any) throws {
        switch flag.self {
        case is Flag<String>:
            let f = flag as! Flag<String>
            if let v = f.setValue(), let ref = f.ref {
                try (values[ref]! as! Value<String>).setValue(v)
            }
        case is Flag<Int>:
            let f = flag as! Flag<Int>
            if let v = f.setValue(), let ref = f.ref {
                try (values[ref]! as! Value<Int>).setValue(v)
            }
        case is Flag<Double>:
            let f = flag as! Flag<Double>
            if let v = f.setValue(), let ref = f.ref {
                try (values[ref]! as! Value<Double>).setValue(v)
            }
        case is Flag<Bool>:
            let f = flag as! Flag<Bool>
            if let v = f.setValue(), let ref = f.ref {
                try (values[ref]! as! Value<Bool>).setValue(v)
            }
        case is Flag<[String]>:
            let f = flag as! Flag<[String]>
            if let v = f.setValue(), let ref = f.ref {
                try (values[ref]! as! Value<[String]>).setValue(v)
            }
        case is Flag<[Int]>:
            let f = flag as! Flag<[Int]>
            if let v = f.setValue(), let ref = f.ref {
                try (values[ref]! as! Value<[Int]>).setValue(v)
            }
        case is Flag<[Double]>:
            let f = flag as! Flag<[Double]>
            if let v = f.setValue(), let ref = f.ref {
                try (values[ref]! as! Value<[Double]>).setValue(v)
            }
        case is Flag<[Bool]>:
            let f = flag as! Flag<[Bool]>
            if let v = f.setValue(), let ref = f.ref {
                try (values[ref]! as! Value<[Bool]>).setValue(v)
            }
        case is Flag<[String: String]>:
            let f = flag as! Flag<[String: String]>
            if let v = f.setValue(), let ref = f.ref {
                try (values[ref]! as! Value<[String: String]>).setValue(v)
            }
        default:
            throw Onyx.InternalError.wrongType
        }
    }
}
