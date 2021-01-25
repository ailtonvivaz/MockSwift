//: [Previous](@previous)

import Foundation
import MockSwift
import XCTest

//: # Mock

/*:
 To use the power of **MockSwift**, you have to extend **Mock** with your protocol type.
 After that you will be able to use the property wrapper **@Mock** on this type and change its behaviour for your tests.
 They are 3 kinds of behaviours you are susceptible to interact with: functions, properties and subscripts.
 */

//: ## Methods
protocol ServiceMethods {
    func nothing()
    func function(arg: Int, arg2: Bool, _ completion: @escaping (String) -> Void) -> String
    func throwing(value: Int) throws
}

extension Mock: ServiceMethods where WrappedType == ServiceMethods {

    func nothing() {
        mocked()
    }

    func function(arg: Int, arg2: Bool, _ completion: @escaping (String) -> Void) -> String {
        mocked(arg, arg2, completion)
    }

    func throwing(value: Int) throws {
        try mockedThrowable(value)
    }

}
/*:
 >Parameters **@nonescaping** are not supported.  \
It's important to keep the same order for parameters when you call call **mocked()**.  \
Use **mockedThrowable** instead of **mocked** for a methods that can throw.
 */

//: ## Properties
protocol ServiceProperties {
    var constant: Int { get }
    var variable: String { get set }
}

extension Mock: ServiceProperties where WrappedType == ServiceProperties {
    var constant: Int {
        mocked()
    }

    var variable: String {
        get {
            mocked()
        }
        set {
            mocked(newValue)
        }
    }
}

/*:
 > For a read/write property, you have to pass the **newValue** to the **mocked** method.
 */

//: ## Subscripts
protocol ServiceSubscripts {
    subscript(value: String) -> Bool { get }
    subscript(_ value: Int) -> String { get set }
}

extension Mock: ServiceSubscripts where WrappedType == ServiceSubscripts {
    subscript(value: String) -> Bool {
        mocked(value)
    }

    subscript(value: Int) -> String {
        get {
            mocked(value)
        }
        set {
            mocked(value, newValue)
        }
    }
}
/*:
 > For a read/write subscript, you have to pass the **newValue** as the last parameter to **mocked()**.
 */

//: ## Property Wrapper
/*:
 Once Mock is extended with your protocol type, you can use the property wrapper @Mock to create a mock into your tests as follow.
 */

class MyTests: XCTestCase {
    @Mock var mockedServiceMethods: ServiceMethods
    @Mock var mockedServiceProperties: ServiceProperties
    @Mock var mockedServiceSubscripts: ServiceSubscripts
}

//: ### Stubs

//: #### Global Stubs

//: #### Local Stubs

//: ### Strategy


//: [Next](@next)
