import UIKit
import CoreLocation

class SecondStepTutorialViewController: UIViewController {
    @IBOutlet private weak var textLabel: UILabel!

    private let locationManager: CLLocationManager

    public init(locationManager: CLLocationManager) {
        self.locationManager = locationManager
        super.init(
            nibName: String(describing: SecondStepTutorialViewController.self),
            bundle: Bundle(for: SecondStepTutorialViewController.self)
        )
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated:true);
    }

    private func setupView() {
        self.textLabel.text = "Thank you for your permission."
    }

    @IBAction func okButtonTapped(_ sender: Any) {
        let weatherViewController = WheatherViewController(locationManager: self.locationManager)
        self.navigationController?.show(weatherViewController, sender: nil)
    }
}
