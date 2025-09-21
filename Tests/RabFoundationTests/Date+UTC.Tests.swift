import Foundation
import Testing

@testable import RabFoundation

private func stripTrailingAM(_ s: String) -> String {
    s.hasSuffix(" AM") ? String(s.dropLast(3)) : s
}

@Test("Create Date from ISO string") func BuildDate() async throws {
    #expect(DateFormatter().locale.identifier == "en_GB")

    let dd = Date(fromISO: "2025-08-26T10:29:23.321Z")
    #expect("26 Aug 2025 at 10:29:23" == dd.Display(display: .asUniversalTime))
    #expect("26 Aug 2025 at 12:29:23" == dd.Display(display: .asLocalTime))

    /*
     DateFormatter() is locale-dependent and platform-dependent. For some locales (like "en_GB"), the default medium format on macOS is 6 Aug 2025 at 10:29:23,
     but Linux's Foundation implementation or ICU data includes the AM/PM (6 Aug 2025 at 10:29:23 AM).
     */
    #expect("26 Aug 2025 at 10:29:23" == stripTrailingAM(dd.Display(display: .asUniversalTime)))
    #expect("26 Aug 2025 at 12:29:23" == stripTrailingAM(dd.Display(display: .asLocalTime)))

    let formatter = DateFormatter()
    formatter.dateFormat = "dd MMM yyyy 'at' HH:mm"
    #expect("26 Aug 2025 at 10:29" == stripTrailingAM(dd.Display(display: .asUniversalTime, formatter: formatter)))
    #expect("26 Aug 2025 at 12:29" == stripTrailingAM(dd.Display(display: .asLocalTime, formatter: formatter)))

    let withoutNano = Calendar.current.date(from: DateComponents(
        timeZone: TimeZone(abbreviation: "GMT"),
        year: 2025,
        month: 8,
        day: 26,
        hour: 10,
        minute: 29,
        second: 23))

    let withNano = Calendar.current.date(from: DateComponents(
        timeZone: TimeZone(abbreviation: "GMT"),
        year: 2025,
        month: 8,
        day: 26,
        hour: 10,
        minute: 29,
        second: 23,
        nanosecond: 321000000))

    let nano = Calendar.current.component(.nanosecond, from: dd)
    #expect(round(Double(nano) / 1000000.0) == 321)

    #expect(round(Double(nano) / 1000000.0) == round(Double(Calendar.current.component(.nanosecond, from: withNano!)) / 1000000.0))

    #expect(withoutNano == ISO8601DateFormatter().date(from: "2025-08-26T12:29:23+02:00"))
    #expect(withoutNano == ISO8601DateFormatter().date(from: "2025-08-26T10:29:23Z"))
}
