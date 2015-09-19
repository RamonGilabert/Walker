import Foundation

extension CALayer {

  public func animate<Value>(to: Value, duration: NSTimeInterval, curve: Animation.Curve) {
    print(self.backgroundColor)
  }

  public func cubicBezierAnimation<T>(to: T, _firstX: CGFloat, _firstY: CGFloat, _secondX: CGFloat, _secondY: CGFloat, duration: NSTimeInterval) {

  }

  public func springAnimation<T>(to: T, _tension: CGFloat, _friction: CGFloat, _velocity: CGFloat) {
    
  }
}
