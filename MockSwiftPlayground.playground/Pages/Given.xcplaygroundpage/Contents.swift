//: [Previous](@previous)

import Foundation
import MockSwift
import XCTest

//: Given

protocol Service {
    func myFunction(arg1: Int, arg2: String) throws -> Int
}


extension Mock: Service where WrappedType == Service {
    func myFunction(arg1: Int, arg2: String) throws -> Int {
        try mockedThrowable(arg1, arg2)
    }
}

class MyTests: XCTestCase {
    @Mock var mockedService: Service
}

extension Given where WrappedType == Service {
    func myFunction(arg1: Int, arg2: String) -> Mockable<Int> {
        mockable(arg1, arg2)
    }

    func myFunction(arg1: Predicate<Int>, arg2: Predicate<String>) -> Mockable<Int> {
        mockable(arg1, arg2)
    }
}

extension MyTests {
    func test_myFunction() {
        // with values
        given(mockedService).myFunction(arg1: 1, arg2: "hello")
            .willReturn(1)
        try? mockedService.myFunction(arg1: 1, arg2: "hello")

        // with predicates
        given(mockedService).myFunction(arg1: ==2, arg2: =="bye")
            .willReturn(2)
        try? mockedService.myFunction(arg1: 2, arg2: "bye")
    }
}

extension MyTests {
    func test_myFunction2() {
        /*given(mockedService).myFunction(arg1: 1, arg2: "hello")
            .will { arguments -> Bool in
                arguments[0]
                arguments[1]
                return true
            }

        given(mockedService).myFunction(arg1: 2, arg2: "hello")
            .willReturn(true, false, true, true)*/
let err = NSError(domain: "", code: 0)
        given(mockedService).myFunction(arg1: .any(), arg2: .any())
            .willThrow(err)

        do {
             _ = try mockedService.myFunction(arg1: 3, arg2: "bye")
        } catch {
            error
        }

    }
}

MyTests.defaultTestSuite.run()
//: [Next](@next)
