import Foundation

/**
 Indicates whether the current process is running under a unit test environment.

 Useful for conditional code paths that should only execute during automated testing.
 - attention: Does not work as expected on Windows.
 */
public let isRunningTests: Bool = {
    #if os(Windows) || os(Linux) || os(Android)
        // return ProcessInfo.processInfo.environment["SWIFT_TEST_RUNNING"] == "1"

        for (key, value) in ProcessInfo.processInfo.environment {
            print("\(key): \(value)")
        }

        return false
    #else
        return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    #endif
}()
