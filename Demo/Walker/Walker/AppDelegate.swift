import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  lazy var rootViewController: UIViewController = ViewController()
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow()
    window?.rootViewController = rootViewController
    window?.makeKeyAndVisible()

    return true
  }
}

