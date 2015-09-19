import Foundation

extension CALayer {

  public func animate(property: Animation.Property, to: NSValue, duration: NSTimeInterval, curve: Animation.Curve?) {
    let animationCurve = curve != nil ? curve : .Linear
    let animation = BakerAnimation(keyPath: property.rawValue)

    animation.values = [position.y, to]
    animation.keyTimes = [0, duration]
    animation.duration = duration
    animation.removedOnCompletion = false
    animation.fillMode = kCAFillModeForwards
    
    animation.timingFunction = CAMediaTimingFunction(controlPoints:
      AnimationConstant.CurvePoints.EaseInOut.firstX,
      AnimationConstant.CurvePoints.EaseInOut.firstY,
      AnimationConstant.CurvePoints.EaseInOut.secondX,
      AnimationConstant.CurvePoints.EaseInOut.secondY)

    addAnimation(animation, forKey: nil)
  }

  public func animateBezier<T>(property: Animation.Property, to: T, _firstX: CGFloat, _firstY: CGFloat, _secondX: CGFloat, _secondY: CGFloat, duration: NSTimeInterval) {

  }

  public func animateSpring<T>(property: Animation.Property, to: T, _tension: CGFloat, _friction: CGFloat, _velocity: CGFloat) {
    
  }
}
