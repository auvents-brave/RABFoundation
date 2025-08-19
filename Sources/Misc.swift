import Foundation

public let isRunningTests: Bool = {
    #if os(Windows)
        return ProcessInfo.processInfo.environment["SWIFT_TEST_RUNNING"] == "1"
    #else
        return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    #endif
}()

public let isRunningInSimulator: Bool = {
    #if targetEnvironment(simulator)
        return true
    #else
        return false
    #endif
}()
