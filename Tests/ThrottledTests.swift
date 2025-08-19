@testable import RabFoundation
import Testing

@Suite
struct ThrottledTests {
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
