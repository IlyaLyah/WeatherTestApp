import Foundation
import CoreLocation

public class CurrentWeatherApi: CurrentWeather {
    public func currentWeather(for coordinate: CLLocationCoordinate2D, completion: @escaping (Weather?, Error?) -> ()) {
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&appid=49f20f282ef2dbc885e9c41df5651558")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error)
            }

            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                completion(nil, NSError.unexpectedResponseStatusCodeError())
            }

            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
                    if let json = json, let weather = Weather.from(json) {
                        completion(weather, nil)
                    } else {
                        completion(nil, NSError.unknownDataFormat())
                    }
                } catch {
                    completion(nil, NSError.unknownDataFormat())
                }
            }
        }
        task.resume()
    }
}

extension Weather {
    static func from(_ data: [String: Any]) -> Weather? {
        guard
            let mainDict = data["main"] as? [String: Any],
            let temperature = mainDict["temp"] as? Double,
            let humdaity = mainDict["humidity"] as? Double,
            let pressure = mainDict["pressure"] as? Double
            else { return nil }
        return Weather(temperature: temperature, pressure: pressure, humidity: humdaity)
    }
}
