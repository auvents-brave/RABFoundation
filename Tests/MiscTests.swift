@testable import RabFoundation
import Testing

@Suite
struct MiscTests {
    @Test func IsRunningTest() async throws {
        #expect(isRunningTests)
    }

    @Test func IsRunningInSimulator() async throws {
        #expect(!isRunningInSimulator)
    }
}
