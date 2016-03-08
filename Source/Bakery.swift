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

  public func alpha(value: CGFloat) {
    animate(.Opacity, value)
  }

  public func x(value: CGFloat) {
    animate(.PositionX, value)
  }

  public func y(value: CGFloat) {
    animate(.PositionY, value)
  }

  public func width(value: CGFloat) {
    animate(.Width, value)
  }

  public func height(value: CGFloat) {
    animate(.Height, value)
  }

  public func origin(x: CGFloat, _ y: CGFloat) {
    animate(.Origin, NSValue(CGPoint: CGPoint(x: x, y: y)))
  }

  public func size(width: CGFloat, _ height: CGFloat) {
    animate(.Size, NSValue(CGSize: CGSize(width: width, height: height)))
  }

  public func frame(x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
    animate(.Frame, NSValue(CGRect: CGRect(x: x, y: y, width: width, height: height)))
  }

  public func radius(value: CGFloat) {
    animate(.CornerRadius, value)
  }

  public func transform(value: CGAffineTransform) {
    //animate(.Transform, value)
  }

  internal let view: UIView
  internal let duration: NSTimeInterval
  internal let curve: Animation.Curve

  init(view: UIView, duration: NSTimeInterval, curve: Animation.Curve) {
    self.view = view
    self.duration = duration
    self.curve = curve
  }

  private func animate(property: Animation.Property, _ value: NSValue) {
    let bezierPoints = Animation.bezierPoints(curve)
    let animation = Baker.configureBezierAnimation(property, bezierPoints: bezierPoints, duration: duration)
    animation.values = [Animation.propertyValue(property, layer: view.layer), value]

    view.layer.addAnimation(animation, forKey: nil)
  }
}
