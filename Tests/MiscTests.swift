@testable import RabFoundation
import Testing

@Suite
struct MiscTests {
    #if !os(Windows)
        @Test func IsRunningTest() async throws {
            #expect(isRunningTests)
        }
    #endif

    @Test func IsRunningInSimulator() async throws {
        #expect(!isRunningInSimulator)
    }
}
