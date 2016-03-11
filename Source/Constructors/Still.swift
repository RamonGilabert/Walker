import UIKit

public func distill(sets: (animation: CAKeyframeAnimation, final: NSValue)..., view: UIView, key: String? = nil) {

  for set in sets {
    guard let keyPath = set.animation.keyPath, property = Animation.Property(rawValue: keyPath),
      presentedLayer = view.layer.presentationLayer() as? CALayer else { break }

    if let _ = set.animation.timingFunction {
      set.animation.values = [Animation.propertyValue(property, layer: presentedLayer), set.final]
    } else {
      set.animation.values = Distill.calculateSpring(property, finalValue: set.final,
        layer: presentedLayer, type: .Spring)
      set.animation.duration = Distill.springTiming
    }

    view.layer.addAnimation(set.animation, forKey: key)
  }
}

var stills: [Still] = []

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
