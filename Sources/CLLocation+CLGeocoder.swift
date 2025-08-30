#if canImport(MapKit)
import Foundation
import MapKit

extension CLLocation {
    func reverseLocation() async -> String {
        guard let mark = await reverseLocation() else {
            return ""
        }
        return mark.name ?? ""
    }

    func reverseLocation() async -> CLPlacemark? {
        return await withCheckedContinuation { continuation in
            CLGeocoder().reverseGeocodeLocation(self) { placemarks, error in
                guard error == nil else {
                    Swift.print("Oh my god what a horror:" + error!.localizedDescription)
                    continuation.resume(returning: nil)
                    return
                }
                let placemark = placemarks?.first
                continuation.resume(returning: placemark)
            }
        }
    }
}
#endif