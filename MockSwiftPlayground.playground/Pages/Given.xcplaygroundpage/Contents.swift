//: [Previous](@previous)

import Foundation
import MockSwift
import XCTest

//: # Given
/*:
 **MockSwift** allow you to inject behaviours to your protocol type. \
 To be able to do that, you have to extend **Given**.
 They are 3 kinds of behaviours you are susceptible to inject: functions, properties and subscripts.
 */

//: ## Methods
protocol ServiceMethods {
    func nothing()
    func function(arg: Int, arg2: Bool, _ completion: @escaping (String) -> Void) -> String
    func throwing(value: Int) throws
}

extension Given where WrappedType == ServiceMethods {

    func nothing() -> Mockable<Void> {
        mockable()
    }

    func function(arg: Int, arg2: Bool, _ completion: @escaping (String) -> Void) -> Mockable<String> {
        mockable(arg, arg2, completion)
    }

    func throwing(value: Int) -> Mockable<Void> {
        mockable(value)
    }

    // Use Predicate to define complexe triggers. To go further see [Predicate](@Predicate)
    func throwing(value: Predicate<Int>) -> Mockable<Void> {
        mockable(value)
    }
}
/*:
 >Parameters **@nonescaping** are not supported.  \
 The function where you call `mockable()` must respect the following rules:  \
    - The name must match the function from the `WrappedType`. Example: **function(arg:arg2:)**  \
    - The return type must be a `Mockable` with, as generic type, the same type  \
    as the return type of the method in the `WrappedType`. Example: `String` became `Mockable<String>`.  \
    - Call `mockable()` with all parameters in the same order.
 */

//: To see how to create mocks go to [Mock](@Mock)
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

class MyTests: XCTestCase {
    @Mock var mockedService: ServiceMethods

    func test_myFunction() {
        given(mockedService).throwing(
    }
}


MyTests.defaultTestSuite.run()
//: [Next](@next)
