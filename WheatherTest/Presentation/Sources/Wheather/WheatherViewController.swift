import UIKit
import CoreLocation

class WheatherViewController: UIViewController {
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var pressureLabel: UILabel!
    @IBOutlet private weak var humdaityLabel: UILabel!

    @IBOutlet private weak var loadingView: UIView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    private let locationManager: CLLocationManager
    private let currentWeather: CurrentWeather

    public init(locationManager: CLLocationManager, currentWeather: CurrentWeather) {
        self.locationManager = locationManager
        self.currentWeather = currentWeather
        super.init(
            nibName: String(describing: WheatherViewController.self),
            bundle: Bundle(for: WheatherViewController.self)
        )
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated:true);
    }

    private func setupView() {
        self.temperatureLabel.text = ""
        self.pressureLabel.text = ""
        self.humdaityLabel.text = ""

        self.loadingView.isHidden = false
        self.activityIndicator.startAnimating()
    }
}

extension WheatherViewController: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        self.currentWeather.currentWeather(for: coordinate) { weather, error in
            if let error = error {
                print(error)
            }
            if let weather = weather {
                DispatchQueue.main.async {
                    let formatter = MeasurementFormatter()
                    let measurement = Measurement(value: weather.temperature, unit: UnitTemperature.kelvin)
                    self.temperatureLabel.text = formatter.string(from: measurement)
                    self.pressureLabel.text = "\(weather.pressure)"
                    self.humdaityLabel.text = "\(weather.humidity)"
                    self.loadingView.isHidden = true
                }
                self.locationManager.stopUpdatingLocation()
            }
        }
    }
}
