import UIKit

/**
 Distill performs all the animations added by the tuple.

 - Parameter sets: A touple with multiple animations and final values.
 - Parameter view: The view you want to apply the animation to.
 - Parameter key: An optional key to put in the animation.
 */
public func distill(sets: (animation: CAKeyframeAnimation, final: NSValue)..., view: UIView, key: String? = nil) {

  for set in sets {
    guard let keyPath = set.animation.keyPath, property = Animation.Property(rawValue: keyPath),
      presentedLayer = view.layer.presentationLayer() as? CALayer else { break }

    if let _ = set.animation.timingFunction {
      set.animation.values = [Animation.propertyValue(property, layer: presentedLayer), set.final]
    }

    // TODO: Implement reusable springs.

    view.layer.addAnimation(set.animation, forKey: key)
  }
}

var stills: [Still] = []

public struct Still {

  /**
   Defines and returns an animation with some parameters.

   - Parameter property: The Animation.Property that you want to animate.
   - Parameter curve: The animation curve you want it to be, cannot be Spring.
   - Parameter duration: The duration of the animation, defaults to 0.5.
   - Parameter options: A set of options that can be .Reverse or .Repeat().

   - Returns: A CAKeyframeAnimation you can modify.
   */
  public static func bezier(property: Animation.Property, curve: Animation.Curve = .Linear,
    duration: NSTimeInterval = 0.5, options: [Animation.Options] = []) -> CAKeyframeAnimation {

      return Distill.bezier(property,
        bezierPoints: Animation.points(curve), duration: duration, options: options)
  }
}
