import Foundation

public let isRunningTests = ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil

public let isRunningInSimulator: Bool = {
    #if targetEnvironment(simulator)
        return true
    #else
        return false
    #endif
}()
