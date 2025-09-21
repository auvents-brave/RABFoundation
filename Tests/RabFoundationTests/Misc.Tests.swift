import Foundation
import Testing

@testable import RabFoundation

@Suite
struct MiscTests {
    @Test("IsRunningTests") func IsRunningTests() async throws {
        #expect(isRunningTests)
    }
}
