import Foundation

struct Baker {

  static let springAnimationStep = 0.001
  static let springAnimationThreshold = 0.0001
  static var tension: CGFloat = 200
  static var friction: CGFloat = 10
  static var velocity: CGFloat = 10
  static var springEnded = false

  // MARK: - Bezier animations

  static func configureBezierAnimation(property: Animation.Property, bezierPoints: [Float], duration: NSTimeInterval) -> BakerAnimation {
    let animation = BakerAnimation(keyPath: property.rawValue)
    animation.keyTimes = [0, duration]
    animation.duration = duration
    animation.removedOnCompletion = false
    animation.fillMode = kCAFillModeForwards
    animation.timingFunction = CAMediaTimingFunction(controlPoints:
      bezierPoints[0], bezierPoints[1], bezierPoints[2], bezierPoints[3])

    return animation
  }

  // MARK: - Spring animations

  // MARK: - Spring constants

  static func animateSpring() {
    var proposedValue: NSValue = 0

    while !springEnded {
      proposedValue = springPosition()
      springEnded = springStatusEnded()

      if springEnded { break }
    }
  }

  private static func springPosition() -> NSValue {
    return 2
  }

  private static func springStatusEnded() -> Bool {
    return false
  }
}

class BakerAnimation: CAKeyframeAnimation {
  var fromValue: NSValue = 0
  var toValue: NSValue = 0
  var timing: CFTimeInterval = 0

  override init() {
    super.init()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
