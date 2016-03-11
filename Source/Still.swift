import UIKit

public func perform(animations: CAKeyframeAnimation..., view: UIView) {

}

public struct Still {

  public func animation(property: Animation.Property, curve: Animation.Curve = .Linear,
    duration: NSTimeInterval = 0.5, options: [Animation.Options]) -> CAKeyframeAnimation {

      return Baker.bezier(property,
        bezierPoints: Animation.points(curve), duration: duration, options: options)
  }

  public func spring(property: Animation.Property, spring: CGFloat,
    friction: CGFloat, mass: CGFloat, tolerance: CGFloat,
    calculation: Animation.Spring) -> CAKeyframeAnimation {

      return Baker.spring(property, spring: spring, friction: friction,
        mass: mass, tolerance: tolerance, type: calculation)
  }
}
