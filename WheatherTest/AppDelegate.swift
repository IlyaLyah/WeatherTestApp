import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let locationManager = CLLocationManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)

        let viewController: UIViewController
        if CLLocationManager.authorizationStatus() != .restricted || CLLocationManager.authorizationStatus() != .denied {
            viewController = FirstStepTutorialViewController(locationManager: self.locationManager)
        } else {
            viewController = WheatherViewController(
                locationManager: self.locationManager,
                currentWeather: CurrentWeatherApi()
            )
        }
        let navigtionController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigtionController
        window?.makeKeyAndVisible()

        return true
    }
}

