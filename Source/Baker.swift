import Foundation

struct Baker {

  static let springAnimationStep: CGFloat = 0.001
  static let springAnimationThreshold: CGFloat = 0.0001
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

  static func animateSpring(finalValue: NSValue) {
    
    // MARK: Call this method with the array of values, for instance from value x, y, z, etc.
    var proposedValue: CGFloat = 0
    var lastValue: CGFloat = 0

    while !springEnded {
      proposedValue = springPosition()
      springEnded = springStatusEnded(lastValue, proposed: proposedValue, to: finalValue)

      if springEnded { break }
      lastValue = proposedValue
    }
  }

  private static func springPosition() -> CGFloat {
    return 2
  }

  private static func springStatusEnded(previous: CGFloat, proposed: CGFloat, to: CGFloat) -> Bool {
    return abs(proposed - previous) <= springAnimationThreshold && (abs(previous - to) <= springAnimationThreshold || abs(previous - to) >= springAnimationThreshold)
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
