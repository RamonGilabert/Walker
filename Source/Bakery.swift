import UIKit

public func animate(duration: NSTimeInterval = 0.5, curve: Animation.Curve = .Linear, animations: () -> ()) -> Bakery {
  UIView.animateWithDuration(duration, animations: {
    animations()
  })

  return Bakery.bakery
}

public class Bakery: NSObject {

  private static let bakery = Bakery()

  public func animate(duration: NSTimeInterval = 0.5, curve: Animation.Curve = .Linear, animations: () -> ()) -> Bakery {
    UIView.animateWithDuration(duration, animations: {
      animations()
    })

    return self
  }

  public func then(closure: () -> ()) -> Bakery {
    closure()

    return self
  }

  public func finally(closure: () -> ()) {
    closure()
  }
}
