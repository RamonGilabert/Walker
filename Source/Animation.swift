import Foundation

extension CALayer {

  public func animate(property: Animation.Property, to: NSValue, duration: NSTimeInterval, curve: Animation.Curve = .Linear) {
    let animation = BakerAnimation(keyPath: property.rawValue)
    let bezierPoints = Animation.bezierPoints(curve)
    let initialValue = Animation.propertyValue(property, layer: self)

    animation.values = [initialValue, to]
    animation.keyTimes = [0, duration]
    animation.duration = duration
    animation.removedOnCompletion = false
    animation.fillMode = kCAFillModeForwards
    animation.timingFunction = CAMediaTimingFunction(controlPoints:
      bezierPoints[0], bezierPoints[1], bezierPoints[2], bezierPoints[3])

    addAnimation(animation, forKey: nil)
  }

  public func animateBezier<T>(property: Animation.Property, to: T, _firstX: CGFloat, _firstY: CGFloat, _secondX: CGFloat, _secondY: CGFloat, duration: NSTimeInterval) {

  }

  public func animateSpring<T>(property: Animation.Property, to: T, _tension: CGFloat, _friction: CGFloat, _velocity: CGFloat) {
    
  }
}
