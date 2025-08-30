import Foundation
import Logging

extension Date {
    enum DisplayAs {
        case asUniversalTime
        case asLocalTime
    }

    init(fromISO: String) {
        self.init()

        // Default ISO8601DateFormatter does not support fractional seconds
        // .withFractionalSeconds expects fractional seconds onbly and will fail if not
        // Given 45.321 seconds, the nano component for the returned Date will be 320999145, not 321
        // → May it be usefull to round it?
        let date: Date?
        if fromISO.contains(".") {
            let fractional = ISO8601DateFormatter()
            fractional.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            date = fractional.date(from: fromISO)
        } else {
            date = ISO8601DateFormatter().date(from: fromISO)
        }

        guard let ret = date else {
            Logger(label: "").error("Something went wrong", metadata: ["fromISO": "\(fromISO)"])
            return
        }
        self = ret
    }

    func Display(display: DisplayAs, formatter: DateFormatter) -> String {
        formatter.timeZone = if display == .asUniversalTime {
            TimeZone(abbreviation: "UTC")
        } else {
            TimeZone.current
        }
        return formatter.string(from: self)
    }

    func Display(display: DisplayAs) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return Display(display: display, formatter: formatter)
    }
}
