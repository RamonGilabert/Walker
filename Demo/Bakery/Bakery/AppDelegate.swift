import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    let rootViewController = ViewController()
    window?.rootViewController = rootViewController
    window?.makeKeyAndVisible()

    return true
  }
}

