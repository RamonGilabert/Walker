import Foundation

struct Animation {

  var fromValue: NSValue?
  var toValue: NSValue!
  var duration: NSTimeInterval!
  var delay: NSTimeInterval?

  func animate(curve: Baker.AnimationCurve, duration: NSTimeInterval) {

  }

  func cubicBezierAnimation(firstX: CGFloat, firstY: CGFloat, secondX: CGFloat, secondY: CGFloat, duration: NSTimeInterval) {

  }

  func springAnimation(tension: CGFloat, friction: CGFloat, velocity: CGFloat) {
    
  }
}
