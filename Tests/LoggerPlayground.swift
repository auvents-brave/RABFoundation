import Foundation
import Logging
import SwiftLogTesting
import Testing

@Suite
struct LogTesters {
    @Test func TestingLogger() async throws {
        TestLogMessages.bootstrap()
        let container = TestLogMessages.container(forLabel: "TestingLogger")
        container.reset()
        #expect(container.messages.isEmpty)

        let logger = Logger(label: "TestingLogger")

        logger.info("message")
        #expect(container.messages.count == 1)
        #expect(container.messages[0].toString() == "info message|LogTests.swift|TestingLogger()")
    }

    @Test func SimpleLogger() async throws {
        TestLogMessages.bootstrap()
        let container = TestLogMessages.container(forLabel: "SimpleLogger")
        container.reset()
        #expect(container.messages.isEmpty)
        let logger = Logger(label: "SimpleLogger")

        // logLevel is .info by default
        logger.trace("trace")
        logger.debug("debug")
        logger.info("info")
        logger.notice("notice")
        logger.warning("warning")
        logger.error("error")
        logger.critical("critical")

        // The first two messages have been stripped.
        #expect(container.messages.count == 5)
    }

    @Test func OneMoreLogger() async throws {
        var logger = Logger(label: "OneMoreLogger")
        logger.logLevel = .trace

        logger.trace("Test started")
        logger.warning("This is a warning")
        logger.error("Something went wrong", metadata: ["error": "-99"])

        // Add metadata for context
        var requestLogger = logger
        requestLogger[metadataKey: "request-id"] = "\(UUID())"
        requestLogger.info("With default metadata")
        requestLogger.info("Overriding default metadata", metadata: ["request-id": "\(UUID())"])
        requestLogger.info("With default metadata", metadata: ["user-id": "123"])

        logger.trace("Test ended")
    }
}
