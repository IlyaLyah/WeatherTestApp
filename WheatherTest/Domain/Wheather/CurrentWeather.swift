import Foundation
import CoreLocation

public protocol CurrentWeather {
    func currentWeather(for coordinate: CLLocationCoordinate2D, completion: @escaping (Weather?, Error?) -> ())
}
