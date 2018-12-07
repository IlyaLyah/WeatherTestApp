import Foundation

public struct Wheather {
    public let temperature: Double
    public let pressure: Double
    public let humidity: Double

    public init(temperature: Double, pressure: Double, humidity: Double) {
        self.temperature = temperature
        self.pressure = pressure
        self.humidity = humidity
    }
}
