import Foundation
@testable import RabFoundation
import Testing

@Suite
struct MiscTests {
    @Test func IsRunningTest() async throws {
    #if os(Windows) || os(Linux) || os(Android)
            for (key, value) in ProcessInfo.processInfo.environment {
                print("\(key): \(value)")
            }
#endif
        #expect(isRunningTests)
    }
}
