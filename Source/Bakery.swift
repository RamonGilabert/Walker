import UIKit

public func animate(view: UIView, duration: NSTimeInterval = 0.5,
  curve: Animation.Curve = .Linear, animations: (Bake) -> ()) -> Bakery {

    Bakery.bakes = [[Bake(view: view, duration: duration, curve: curve)]]

    animations(Bakery.bakes[0][0])

    Bakery.animate()

    return Bakery.bakery
}

public func animate(firstView: UIView, _ secondView: UIView,
  duration: NSTimeInterval = 0.5, curve: Animation.Curve = .Linear,
  animations: (Bake, Bake) -> ()) -> Bakery {

    Bakery.bakes = [[Bake(view: firstView, duration: duration, curve: curve),
      Bake(view: secondView, duration: duration, curve: curve)]]

    animations(Bakery.bakes[0][0], Bakery.bakes[0][1])

    Bakery.animate()

    return Bakery.bakery
}

public func animate(firstView: UIView, _ secondView: UIView, _ thirdView: UIView,
  duration: NSTimeInterval = 0.5, curve: Animation.Curve = .Linear,
  animations: (Bake, Bake, Bake) -> ()) -> Bakery {

    Bakery.bakes = [[Bake(view: firstView, duration: duration, curve: curve),
      Bake(view: secondView, duration: duration, curve: curve),
      Bake(view: thirdView, duration: duration, curve: curve)]]

    animations(Bakery.bakes[0][0], Bakery.bakes[0][1], Bakery.bakes[0][2])

    Bakery.animate()

    return Bakery.bakery
}

public func animate(firstView: UIView, _ secondView: UIView, _ thirdView: UIView,
  _ fourthView: UIView, duration: NSTimeInterval = 0.5,
  curve: Animation.Curve = .Linear, animations: (Bake, Bake, Bake, Bake) -> ()) -> Bakery {

    Bakery.bakes = [[Bake(view: firstView, duration: duration, curve: curve),
      Bake(view: secondView, duration: duration, curve: curve),
      Bake(view: thirdView, duration: duration, curve: curve),
      Bake(view: fourthView, duration: duration, curve: curve)]]

    animations(Bakery.bakes[0][0], Bakery.bakes[0][1], Bakery.bakes[0][2], Bakery.bakes[0][3])

    Bakery.animate()

    return Bakery.bakery
}

public class Bakery: NSObject {

  static let bakery = Bakery()
  private static var bakes: [[Bake]] = [[]]

  public func chain(duration: NSTimeInterval = 0.5,
    curve: Animation.Curve = .Linear, animations: (Bake) -> ()) -> Bakery {

      let bake = Bake(view: Bakery.bakes[0][0].view, duration: duration, curve: curve)

      Bakery.bakes.append([bake])

      animations(bake)

      return Bakery.bakery
  }

  public func chain(duration: NSTimeInterval = 0.5,
    curve: Animation.Curve = .Linear, animations: (Bake, Bake) -> ()) -> Bakery {
      let firstBake = Bake(view: Bakery.bakes[0][0].view, duration: duration, curve: curve)
      let secondBake = Bake(view: Bakery.bakes[0][1].view, duration: duration, curve: curve)

      Bakery.bakes.append([firstBake, secondBake])

      animations(firstBake, secondBake)

      return Bakery.bakery
  }

  public func chain(duration: NSTimeInterval = 0.5,
    curve: Animation.Curve = .Linear, animations: (Bake, Bake, Bake) -> ()) -> Bakery {
      let firstBake = Bake(view: Bakery.bakes[0][0].view, duration: duration, curve: curve)
      let secondBake = Bake(view: Bakery.bakes[0][1].view, duration: duration, curve: curve)
      let thirdBake = Bake(view: Bakery.bakes[0][2].view, duration: duration, curve: curve)

      Bakery.bakes.append([firstBake, secondBake, thirdBake])

      animations(firstBake, secondBake, thirdBake)

      return Bakery.bakery
  }

  public func chain(duration: NSTimeInterval = 0.5,
    curve: Animation.Curve = .Linear, animations: (Bake, Bake, Bake, Bake) -> ()) -> Bakery {
      let firstBake = Bake(view: Bakery.bakes[0][0].view, duration: duration, curve: curve)
      let secondBake = Bake(view: Bakery.bakes[0][1].view, duration: duration, curve: curve)
      let thirdBake = Bake(view: Bakery.bakes[0][2].view, duration: duration, curve: curve)
      let fourthBake = Bake(view: Bakery.bakes[0][3].view, duration: duration, curve: curve)

      Bakery.bakes.append([firstBake, secondBake, thirdBake, fourthBake])

      animations(firstBake, secondBake, thirdBake, fourthBake)

      return Bakery.bakery
  }

  public func then(closure: () -> ()) -> Bakery {
    closure()

    return Bakery.bakery
  }

  public func finally(closure: () -> ()) {
    closure()
  }

  // MARK: - Animate

  static func animate() {
    guard let bake = Bakery.bakes.first else { return }

    for (_, bake) in bake.enumerate() {
      guard let presentedLayer = bake.view.layer.presentationLayer() as? CALayer,
        animation = bake.animation, property = bake.property else { return }

      animation.values?.insert(Animation.propertyValue(property, layer: presentedLayer), atIndex: 0)

      bake.view.layer.addAnimation(animation, forKey: "animation")
    }
  }

  // MARK: - Finish animation

  public override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
    guard var group = Bakery.bakes.first, let animation = anim as? CAKeyframeAnimation else { return }

    var index = 0
    for (position, bake) in group.enumerate() where bake.view.layer.animationForKey("animation") == animation {
      index = position
    }

    guard let layer = group[index].view.layer.presentationLayer() as? CALayer else { return }

    group[index].view.layer.position = layer.position
    group[index].view.layer.removeAnimationForKey("animation")

    group.removeAtIndex(index)

    Bakery.bakes[0] = group

    if group.isEmpty {
      Bakery.bakes.removeFirst()
      Bakery.animate()
    }
  }
}

public class Bake {

  public func alpha(value: CGFloat) {
    animate(.Opacity, value)
  }

  public func x(value: CGFloat) {
    animate(.PositionX, value)
  }

  public func y(value: CGFloat) {
    animate(.PositionY, value)
  }

  public func width(value: CGFloat) {
    animate(.Width, value)
  }

  public func height(value: CGFloat) {
    animate(.Height, value)
  }

  public func origin(x: CGFloat, _ y: CGFloat) {
    animate(.Origin, NSValue(CGPoint: CGPoint(x: x, y: y)))
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

  public func transform(value: CATransform3D) {
    animate(.Transform, NSValue(CATransform3D: value))
  }

  internal let view: UIView
  internal let duration: NSTimeInterval
  internal let curve: Animation.Curve
  var animation: CAKeyframeAnimation?
  var property: Animation.Property?

  init(view: UIView, duration: NSTimeInterval, curve: Animation.Curve) {
    self.view = view
    self.duration = duration
    self.curve = curve
  }

  private func animate(property: Animation.Property, _ value: NSValue) {
    let bezierPoints = Animation.bezierPoints(curve)
    let animation = Baker.configureBezierAnimation(property, bezierPoints: bezierPoints, duration: duration)
    animation.values = [value]

    self.animation = animation
    self.property = property
  }
}
