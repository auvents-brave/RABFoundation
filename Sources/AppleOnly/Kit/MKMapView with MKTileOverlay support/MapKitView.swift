import MapKit
import SwiftUI

#if os(watchOS)
    @available(watchOS 10, *)
    @Observable class MapViewModel {
        var position: MapCameraPosition
        var span: MKCoordinateSpan

        init(initialRegion: MKCoordinateRegion) {
            position = MapCameraPosition.region(initialRegion)
            span = initialRegion.span
        }

        public func setRegion(_ newRegion: MKCoordinateRegion) {
            position = MapCameraPosition.region(newRegion)
            span = newRegion.span
        }
    }

    @available(watchOS 10, *)
    public struct MapKitView: View {
        @State var viewModel: MapViewModel

        public init() {
            self.init(overlays: [])
        }

        public init(cacheDirectory: String, urlTemplate: String) {
            self.init(overlays: [(cacheDirectory: cacheDirectory, urlTemplate: urlTemplate)])
        }

        public init(overlays: [(cacheDirectory: String, urlTemplate: String)]) {
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: 20,
                    longitude: 0
                ),
                span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
            )
            viewModel = MapViewModel(initialRegion: region)
        }

        public func setRegion(_ newRegion: MKCoordinateRegion) {
            viewModel.setRegion(newRegion)
        }

        public var body: some View {
            if #available(watchOS 12, *) {
                Map(position: $viewModel.position)
                    .accessibilityIdentifier("MapKitView.map")
            } else {
                Text("Not supported")
                    .accessibilityIdentifier("MapKitView.map")
            }
        }
    }
#else
    /// A SwiftUI view that wraps an MKMapView and supports multiple cached tile overlays.
    public struct MapKitView: View {
        /// The delegate handling MKMapView rendering and events.
        let delegate = MapDelegate()
        /// The underlying MKMapView instance displayed by this view.
        let map = MKMapView()

        /// Creates a MapKitView instance without any tile overlays.
        public init() {
            self.init(overlays: [])
        }

        /// Creates a MapKitView instance with a single tile overlay specified by cache directory and URL template.
        ///
        /// - Parameters:
        ///   - cacheDirectory: The directory to cache map tiles.
        ///   - urlTemplate: The URL template string for the tile overlay.
        public init(cacheDirectory: String, urlTemplate: String) {
            self.init(overlays: [(cacheDirectory: cacheDirectory, urlTemplate: urlTemplate)])
        }

        /// Creates a MapKitView instance with multiple tile overlays.
        ///
        /// - Parameter overlays: An array of tuples where each contains a cache directory and URL template.
        public init(overlays: [(cacheDirectory: String, urlTemplate: String)]) {
            map.delegate = delegate
            for overlay in overlays {
                map.addOverlay(CachedTileOverlay(directory: overlay.cacheDirectory, urlTemplate: overlay.urlTemplate))
            }
        }

        public func setRegion(_ region: MKCoordinateRegion) {
            map.setRegion(region, animated: false)
        }

        /// The SwiftUI view that wraps the MKMapView and ignores safe area edges.
        public var body: some View {
            WrapperView(view: map).ignoresSafeArea()
                .accessibilityIdentifier("MapKitView.map")
        }
    }
#endif

/// Preview showing a plain MapKitView without any overlays.
@available(watchOS 12, *)
#Preview("Plain") {
    MapKitView()
}

/// Preview showing a MapKitView with OpenStreetMap tile overlay.
@available(watchOS 12, *)
#Preview("OpenStreetMap") {
    let v = MapKitView(cacheDirectory: "openstreetmapcache", urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png")
    v.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 43.7384, longitude: 7.4246), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)))
    return v
}

/// Preview showing a MapKitView with OpenTopoMap tile overlay.
@available(watchOS 12, *)
#Preview("OpenTopoMap") {
	let v = MapKitView(cacheDirectory: "opentopomapcache", urlTemplate: "https://a.tile.opentopomap.org/{z}/{x}/{y}.png")
    v.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 44.9224, longitude: 6.3608), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
    return v
}

/// Preview showing a MapKitView with IGN (France) WMTS tile overlay.
/// See: https://geoservices.ign.fr/services-web-essentiels
@available(watchOS 12, *)
#Preview("IGN (France)") {
	let v = MapKitView(cacheDirectory: "igncache", urlTemplate: "https://data.geopf.fr/wmts?layer=GEOGRAPHICALGRIDSYSTEMS.PLANIGNV2&style=normal&tilematrixset=PM&Service=WMTS&Request=GetTile&Version=1.0.0&Format=image%2Fpng&TileMatrix={z}&TileCol={x}&TileRow={y})")
    v.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 44.9224, longitude: 6.3608), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
    return v
}

/// Preview showing a MapKitView with Carte de Cassini (France XVIII) WMTS tile overlay.
@available(watchOS 12, *)
#Preview("Carte de Cassini (France XVIII)") {
	let v = MapKitView(cacheDirectory: "cassinicache", urlTemplate: "https://data.geopf.fr/wmts?layer=BNF-IGNF_GEOGRAPHICALGRIDSYSTEMS.CASSINI&style=normal&tilematrixset=PM&Service=WMTS&Request=GetTile&Version=1.0.0&Format=image%2Fpng&TileMatrix={z}&TileCol={x}&TileRow={y})")
    v.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 45.0050, longitude: 6.5180), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
    return v
}

/// Preview showing a MapKitView with several overlays including OpenTopoMap and OpenSeaMap.
@available(watchOS 12, *)
#Preview("OpenSeaMap") {
	let v = MapKitView(cacheDirectory: "openseamapcache", urlTemplate: "https://tiles.openseamap.org/seamark/{z}/{x}/{y}.png")
    v.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 43.6956, longitude: 7.2906), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)))
    return v
}

/// Preview showing a MapKitView with several overlays including OpenTopoMap and OpenSeaMap.
@available(watchOS 12, *)
#Preview("Several overlays") {
    let overlays = [
        (cacheDirectory: "opentopomapcache", urlTemplate: "https://a.tile.opentopomap.org/{z}/{x}/{y}.png"),
        (cacheDirectory: "openseamapcache", urlTemplate: "https://tiles.openseamap.org/seamark/{z}/{x}/{y}.png"),
    ]
	let v = MapKitView(overlays: overlays)
    v.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 43.7396, longitude: 7.4276), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))
    return v
}
