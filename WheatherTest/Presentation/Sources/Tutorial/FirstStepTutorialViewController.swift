import UIKit
import CoreLocation

class FirstStepTutorialViewController: UIViewController {
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var textLabel: UILabel!

    private let locationManager: CLLocationManager

    public init(locationManager: CLLocationManager) {
        self.locationManager = locationManager
        super.init(
            nibName: String(describing: FirstStepTutorialViewController.self),
            bundle: Bundle(for: FirstStepTutorialViewController.self)
        )
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.locationManager.delegate = self
        if !CLLocationManager.locationServicesEnabled() {
            self.locationManager.requestWhenInUseAuthorization()
        }
    }

    private func setupView() {
        self.textLabel.text = "Please grand your permission"
        self.nextButton.isHidden = !CLLocationManager.locationServicesEnabled()
    }

    @IBAction func nextButtonTapped(_ sender: Any) {
        let secondTutorialview = SecondStepTutorialViewController(locationManager: self.locationManager)
        self.navigationController?.show(secondTutorialview, sender: nil)
    }
}

extension FirstStepTutorialViewController: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.nextButton.isHidden = status != .authorizedWhenInUse
    }
}
