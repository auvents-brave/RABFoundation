import Foundation
@testable import RabFoundation
import Testing

@Test func BundleVersionTest() async throws {
    let bundle = Bundle.module
    guard let url = bundle.url(forResource: "TestInfo", withExtension: "plist"),
          let data = try? Data(contentsOf: url),
          let plist = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any] else {
        Issue.record("Could not load TestInfo.plist")
        return
    }
    #expect(plist.description == "[\"CFBundleShortVersionString\": 1.0, \"CFBundleVersion\": 99]" || plist.description == "[\"CFBundleVersion\": 99, \"CFBundleShortVersionString\": 1.0]")

    #expect(Versioning.GetDisplayedVersion(plist) == "1.0 (99)")
}
