import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  lazy var rootViewController: UIViewController = ViewController()
  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    window = UIWindow()
    window?.rootViewController = rootViewController
    window?.makeKeyAndVisible()

    return true
  }
}

