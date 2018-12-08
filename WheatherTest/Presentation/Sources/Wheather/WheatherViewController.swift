import UIKit
import CoreLocation

class WheatherViewController: UIViewController {

    private let locationManager: CLLocationManager

    public init(locationManager: CLLocationManager) {
        self.locationManager = locationManager
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
        self.view.backgroundColor = .orange
        self.locationManager.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated:true);
    }

    private func setupView() {
        
    }
}

extension WheatherViewController: CLLocationManagerDelegate {
}
