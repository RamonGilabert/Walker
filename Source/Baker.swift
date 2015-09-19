import Foundation

struct Baker {

  static var velocity: CGFloat = 0

  static func animate(curve: Animation.AnimationCurve, duration: NSTimeInterval, finalValue: CGFloat) {
    let time = Timing.timing(curve, duration)
  }

  // MARK: - CubicBezier

  // MARK: - Spring
}

struct Timing {

  static func timing(curve: Animation.AnimationCurve, _ duration: NSTimeInterval) -> NSTimeInterval {
    switch curve {
    case .Linear:
      return duration
    case .EaseIn:
      return duration * duration * duration
    case .EaseOut:
      return pow(duration - 1, 3) + 1
    case .EaseInOut:
      return duration < 0.5 ? pow(duration, 3) * 4 : pow(2 * duration - 2, 2) * (duration - 1) + 1
    }
  }
}

struct Interpolation {

}