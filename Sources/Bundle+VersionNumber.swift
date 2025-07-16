/// Bundle+VersionNumber.swift
///
/// Provides convenient accessors for version numbers in an application's Info.plist via Bundle extensions.
///
/// This extension adds computed properties to retrieve the app's release and build version numbers.
///
/// Example usage:
/// ```swift
/// let v = Bundle.main.releaseVersionNumber! + " (" + Bundle.main.buildVersionNumber! + ")"
/// ```

import Foundation

/// Extension to Bundle to access versioning information from the app's Info.plist.
extension Bundle {
    /// The release version number of the app (from CFBundleShortVersionString in Info.plist).
    /// Returns nil if the value is not present.
    public var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }

    /// The build version number of the app (from CFBundleVersion in Info.plist).
    /// Returns nil if the value is not present.
    public var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
