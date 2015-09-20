import Foundation

struct Baker {

  static let springAnimationStep: CFTimeInterval = 0.001
  static let springAnimationIncrement: CGFloat = 0.0001
  static var mass: CGFloat = 200
  static var spring: CGFloat = 10
  static var friction: CGFloat = 10
  static var springEnded = false
  static var springTiming: CFTimeInterval = 0

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

  static func animateSpring(property: Animation.Property, finalValue: NSValue, layer: CALayer) -> [NSValue] {
    let initialArray = Animation.values(property, to: finalValue, layer: layer).initialValue
    let finalArray = Animation.values(property, to: finalValue, layer: layer).finalValue
    var distances: [CGFloat] = []
    var increments: [CGFloat] = []
    var proposedValues: [CGFloat] = []
    var stepValues: [CGFloat] = []
    var finalValues: [NSValue] = []
    springEnded = false
    springTiming = 0

    for (index, element) in initialArray.enumerate() {
      distances.append(finalArray[index] - element)
      increments.append(abs(distances[index]) * springAnimationIncrement)
      proposedValues.append(0)
      stepValues.append(0)
    }

    while !springEnded {
      for (index, element) in initialArray.enumerate() {
        proposedValues[index] = springPosition(distances[index], time: springTiming, from: element)
        springEnded = springStatusEnded(stepValues[index], proposed: proposedValues[index],
          to: finalArray[index], increment: increments[index])
      }

      guard !springEnded else { break }
      for (index, element) in proposedValues.enumerate() {
        stepValues[index] = element
        finalValues.append(stepValues[index])
      }

      springTiming += springAnimationStep
    }
    print(finalValues)
    return finalValues
  }

  private static func springPosition(distance: CGFloat, time: CFTimeInterval, from: CGFloat) -> CGFloat {
    let gamma = pow(friction, 2) / (4 * pow(mass, 2))
    let angularVelocity = sqrt((spring / mass) - gamma)
    let position = exp(-gamma * CGFloat(time)) * distance * cos(angularVelocity * CGFloat(time))

    return position
  }

  private static func springStatusEnded(previous: CGFloat, proposed: CGFloat, to: CGFloat, increment: CGFloat) -> Bool {
    return abs(proposed - previous) <= increment && (abs(previous - to) <= increment || abs(previous - to) >= increment)
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
