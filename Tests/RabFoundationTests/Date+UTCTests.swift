import Foundation
@testable import RabFoundation
import Testing

@Test("Create Date from ISO string") func BuildDate() async throws {
    let isoString = "025-08-26T10:29:23.321Z"

    let dd = Date(fromISO: "025-08-26T10:29:23.321Z")

    print(dd.Display(display: .asUniversalTime))
    print(dd.Display(display: .asLocalTime))
/*

    let fractional = ISO8601DateFormatter()
    fractional.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

    let date = if isoString.contains(".") {
        fractional.date(from: isoString)
    } else {
        ISO8601DateFormatter().date(from: isoString)
    }

    print(date!)

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
        nanosecond: 321))

    let nano = Calendar.current.component(.nanosecond, from: date!)
    #expect(nano == 321)

    #expect(withoutNano == ISO8601DateFormatter().date(from: "2025-08-26T12:29:23+02:00"))
    #expect(withoutNano == ISO8601DateFormatter().date(from: "2025-08-26T10:29:23Z"))

    #expect(withoutNano == fractional.date(from: "2025-08-26T12:29:23+02:00"))
    #expect(withoutNano == fractional.date(from: "2025-08-26T10:29:23Z"))

    //   #expect(withNano ==  fractional.date(from:  "2025-08-26T12:29:23.321+02:00"))
//    #expect(withNano ==  fractional.date(from: "2025-08-26T10:29:23.321Z"))

 */

    
}
