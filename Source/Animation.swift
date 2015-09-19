import Foundation

extension CALayer {

  public func animate<Value>(property: Animation.Property, from: Value, to: Value, duration: NSTimeInterval, curve: Animation.Curve) {
    let animation = BakerAnimation(keyPath: property.rawValue)
    animation.fromValue = from as! CGFloat
    animation.toValue = from as! CGFloat
    addAnimation(animation, forKey: property.rawValue)
  }

  public func animateBezier<T>(property: Animation.Property, to: T, _firstX: CGFloat, _firstY: CGFloat, _secondX: CGFloat, _secondY: CGFloat, duration: NSTimeInterval) {

  }

  public func animateSpring<T>(property: Animation.Property, to: T, _tension: CGFloat, _friction: CGFloat, _velocity: CGFloat) {
    
  }
}

class BakerAnimation: CAKeyframeAnimation {
  var fromValue: CGFloat = 0
  var toValue : CGFloat = 0

  override init() {
    super.init()
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
}
