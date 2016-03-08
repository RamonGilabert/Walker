import UIKit

public class Bakery: NSObject {

  public func animate(duration: NSTimeInterval = 0.5, curve: Animation.Curve = .Linear, animations: () -> ()) -> Bakery {
    UIView.animateWithDuration(duration, animations: {
      animations()
    })

    return self
  }

  public func then(closure: () -> ()) {
    closure()
  }
}
