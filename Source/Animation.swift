import Foundation

extension CALayer {

  public func animate<T>(curve: Animation.Curve, duration: NSTimeInterval, from: T, to: T) {
    print(self.backgroundColor)
  }

  public func cubicBezierAnimation<T>(firstX: CGFloat, firstY: CGFloat, secondX: CGFloat, secondY: CGFloat, duration: NSTimeInterval, from: T, to: T) {

  }

  public func springAnimation<T>(tension: CGFloat, friction: CGFloat, velocity: CGFloat, from: T, to: T) {
    
  }
}
