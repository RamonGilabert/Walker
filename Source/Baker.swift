import Foundation

struct Baker {

  static var velocity: CGFloat = 0

  static func animate(curve: Animation.Curve, duration: NSTimeInterval, finalValue: CGFloat) -> CAAnimation {
    let animation = CAAnimation()
    return animation
  }

  // MARK: - CubicBezier

  // MARK: - Spring
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
