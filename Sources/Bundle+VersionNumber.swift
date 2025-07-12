//
//  Bundle+VersionNumber
//  RABFoundation
//
//  Created by Stéphane on 12/07/2025.
//

import Foundation

/// Example usage:
/// ```swift
/// let v = Bundle.main.releaseVersionNumber! + " (" + Bundle.main.buildVersionNumber! + ")"
/// ```
extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }

    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
