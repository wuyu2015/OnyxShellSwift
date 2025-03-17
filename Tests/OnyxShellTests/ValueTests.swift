import XCTest
import XCTestDelayPrinter
@testable import OnyxShell

final class ValueTests: XCTestCase {
    
    func testExclusive() {
        struct People {
            @Value
            var name: String?
            
            @Value
            var age: Int?
            
            @Value
            var pets: [String]?
        }
        
        let people = People()
        
        XCTAssertEqual(people.$name.exclusivity, .exclusive)
        XCTAssertEqual(people.$age.exclusivity, .exclusive)
        XCTAssertEqual(people.$pets.exclusivity, .chooseLast)
        
        XCTAssertEqual(people.name, nil)
        XCTAssertEqual(people.age, nil)
        XCTAssertEqual(people.pets, nil)
        
        people.name = nil
        people.age = nil
        people.pets = nil
        XCTAssertEqual(people.name, nil)
        XCTAssertEqual(people.age, nil)
        XCTAssertEqual(people.pets, nil)
        
        people.name = "Alice"
        people.age = 30
        people.pets = ["cat"]
        XCTAssertEqual(people.name, "Alice")
        XCTAssertEqual(people.age, 30)
        XCTAssertEqual(people.pets, ["cat"])
    }
    
    func testChooseLast() {
        struct People {
            @Value(exclusivity: .chooseLast)
            var name: String?
            
            @Value(exclusivity: .chooseLast)
            var age: Int?
            
            @Value(exclusivity: .chooseLast)
            var pets: [String]?
        }
        
        let people = People()
        
        XCTAssertEqual(people.$name.exclusivity, .chooseLast)
        XCTAssertEqual(people.$age.exclusivity, .chooseLast)
        XCTAssertEqual(people.$pets.exclusivity, .chooseLast)
        
        people.name = "Alice"
        people.age = 30
        people.pets = ["cat"]
        XCTAssertEqual(people.name, "Alice")
        XCTAssertEqual(people.age, 30)
        XCTAssertEqual(people.pets, ["cat"])
        
        people.name = "Bob"
        people.age = 20
        people.pets = ["dog"]
        XCTAssertEqual(people.name, "Bob")
        XCTAssertEqual(people.age, 20)
        XCTAssertEqual(people.pets, ["dog"])
        
        let people2 = people
        people2.name = "Charlie"
        people2.age = 40
        people2.pets = ["hamster"]
        
        XCTAssertEqual(people2.name, "Charlie")
        XCTAssertEqual(people2.age, 40)
        XCTAssertEqual(people2.pets, ["hamster"])
        XCTAssertEqual(people.name, "Charlie")
        XCTAssertEqual(people.age, 40)
        XCTAssertEqual(people.pets, ["hamster"])
    }
    
    func testInitChooseFirst() {
        struct People {
            @Value(exclusivity: .chooseFirst)
            var name: String?
            
            @Value(exclusivity: .chooseFirst)
            var age: Int?
            
            @Value(exclusivity: .chooseFirst)
            var pets: [String]?
        }
        
        let people = People()
        
        XCTAssertEqual(people.$name.exclusivity, .chooseFirst)
        XCTAssertEqual(people.$age.exclusivity, .chooseFirst)
        XCTAssertEqual(people.$pets.exclusivity, .chooseLast)
        
        people.name = "Alice"
        people.age = 30
        people.pets = ["cat"]
        XCTAssertEqual(people.name, "Alice")
        XCTAssertEqual(people.age, 30)
        XCTAssertEqual(people.pets, ["cat"])
        
        people.name = "Bob"
        people.age = 20
        people.pets = ["dog"]
        XCTAssertEqual(people.name, "Alice")
        XCTAssertEqual(people.age, 30)
        XCTAssertEqual(people.pets, ["dog"])
    }
    
    func testInitWithValue() {
        struct People {
            @Value
            var name: String? = "Alice"
            
            @Value
            var age: Int? = 30
        }
        
        let people = People()
        XCTAssertEqual(people.name, "Alice")
        XCTAssertEqual(people.age, 30)
    }
    
    func testParseValueExclusive() {
        struct Demo {
            @Value
            var s: String?
            
            @Value
            var i: Int?
            
            @Value
            var d: Double?
            
            @Value
            var b: Bool?
            
            @Value
            var sArr: [String]?
            
            @Value
            var iArr: [Int]?
            
            @Value
            var dArr: [Double]?
            
            @Value
            var bArr: [Bool]?
        }
        
        let demo = Demo()
        XCTAssertEqual(try demo.$s.parseValue(from: "string"), "string")
        demo.s = "s"
        XCTAssertThrowsError(try demo.$s.parseValue(from: "string"))
        
        XCTAssertEqual(try demo.$i.parseValue(from: "1"), 1)
        XCTAssertEqual(try demo.$i.parseValue(from: "-1"), -1)
        XCTAssertThrowsError(try demo.$i.parseValue(from: "1.0"))
        XCTAssertThrowsError(try demo.$i.parseValue(from: "string"))
        demo.i = 1
        XCTAssertThrowsError(try demo.$i.parseValue(from: "1"))
        
        XCTAssertEqual(try demo.$d.parseValue(from: "1"), 1.0)
        XCTAssertEqual(try demo.$d.parseValue(from: "-1"), -1.0)
        XCTAssertThrowsError(try demo.$d.parseValue(from: "string"))
        demo.d = 1.0
        XCTAssertThrowsError(try demo.$d.parseValue(from: "1.0"))
        
        XCTAssertEqual(try demo.$b.parseValue(from: "true"), true)
        XCTAssertEqual(try demo.$b.parseValue(from: "false"), false)
        XCTAssertEqual(try demo.$b.parseValue(from: "yes"), true)
        XCTAssertEqual(try demo.$b.parseValue(from: "no"), false)
        XCTAssertEqual(try demo.$b.parseValue(from: "y"), true)
        XCTAssertEqual(try demo.$b.parseValue(from: "n"), false)
        XCTAssertEqual(try demo.$b.parseValue(from: "True"), true)
        XCTAssertEqual(try demo.$b.parseValue(from: "False"), false)
        XCTAssertEqual(try demo.$b.parseValue(from: "Yes"), true)
        XCTAssertEqual(try demo.$b.parseValue(from: "No"), false)
        XCTAssertEqual(try demo.$b.parseValue(from: "Y"), true)
        XCTAssertEqual(try demo.$b.parseValue(from: "N"), false)
        XCTAssertThrowsError(try demo.$b.parseValue(from: "string"))
        demo.b = true
        XCTAssertThrowsError(try demo.$d.parseValue(from: "true"))
        
        XCTAssertEqual(try demo.$sArr.parseValue(from: "string"), ["string"])
        demo.sArr = ["string1"]
        XCTAssertEqual(try demo.$sArr.parseValue(from: "string2"), ["string1", "string2"])
        demo.sArr?.append("string2")
        XCTAssertEqual(try demo.$sArr.parseValue(from: "string3"), ["string1", "string2", "string3"])
        
        XCTAssertEqual(try demo.$iArr.parseValue(from: "1"), [1])
        demo.iArr = [1]
        XCTAssertEqual(try demo.$iArr.parseValue(from: "2"), [1, 2])
        demo.iArr?.append(2)
        
        XCTAssertEqual(try demo.$dArr.parseValue(from: "1"), [1.0])
        demo.dArr = [1.0]
        XCTAssertEqual(try demo.$dArr.parseValue(from: "2"), [1.0, 2.0])
        
        XCTAssertEqual(try demo.$bArr.parseValue(from: "true"), [true])
        demo.bArr = [true]
        XCTAssertEqual(try demo.$bArr.parseValue(from: "false"), [true, false])
    }
    
    func testSetValue() {
        struct Demo {
            @Value(exclusivity: .chooseFirst)
            var i1: Int? = 1
            
            @Value(exclusivity: .chooseLast)
            var i2: Int? = 1

            @Value(exclusivity: .exclusive)
            var i3: Int? = 1

            @Value(exclusivity: .chooseFirst)
            var iArr1: [Int]? = [1]

            @Value(exclusivity: .chooseLast)
            var iArr2: [Int]? = [1]

            @Value(exclusivity: .exclusive)
            var iArr3: [Int]? = [1]
        }
        
        let demo = Demo()

        XCTAssertFalse(try demo.$i1.setValue(2))
        XCTAssertEqual(demo.i1, 1)
        
        XCTAssertTrue(try demo.$i2.setValue(2))
        XCTAssertEqual(demo.i2, 2)
        
        XCTAssertThrowsError(try demo.$i3.setValue(2))
        XCTAssertEqual(demo.i3, 1)
        
        XCTAssertTrue(try demo.$iArr1.setValue([2]))
        XCTAssertEqual(demo.iArr1, [2])
        
        XCTAssertTrue(try demo.$iArr2.setValue([2]))
        XCTAssertEqual(demo.iArr2, [2])
        
        XCTAssertTrue(try demo.$iArr3.setValue([2]))
        XCTAssertEqual(demo.iArr3, [2])
    }
    
    func testSetDefaultIfNeeded1() {
        struct People {
            @Value(default: "Alice")
            var name: String?
            
            @Value(default: 30)
            var age: Int?
        }
        
        let people = People()
        XCTAssertEqual(people.name, nil)
        XCTAssertEqual(people.age, nil)
        
        XCTAssertEqual(people.$name.setDefaultIfNeeded(), "Alice")
        XCTAssertEqual(people.$age.setDefaultIfNeeded(), 30)
        XCTAssertEqual(people.name, "Alice")
        XCTAssertEqual(people.age, 30)
    }
    
    func testSetDefaultIfNeeded2() {
        struct People {
            @Value(default: "Alice")
            var name: String? = "Bob"
            
            @Value(default: 30)
            var age: Int? = 20
        }
        
        let people = People()
        XCTAssertEqual(people.name, "Bob")
        XCTAssertEqual(people.age, 20)
        
        XCTAssertNil(people.$name.setDefaultIfNeeded())
        XCTAssertNil(people.$age.setDefaultIfNeeded())
        XCTAssertEqual(people.name, "Bob")
        XCTAssertEqual(people.age, 20)
    }
    
    func testSetValueFromRawValue1() {
        struct People {
            @Value
            var name: String?
            
            @Value
            var age: Int?
            
            @Value
            var pets: [String]?
        }
        
        let people = People()
        XCTAssertEqual(people.name, nil)
        XCTAssertEqual(people.age, nil)
        XCTAssertEqual(people.pets, nil)
        
        XCTAssertEqual(try people.$name.setValue(from: "Alice"), "Alice")
        XCTAssertEqual(try people.$age.setValue(from: "30"), 30)
        XCTAssertEqual(try people.$pets.setValue(from: "cat"), ["cat"])
        XCTAssertEqual(people.name, "Alice")
        XCTAssertEqual(people.age, 30)
        XCTAssertEqual(people.pets, ["cat"])
        
        XCTAssertThrowsError(try people.$name.setValue(from: "Bob"))
        XCTAssertThrowsError(try people.$age.setValue(from: "20"))
        XCTAssertEqual(try people.$pets.setValue(from: "dog"), ["cat", "dog"])
        XCTAssertEqual(people.name, "Alice")
        XCTAssertEqual(people.age, 30)
        XCTAssertEqual(people.pets, ["cat", "dog"])
    }
    
    func testSetValueFromRawValue2() {
        struct People {
            @Value(exclusivity: .chooseFirst)
            var name: String?
            
            @Value(exclusivity: .chooseFirst)
            var age: Int?
            
            @Value(exclusivity: .chooseFirst)
            var pets: [String]?
        }
        
        let people = People()
        XCTAssertEqual(people.name, nil)
        XCTAssertEqual(people.age, nil)
        XCTAssertEqual(people.pets, nil)
        
        XCTAssertEqual(try people.$name.setValue(from: "Alice"), "Alice")
        XCTAssertEqual(try people.$age.setValue(from: "30"), 30)
        XCTAssertEqual(try people.$pets.setValue(from: "cat"), ["cat"])
        XCTAssertEqual(people.name, "Alice")
        XCTAssertEqual(people.age, 30)
        XCTAssertEqual(people.pets, ["cat"])
        
        XCTAssertEqual(try people.$name.setValue(from: "Bob"), nil)
        XCTAssertEqual(try people.$age.setValue(from: "20"), nil)
        XCTAssertEqual(try people.$pets.setValue(from: "dog"), ["cat", "dog"])
        XCTAssertEqual(people.name, "Alice")
        XCTAssertEqual(people.age, 30)
        
        people.name = "Bob"
        people.age = 20
        XCTAssertEqual(people.name, "Alice")
        XCTAssertEqual(people.age, 30)
    }
}
