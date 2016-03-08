import UIKit

public func animate(duration: NSTimeInterval = 0.5, curve: Animation.Curve = .Linear, animations: () -> ()) -> Bakery {
  UIView.animateWithDuration(duration, animations: {
    animations()
  })

  Bakery.animationDelay = duration

  return Bakery.bakery
}

public class Bakery: NSObject {

  static let bakery = Bakery()
  static var animationDelay: NSTimeInterval = 0

  public func animate(duration: NSTimeInterval = 0.5, curve: Animation.Curve = .Linear, animations: () -> ()) -> Bakery {
    let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(Bakery.animationDelay * Double(NSEC_PER_SEC)))
    dispatch_after(delayTime, dispatch_get_main_queue()) {
      UIView.animateWithDuration(duration, animations: {
        animations()
      })
    }

    Bakery.animationDelay = duration

    return self
  }

  public func then(closure: () -> ()) -> Bakery {
    let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(Bakery.animationDelay * Double(NSEC_PER_SEC)))
    dispatch_after(delayTime, dispatch_get_main_queue()) {
      closure()
    }

    return self
  }

  public func finally(closure: () -> ()) {
    let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(Bakery.animationDelay * Double(NSEC_PER_SEC)))
    dispatch_after(delayTime, dispatch_get_main_queue()) {
      closure()
    }
  }
}
