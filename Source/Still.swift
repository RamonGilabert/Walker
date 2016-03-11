import UIKit

public func distill(animations: CAKeyframeAnimation..., values: [NSValue], view: UIView) {
  guard animations.count == values.count else { return }
}

public struct Still {

  public static func bezier(property: Animation.Property, curve: Animation.Curve = .Linear,
    duration: NSTimeInterval = 0.5, options: [Animation.Options] = []) -> CAKeyframeAnimation {

      return Baker.bezier(property,
        bezierPoints: Animation.points(curve), duration: duration, options: options)
  }

  public static func spring(property: Animation.Property, spring: CGFloat,
    friction: CGFloat, mass: CGFloat, tolerance: CGFloat = 0.0001,
    calculation: Animation.Spring = .Spring) -> CAKeyframeAnimation {

      return Baker.spring(property, spring: spring, friction: friction,
        mass: mass, tolerance: tolerance, type: calculation)
  }
}
