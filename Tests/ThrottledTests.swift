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

let label = "tst"
let logger = Logger(label: label)

@Test func TestingLogger() async throws {
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

@Test func SimmpleLogger() async throws {
    logger.info("info")
    logger.critical("critical")
    logger.debug("debug")
    logger.warning("warning")
    logger.error("error")
    logger.notice("notice")
    logger.trace("trace")

    logger.log(level: .warning, "warning")
}
