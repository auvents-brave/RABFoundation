@testable import RabFoundation
import Testing

@Suite struct ThrottledTests {
    // Note: Structs do not support deinit in Swift. Only classes do.
    init() {}

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
}

