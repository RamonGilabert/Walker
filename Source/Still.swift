import UIKit

public func distill(animations: CAKeyframeAnimation..., values: [NSValue], view: UIView) {
  guard animations.count == values.count else { return }

  for (index, animation) in animations.enumerate() {
    animation.values = [view.layer.position.x, values[index]]
    view.layer.addAnimation(animation, forKey: nil)
  }
}

public struct Still {

  public static func bezier(property: Animation.Property, curve: Animation.Curve = .Linear,
    duration: NSTimeInterval = 0.5, options: [Animation.Options] = []) -> CAKeyframeAnimation {

      return Distill.bezier(property,
        bezierPoints: Animation.points(curve), duration: duration, options: options)
  }

  public static func spring(property: Animation.Property, spring: CGFloat,
    friction: CGFloat, mass: CGFloat, tolerance: CGFloat = 0.0001,
    calculation: Animation.Spring = .Spring) -> CAKeyframeAnimation {

      return Distill.spring(property, spring: spring, friction: friction,
        mass: mass, tolerance: tolerance, type: calculation)
  }
}
