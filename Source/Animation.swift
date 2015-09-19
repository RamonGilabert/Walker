import Foundation

struct Animation {

  var fromValue: NSValue?
  var toValue: NSValue!
  var duration: NSTimeInterval!
  var delay: NSTimeInterval?

  func animate(curve: Baker.AnimationCurve, duration: NSTimeInterval, animations: (() -> Void)!) {
    print(animations)
  }

  func cubicBezierAnimation(firstX: CGFloat, firstY: CGFloat, secondX: CGFloat, secondY: CGFloat, duration: NSTimeInterval, animations: (() -> Void)!) {

  }

  func springAnimation(tension: CGFloat, friction: CGFloat, velocity: CGFloat, animations: (() -> Void)!) {
    
  }
}
