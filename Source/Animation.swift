import Foundation

extension CALayer {

  public func animate(property: Animation.Property, to: NSValue, duration: NSTimeInterval, curve: Animation.Curve = .Linear) {
    let bezierPoints = Animation.bezierPoints(curve)
    let animation = Baker.configureBezierAnimation(property, bezierPoints: bezierPoints, duration: duration)
    //animation.values = [Animation.propertyValue(property, layer: self), to]

    addAnimation(animation, forKey: nil)
  }

  public func animateBezier(property: Animation.Property, to: NSValue, bezierPoints: [Float], duration: NSTimeInterval) {
    guard bezierPoints.count == 4 else { return }
    
    let animation = Baker.configureBezierAnimation(property, bezierPoints: bezierPoints, duration: duration)
    //animation.values = [Animation.propertyValue(property, layer: self), to]

    addAnimation(animation, forKey: nil)
  }

  public func animateSpring(property: Animation.Property, to: NSValue,
    spring: CGFloat, friction: CGFloat, mass: CGFloat, tolerance: CGFloat = 0.0001) {
      let animation = Baker.configureSpringAnimations(property, to: to, spring: spring,
        friction: friction, mass: mass, tolerance: tolerance, type: .Spring, layer: self)

      addAnimation(animation, forKey: nil)
  }

  public func animateSpringBounce(property: Animation.Property, to: NSValue,
    spring: CGFloat, friction: CGFloat, mass: CGFloat, tolerance: CGFloat = 0.0001) {
      let animation = Baker.configureSpringAnimations(property, to: to, spring: spring,
        friction: friction, mass: mass, tolerance: tolerance, type: .Bounce, layer: self)

      addAnimation(animation, forKey: nil)
  }
}
