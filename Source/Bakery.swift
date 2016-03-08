import UIKit

public func animate(view: UIView, duration: NSTimeInterval = 0.5, curve: Animation.Curve = .Linear, animations: (Bake) -> ()) -> Bakery {
  animations(Bake(view: view, duration: duration, curve: curve))

  return Bakery.bakery
}

public func bezier(view: UIView, points: [CGFloat], animations: (Bake) -> ()) -> Bakery {
  //animations(Bake(view: view, duration: duration, curve: curve))

  return Bakery.bakery
}

public func spring(view: UIView, spring: CGFloat, friction: CGFloat, mass: CGFloat, tolerance: CGFloat = 0.0001, animations: (Bake) -> ()) -> Bakery {
  //animations(Bake(view: view, duration: duration, curve: curve))

  return Bakery.bakery
}

public class Bakery: NSObject {

  private static let bakery = Bakery()

  public func animate(view: UIView, duration: NSTimeInterval = 0.5, curve: Animation.Curve = .Linear, animations: (Bake) -> ()) -> Bakery {
    animations(Bake(view: view, duration: duration, curve: curve))

    return self
  }

  public func bezier(view: UIView, points: [CGFloat], animations: (Bake) -> ()) -> Bakery {
    //animations(Bake(view: view, duration: duration, curve: curve))

    return Bakery.bakery
  }

  public func spring(view: UIView, spring: CGFloat, friction: CGFloat, mass: CGFloat, tolerance: CGFloat = 0.0001, animations: (Bake) -> ()) -> Bakery {
    //animations(Bake(view: view, duration: duration, curve: curve))

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

public struct Bake {

  internal let view: UIView
  internal let duration: NSTimeInterval
  internal let curve: Animation.Curve

  public func alpha(value: CGFloat) {
    view.alpha = value
  }

  public func x(value: CGFloat) {
    view.frame.origin.x = value
  }

  public func y(value: CGFloat) {
    view.frame.origin.y = value
  }

  public func width(value: CGFloat) {
    let bezierPoints = Animation.bezierPoints(curve)
    let animation = Baker.configureBezierAnimation(.Width, bezierPoints: bezierPoints, duration: duration)
    animation.values = [Animation.propertyValue(.Width, layer: view.layer), value]

    view.layer.addAnimation(animation, forKey: nil)
  }

  public func height(value: CGFloat) {
    view.frame.size.height = value
  }

  public func size(value: CGSize) {
    view.frame.size = value
  }

  public func origin(value: CGPoint) {
    view.frame.origin = value
  }

  public func frame(value: CGRect) {
    view.frame = value
  }

  public func radius(value: CGFloat) {
    view.layer.cornerRadius = value
  }

  public func transform(value: CGAffineTransform) {
    view.transform = value
  }

  init(view: UIView, duration: NSTimeInterval, curve: Animation.Curve) {
    self.view = view
    self.duration = duration
    self.curve = curve
  }
}
