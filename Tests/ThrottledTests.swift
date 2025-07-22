@testable import RABFoundation
import Testing

@Test func DidNotUpdated() async throws {
    @Throttled var v = "Hello"
    v = "World!"
    #expect(v == "Hello")
}

@Test func DidUpdated() async throws {
    @Throttled(timeInterval: 0) var v = "Hello"
    v = "World!"
    #expect(v == "World!")
}



import Logging
import SwiftLogTesting

let label = "com.example.YourApp"
let logger = Logger(label: label)

@Test func Logger() async throws {
    /// logger.info("message")
    ///
    ///
    ///

    TestLogMessages.bootstrap()
    let container = TestLogMessages.container(forLabel: label)
    container.reset()
    container.print()
    #expect(container.messages.isEmpty)

    logger.info("message")
    container.print()   

    #expect(container.messages.count == 1)
}