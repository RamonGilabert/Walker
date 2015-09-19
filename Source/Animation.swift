import Foundation

extension CALayer {

  public func animate(property: Animation.Property, to: NSValue, duration: NSTimeInterval, curve: Animation.Curve = .Linear) {
    let bezierPoints = Animation.bezierPoints(curve)
    let animation = Baker.configureBezierAnimation(property, bezierPoints: bezierPoints, duration: NSTimeInterval)
    animation.values = [Animation.propertyValue(property, layer: self), to]

    addAnimation(animation, forKey: nil)
  }

  public func animateBezier(property: Animation.Property, to: NSValue, bezierPoints: [Float], duration: NSTimeInterval) {
    guard bezierPoints.count == 4 else { return }
    
    let animation = Baker.configureBezierAnimation(property, bezierPoints: bezierPoints, duration: NSTimeInterval)
    animation.values = [Animation.propertyValue(property, layer: self), to]

    addAnimation(animation, forKey: nil)
  }

  public func animateSpring(property: Animation.Property, to: NSValue, tension: CGFloat, friction: CGFloat, velocity: CGFloat) {
    
  }
}
