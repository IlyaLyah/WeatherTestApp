import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)

        let homeViewController: UIViewController
        if !CLLocationManager.locationServicesEnabled() {
            homeViewController = FirstStepTutorialViewController()
        } else {
            homeViewController = WheatherViewController()
        }
        let navigtionController = UINavigationController(rootViewController: homeViewController)
        window?.rootViewController = navigtionController
        window?.makeKeyAndVisible()

        return true
    }
}

