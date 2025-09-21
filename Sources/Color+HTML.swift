#if canImport(SwiftUI)
    import SwiftUI
    #if canImport(UIKit)
        import UIKit
    #endif
    #if canImport(AppKit)
        import AppKit
    #endif

    extension Color {
        /// Initializes a Color from an HTML hex string, strictly parsing #RGB, #RRGGBB, or with no hash.
        ///
        /// This initializer only accepts valid 3 or 6 digit hex strings (with or without a leading `#`).
        /// It expands shorthand (3-digit) notation to full 6-digit hex.
        /// Color is created using the sRGB color space with full opacity.
        /// Returns `nil` if input is invalid.
        public init?(htmlHex: String) {
            var hex = htmlHex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
            if hex.hasPrefix("#") { hex.removeFirst() }
            let validHexSet = CharacterSet(charactersIn: "0123456789ABCDEF")
            guard hex.count == 3 || hex.count == 6, hex.rangeOfCharacter(from: validHexSet.inverted) == nil else { return nil }
            if hex.count == 3 {
                hex = String(hex.map { "\($0)\($0)" }.joined())
            }
            guard let value = Int(hex, radix: 16) else { return nil }
            let r = Double((value >> 16) & 0xFF) / 255.0
            let g = Double((value >> 8) & 0xFF) / 255.0
            let b = Double(value & 0xFF) / 255.0
            self.init(.sRGB, red: r, green: g, blue: b, opacity: 1.0)
        }

        /// Converts the Color to an HTML hex string (always #RRGGBB, using sRGB color space strictly).
        ///
        /// Extracts the sRGB components of the color and returns a hex string.
        /// The `includeHash` parameter controls whether the returned string includes a leading `#`.
        /// Returns `nil` if components cannot be extracted.
        public func toHTMLHex(includeHash: Bool = true) -> String? {
            #if canImport(UIKit)
                // UIKit: Use sRGB color space
                let uiColor = UIColor(self)
                var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
                guard uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else { return nil }
            #elseif canImport(AppKit)
                let nsColor = NSColor(self).usingColorSpace(.sRGB) ?? NSColor(self)
                guard let color = nsColor.usingColorSpace(.sRGB) else { return nil }
                let red = color.redComponent, green = color.greenComponent, blue = color.blueComponent
            #else
                return nil
            #endif
            #if canImport(UIKit)
                let r = Int(round(red * 255)), g = Int(round(green * 255)), b = Int(round(blue * 255))
            #elseif canImport(AppKit)
                let r = Int(round(red * 255)), g = Int(round(green * 255)), b = Int(round(blue * 255))
            #endif
            return String(format: "%@%02X%02X%02X", includeHash ? "#" : "", r, g, b)
        }
    }

    #if canImport(UIKit)
        /// Extensions to `UIColor` for convenient bridging to and from HTML hex strings.
        extension UIColor {
            /// Initializes a `UIColor` from an HTML hex string.
            ///
            /// Returns `nil` if the string is not a valid hex color.
            public convenience init?(htmlHex: String) {
                guard let color = Color(htmlHex: htmlHex) else { return nil }
                self.init(color)
            }

            /// Converts the `UIColor` to an HTML hex string representation.
            ///
            /// - Parameter includeHash: A Boolean indicating whether the returned string should include a leading `#`. Default is `true`.
            ///
            /// - Returns: A string in the format "#RRGGBB" or "RRGGBB". Returns `nil` if the color components cannot be extracted.
            public func toHTMLHex(includeHash: Bool = true) -> String? {
                var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
                guard getRed(&red, green: &green, blue: &blue, alpha: &alpha) else { return nil }
                let r = Int(round(red * 255)), g = Int(round(green * 255)), b = Int(round(blue * 255))
                return String(format: "%@%02X%02X%02X", includeHash ? "#" : "", r, g, b)
            }
        }
    #endif

    #if canImport(AppKit)
        /// Extensions to `NSColor` for convenient bridging to and from HTML hex strings.
        extension NSColor {
            /// Initializes an `NSColor` from an HTML hex string.
            ///
            /// Returns `nil` if the string is not a valid hex color.
            public convenience init?(htmlHex: String) {
                guard let color = Color(htmlHex: htmlHex) else { return nil }
                self.init(color)
            }

            /// Converts the `NSColor` to an HTML hex string representation.
            ///
            /// - Parameter includeHash: A Boolean indicating whether the returned string should include a leading `#`. Default is `true`.
            ///
            /// - Returns: A string in the format "#RRGGBB" or "RRGGBB". Returns `nil` if the color components cannot be extracted.
            public func toHTMLHex(includeHash: Bool = true) -> String? {
                guard let cgColor = cgColor.copy(alpha: 1.0), let components = cgColor.components, components.count >= 3 else { return nil }
                let r = Int(round(components[0] * 255)), g = Int(round(components[1] * 255)), b = Int(round(components[2] * 255))
                return String(format: "%@%02X%02X%02X", includeHash ? "#" : "", r, g, b)
            }
        }
    #endif
#endif
