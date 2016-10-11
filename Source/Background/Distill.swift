import UIKit

class Distill {

  internal let springAnimationStep: CFTimeInterval = 0.001
  internal var spring: CGFloat = 300
  internal var friction: CGFloat = 30
  internal var mass: CGFloat = 6
  internal var tolerance: CGFloat = 0.00001
  internal var springEnded = false
  internal var springTiming: CFTimeInterval = 0

  // MARK: - Cubic bezier

  static func bezier(_ property: Animation.Property, bezierPoints: [Float], duration: TimeInterval, options: [Animation.Options]) -> CAKeyframeAnimation {
    let animation = CAKeyframeAnimation(keyPath: property.rawValue)
    animation.duration = duration
    animation.isRemovedOnCompletion = false
    animation.fillMode = kCAFillModeForwards
    animation.isAdditive = false
    animation.isCumulative = false
    animation.timingFunction = CAMediaTimingFunction(controlPoints:
      bezierPoints[0], bezierPoints[1], bezierPoints[2], bezierPoints[3])

    options.forEach { option in
      switch option {
      case .reverse :
        animation.autoreverses = true
      case let .repeat(t):
        animation.repeatCount = t
      }
    }

    return animation
  }

  // MARK: - Spring

  static func spring(_ property: Animation.Property, type: Animation.Spring) -> CAKeyframeAnimation {
    let animation = CAKeyframeAnimation(keyPath: property.rawValue)
    animation.isRemovedOnCompletion = false
    animation.fillMode = kCAFillModeForwards

    return animation
  }

  func calculateSpring(_ property: Animation.Property, finalValue: NSValue,
    layer: CALayer, type: Animation.Spring,
    spring: (spring: CGFloat, friction: CGFloat, mass: CGFloat, tolerance: CGFloat)) -> [NSValue] {

      let initialArray = Animation.values(property, to: finalValue, layer: layer).initialValue
      let finalArray = Animation.values(property, to: finalValue, layer: layer).finalValue
      var distances: [CGFloat] = []
      var increments: [CGFloat] = []
      var proposedValues: [CGFloat] = []
      var stepValues: [CGFloat] = []
      var finalValues: [NSValue] = []

      self.spring = spring.spring
      self.friction = spring.friction
      self.mass = spring.mass
      self.tolerance = spring.tolerance

      springEnded = false
      springTiming = 0

      for (index, element) in initialArray.enumerated() {
        distances.append(finalArray[index] - element)
        increments.append(abs(distances[index]) * tolerance)
        proposedValues.append(0)
        stepValues.append(0)
      }

      while !springEnded {
        springEnded = true
        for (index, element) in initialArray.enumerated() {
          guard element != 0 else { continue }
          proposedValues[index] = initialArray[index] + (distances[index] - springPosition(distances[index], time: springTiming, from: element))

          if type == .bounce && proposedValues[index] >= finalArray[index] {
            proposedValues[index] = (finalArray[index] * 2) - proposedValues[index]
          }

          if springEnded {
            springEnded = springStatusEnded(stepValues[index], proposed: proposedValues[index],
              to: finalArray[index], increment: increments[index])
          }
        }

        guard !springEnded else { break }

        var value = NSValue()
        stepValues = proposedValues

        switch property {
        case .PositionX, .PositionY, .Width, .Height, .CornerRadius, .Opacity:
          value = stepValues[0] as NSValue
        case .Origin:
          value = NSValue(cgPoint: CGPoint(x: stepValues[0], y: stepValues[1]))
        case .Size:
          value = NSValue(cgSize: CGSize(width: stepValues[0], height: stepValues[1]))
        case .Frame:
          value = NSValue(cgRect: CGRect(x: stepValues[0], y: stepValues[1], width: stepValues[2], height: stepValues[3]))
        case .Transform:
          var transform = CATransform3DIdentity
          transform.m11 = stepValues[0]
          transform.m12 = stepValues[1]
          transform.m13 = stepValues[2]
          transform.m14 = stepValues[3]
          transform.m21 = stepValues[4]
          transform.m22 = stepValues[5]
          transform.m23 = stepValues[6]
          transform.m24 = stepValues[7]
          transform.m31 = stepValues[8]
          transform.m32 = stepValues[9]
          transform.m33 = stepValues[10]
          transform.m34 = stepValues[11]
          transform.m41 = stepValues[12]
          transform.m42 = stepValues[13]
          transform.m43 = stepValues[14]
          transform.m44 = stepValues[15]
          value = NSValue(caTransform3D: transform)
        }

        finalValues.append(value)
        springTiming += springAnimationStep
      }

      return finalValues
  }

  fileprivate func springPosition(_ distance: CGFloat, time: CFTimeInterval, from: CGFloat) -> CGFloat {
    let gamma = friction / (2 * mass)
    let angularVelocity = sqrt((spring / mass) - pow(gamma, 2)) * 4
    let position = exp(-gamma * CGFloat(time) * 5) * distance * cos(angularVelocity * CGFloat(time))
    
    return position
  }
  
  fileprivate func springStatusEnded(_ previous: CGFloat, proposed: CGFloat, to: CGFloat, increment: CGFloat) -> Bool {
    return abs(proposed - previous) <= increment && abs(previous - to) <= increment
  }
}
