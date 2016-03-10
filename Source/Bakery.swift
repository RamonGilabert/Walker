import UIKit

public func animate(view: UIView, delay: NSTimeInterval = 0, duration: NSTimeInterval = 0.35,
  curve: Animation.Curve = .Linear, animations: Bake -> Void) -> Bakery {
    animations(animate([view], delay, duration, curve)[0])

    Bakery.animate()

    return Bakery.bakery
}

public func animate(firstView: UIView, _ secondView: UIView,
  delay: NSTimeInterval = 0, duration: NSTimeInterval = 0.35, curve: Animation.Curve = .Linear,
  animations: (Bake, Bake) -> Void) -> Bakery {
    let bake = animate([firstView, secondView], delay, duration, curve)
    animations(bake[0], bake[1])

    Bakery.animate()

    return Bakery.bakery
}

public func animate(firstView: UIView, _ secondView: UIView, _ thirdView: UIView,
  delay: NSTimeInterval = 0, duration: NSTimeInterval = 0.35, curve: Animation.Curve = .Linear,
  animations: (Bake, Bake, Bake) -> Void) -> Bakery {
    let bake = animate([firstView, secondView, thirdView], delay, duration, curve)
    animations(bake[0], bake[1], bake[2])

    Bakery.animate()

    return Bakery.bakery
}

public func animate(firstView: UIView, _ secondView: UIView, _ thirdView: UIView,
  _ fourthView: UIView, duration: NSTimeInterval = 0.35,
  delay: NSTimeInterval = 0, curve: Animation.Curve = .Linear, animations: (Bake, Bake, Bake, Bake) -> Void) -> Bakery {
    let bake = animate([firstView, secondView, thirdView, fourthView], delay, duration, curve)
    animations(bake[0], bake[1], bake[2], bake[3])

    Bakery.animate()

    return Bakery.bakery
}

public func spring(view: UIView, spring: CGFloat, friction: CGFloat,
  mass: CGFloat, tolerance: CGFloat = 0.0001, animations: Bake -> Void) -> Bakery {

    return Bakery.bakery
}

private func animate(views: [UIView], _ delay: NSTimeInterval, _ duration: NSTimeInterval, _ curve: Animation.Curve) -> [Bake] {
  var bakes: [Bake] = []
  views.forEach {
    bakes.append(Bake(view: $0, duration: duration, curve: curve))
  }

  Bakery.delays.append(delay)
  Bakery.bakes = [bakes]

  return bakes
}

public class Bakery: NSObject {

  static let bakery = Bakery()
  private static var bakes: [[Bake]] = [[]]
  private static var delays: [NSTimeInterval] = []
  private var closures: [(() -> Void)?] = []
  private var final: (() -> Void)?

  public func chain(delay delay: NSTimeInterval = 0, duration: NSTimeInterval = 0.5,
    curve: Animation.Curve = .Linear, animations: Bake -> Void) -> Bakery {
      animations(chain(1, delay, duration, curve)[0])

      return Bakery.bakery
  }

  public func chain(delay2 delay: NSTimeInterval = 0, duration: NSTimeInterval = 0.5,
    curve: Animation.Curve = .Linear, animations: (Bake, Bake) -> Void) -> Bakery {
      let bakes = chain(2, delay, duration, curve)
      animations(bakes[0], bakes[1])

      return Bakery.bakery
  }

  public func chain(delay3 delay: NSTimeInterval = 0, duration: NSTimeInterval = 0.5,
    curve: Animation.Curve = .Linear, animations: (Bake, Bake, Bake) -> Void) -> Bakery {
      let bakes = chain(3, delay, duration, curve)
      animations(bakes[0], bakes[1], bakes[2])

      return Bakery.bakery
  }

  public func chain(delay4 delay: NSTimeInterval = 0, duration: NSTimeInterval = 0.5,
    curve: Animation.Curve = .Linear, animations: (Bake, Bake, Bake, Bake) -> Void) -> Bakery {
      let bakes = chain(4, delay, duration, curve)
      animations(bakes[0], bakes[1], bakes[2], bakes[3])

      return Bakery.bakery
  }

  private func chain(value: Int, _ delay: NSTimeInterval, _ duration: NSTimeInterval, _ curve: Animation.Curve) -> [Bake] {
    var bakes: [Bake] = []
    for index in 0..<value {
      let bake = Bake(view: Bakery.bakes[0][index].view, duration: duration, curve: curve)
      bakes.append(bake)
    }

    Bakery.delays.append(delay)
    Bakery.bakes.append(bakes)

    closures.append(nil)

    return bakes
  }

  public func then(closure: () -> Void) -> Bakery {
    closures.append(closure)
    return Bakery.bakery
  }

  public func finally(closure: () -> Void) {
    final = closure
  }

  // MARK: - Animate

  static func animate() {
    guard let delay = Bakery.delays.first else { return }

    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
    dispatch_after(time, dispatch_get_main_queue()) {
      guard let bake = Bakery.bakes.first else { return }

      for (_, bake) in bake.enumerate() {
        guard let presentedLayer = bake.view.layer.presentationLayer() as? CALayer else { return }

        for (index, animation) in bake.animations.enumerate() {
          let property = bake.properties[index]

          animation.values?.insert(Animation.propertyValue(property, layer: presentedLayer), atIndex: 0)

          bake.view.layer.addAnimation(animation, forKey: "animation-\(index)")
        }
      }
    }
  }

  // MARK: - Finish animation

  public override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
    guard var group = Bakery.bakes.first, let animation = anim as? CAKeyframeAnimation else { return }

    var index = 0
    var animationIndex = 0
    for (position, bake) in group.enumerate() {
      for (animationPosition, _) in bake.animations.enumerate()
        where bake.view.layer.animationForKey("animation-\(animationPosition)") == animation {

        index = position
        animationIndex = animationPosition
      }
    }

    let bake = group[index]

    guard let layer = bake.view.layer.presentationLayer() as? CALayer else { return }

    bake.view.layer.position = layer.position
    bake.view.layer.transform = layer.transform
    bake.view.layer.cornerRadius = layer.cornerRadius
    bake.view.layer.removeAnimationForKey("animation-\(animationIndex)")
    bake.animations.removeAtIndex(animationIndex)
    bake.properties.removeAtIndex(animationIndex)

    if bake.animations.isEmpty {
      group.removeAtIndex(index)

      Bakery.bakes[0] = group
    }

    if group.isEmpty {
      Bakery.bakes.removeFirst()
      Bakery.delays.removeFirst()
      Bakery.animate()

      if let firstClosure = closures.first, closure = firstClosure {
        closure()
        closures.removeFirst()
      } else if !closures.isEmpty {
        closures.removeFirst()
      }
    }

    if let final = final where Bakery.bakes.isEmpty {
      final()
    }
  }
}

public class Bake {

  public var alpha: CGFloat {
    didSet { alpha(alpha) }
  }

  public var x: CGFloat {
    didSet { x(x) }
  }

  public var y: CGFloat {
    didSet { y(y) }
  }

  public var width: CGFloat {
    didSet { width(width) }
  }

  public var height: CGFloat {
    didSet { height(height) }
  }

  public var origin: CGPoint {
    didSet { origin(origin.x, origin.y) }
  }

  public var size: CGSize {
    didSet { size(size.width, size.height) }
  }

  public var frame: CGRect {
    didSet { frame(frame.origin.x, frame.origin.y, frame.width, frame.height) }
  }

  public var radius: CGFloat {
    didSet { radius(radius) }
  }

  public var transform: CGAffineTransform {
    didSet { transform(transform) }
  }

  public func alpha(value: CGFloat) {
    animate(.Opacity, value)
  }

  public func x(value: CGFloat) {
    animate(.PositionX, value + view.frame.width / 2)
  }

  public func y(value: CGFloat) {
    animate(.PositionY, value + view.frame.height / 2)
  }

  public func width(value: CGFloat) {
    animate(.Width, value)
  }

  public func height(value: CGFloat) {
    animate(.Height, value)
  }

  public func origin(x: CGFloat, _ y: CGFloat) {
    animate(.Origin, NSValue(CGPoint: CGPoint(x: x + view.frame.width / 2, y: y + view.frame.height / 2)))
  }

  public func size(width: CGFloat, _ height: CGFloat) {
    animate(.Size, NSValue(CGSize: CGSize(width: width, height: height)))
  }

  public func frame(x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
    animate(.Frame, NSValue(CGRect: CGRect(x: x, y: y, width: width, height: height)))
  }

  public func radius(value: CGFloat) {
    animate(.CornerRadius, value)
  }

  public func transform(value: CGAffineTransform) {
    animate(.Transform, NSValue(CATransform3D: CATransform3DMakeAffineTransform(value)))
  }

  internal let view: UIView
  internal let duration: NSTimeInterval
  internal let curve: Animation.Curve
  var animations: [CAKeyframeAnimation] = []
  var properties: [Animation.Property] = []

  init(view: UIView, duration: NSTimeInterval, curve: Animation.Curve) {
    self.view = view
    self.duration = duration
    self.curve = curve
    self.alpha = view.alpha
    self.x = view.frame.origin.x
    self.y = view.frame.origin.y
    self.width = view.frame.width
    self.height = view.frame.height
    self.origin = view.frame.origin
    self.size = view.frame.size
    self.frame = view.frame
    self.radius = view.layer.cornerRadius
    self.transform = view.transform
  }

  private func animate(property: Animation.Property, _ value: NSValue) {
    let animation = Baker.bezier(property, bezierPoints: Animation.points(curve), duration: duration)
    animation.values = [value]

    animations.append(animation)
    properties.append(property)
  }
}
