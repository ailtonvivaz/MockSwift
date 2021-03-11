//: [Previous](@previous)

import Foundation
import MockSwift
import XCTest

/*:
 # Getting started
 __MockSwift works only for protocol types.__
 */

/*:
 ## Create Mock
 Typically, we start with a protocol *Service* and un function *myFunction* that use *Service*.
 */
protocol Service {
    func makeInt(seed: Int) -> Int
}

func myFunction(_ service: Service) -> Int {
    service.makeInt(seed: 1)
}

/*:
 To fully test *myFunction* we need to mock *Service*.
 To be able to create a *Service* mock, you need to extend *Mock* like bellow.
 */
extension Mock: Service where WrappedType == Service {
    func makeInt(seed: Int) -> Int {
        mocked(seed)
    }
}
//: This extension allows you to use the propertyWrapper *@Mock* on a property of type *Service*.

class MyTests: XCTestCase {
    @Mock var mockedService: Service
}

//: Finally, you can test *myFunction* with a mocked *Service*
extension MyTests {
    func test_myFunction_defaultBehavior() {
        let value = myFunction(mockedService)
        XCTAssertEqual(value, 0)
    }
}
/*:
 > The returned value is *0* because *GlobalStub* value for an *Int* is *0*.
 > To go further see [Mock](@Mock)
 */

//: ## Define behaviors
//: Firstly, to be able to define behaviors dynamicly for *Service* into your test, extend *Given* like bellow.
extension Given where WrappedType == Service {
    func makeInt(seed: Predicate<Int>) -> Mockable<Int> {
        mockable(seed)
    }
}

extension MyTests {
    func test_myFunction_givenBehavior() {
        given(mockedService).makeInt(seed: >0).willReturn(1)
        let value = myFunction(mockedService)
        XCTAssertEqual(value, 1)
    }
}
/*:
 > To read more details about how to use *Given* see [Given](@given)
 */

//: ## Verify calls
//: Firstly, to be able to verify calls on *Service* into your test, extend *Then* like bellow.
extension Then where WrappedType == Service {
    func makeInt(seed: Predicate<Int>) -> Verifiable<Int> {
        verifiable(seed)
    }
}

extension MyTests {
    func test_myFunction_verifyCall() {
        _ = myFunction(mockedService)
        then(mockedService).makeInt(seed: ==1).calledOnce()
    }
}
/*:
 > To read more details about how to use *Then* see [Then](@then)
 */

/*:
 ## Code Generation
 Writing extensions can be painfull. To make it easier *MockSwift* has a *Sourcery* template to automaticaly generate extensions for you.
 See [Sourcery](@Sourcery)
 */

MyTests.defaultTestSuite.run()
//: [Next](@next)
