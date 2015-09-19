import Foundation

public struct Animation {

  public enum AnimationCurve {
    case EaseIn
    case EaseOut
    case EaseInOut
  }

  public var fromValue: NSValue?
  public var toValue: NSValue!
  public var duration: NSTimeInterval!
  public var delay: NSTimeInterval?

  public static func animate(curve: AnimationCurve, duration: NSTimeInterval, animations: (() -> Void)!) {
    UIView.animateWithDuration(0.4, animations: {
      animations()
    })
  }

  public static func cubicBezierAnimation(firstX: CGFloat, firstY: CGFloat, secondX: CGFloat, secondY: CGFloat, duration: NSTimeInterval, animations: (() -> Void)!) {

  }

  public static func springAnimation(tension: CGFloat, friction: CGFloat, velocity: CGFloat, animations: (() -> Void)!) {
    
  }
}
