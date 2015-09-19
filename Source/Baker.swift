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

  struct CurvePoints {
    struct Linear {
      static let firstX: CGFloat = 0
      static let firstY: CGFloat = 0
      static let secondX: CGFloat = 1
      static let secondY: CGFloat = 1
    }

    struct Ease {
      static let firstX: CGFloat = 0.25
      static let firstY: CGFloat = 0.1
      static let secondX: CGFloat = 0.25
      static let secondY: CGFloat = 0.1
    }

    struct EaseIn {
      static let firstX: CGFloat = 0.42
      static let firstY: CGFloat = 0
      static let secondX: CGFloat = 1
      static let secondY: CGFloat = 1
    }

    struct EaseOut {
      static let firstX: CGFloat = 0
      static let firstY: CGFloat = 0
      static let secondX: CGFloat = 0.58
      static let secondY: CGFloat = 1
    }

    struct EaseInOut {
      static let firstX: CGFloat = 0.42
      static let firstY: CGFloat = 0
      static let secondX: CGFloat = 0.58
      static let secondY: CGFloat = 1
    }
  }
}
