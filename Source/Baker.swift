import Foundation

struct Baker {

  static var velocity: CGFloat = 0

  static func animate(curve: Animation.AnimationCurve, duration: NSTimeInterval, finalValue: CGFloat) {
    if curve == Animation.AnimationCurve.Linear {
      velocity = finalValue / CGFloat(duration)
    } else if curve == Animation.AnimationCurve.EaseIn {

    } else if curve == Animation.AnimationCurve.EaseOut {

    } else if curve == Animation.AnimationCurve.EaseInOut {
      
    }
  }

  // MARK: - CubicBezier

  // MARK: - Spring
}
