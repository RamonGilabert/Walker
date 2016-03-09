import UIKit

public func animate(view: UIView, duration: NSTimeInterval = 0.5,
  curve: Animation.Curve = .Linear, animations: (Bake) -> ()) -> Bakery {

    Bakery.bakes = [Bake(view: view, duration: duration, curve: curve)]

    animations(Bakery.bakes[0])

    Bakery.animate()

    return Bakery.bakery
}

public func animate(firstView: UIView, _ secondView: UIView,
  duration: NSTimeInterval = 0.5, curve: Animation.Curve = .Linear,
  animations: (Bake, Bake) -> ()) -> Bakery {

    Bakery.bakes = [Bake(view: firstView, duration: duration, curve: curve),
      Bake(view: secondView, duration: duration, curve: curve)]

    animations(Bakery.bakes[0], Bakery.bakes[1])

    Bakery.animate()

    return Bakery.bakery
}

public func animate(firstView: UIView, _ secondView: UIView, _ thirdView: UIView,
  duration: NSTimeInterval = 0.5, curve: Animation.Curve = .Linear,
  animations: (Bake, Bake, Bake) -> ()) -> Bakery {

    Bakery.bakes = [Bake(view: firstView, duration: duration, curve: curve),
      Bake(view: secondView, duration: duration, curve: curve),
      Bake(view: thirdView, duration: duration, curve: curve)]

    animations(Bakery.bakes[0], Bakery.bakes[1], Bakery.bakes[2])

    Bakery.animate()

    return Bakery.bakery
}

public func animate(firstView: UIView, _ secondView: UIView, _ thirdView: UIView,
  _ fourthView: UIView, duration: NSTimeInterval = 0.5,
  curve: Animation.Curve = .Linear, animations: (Bake, Bake, Bake, Bake) -> ()) -> Bakery {

    Bakery.bakes = [Bake(view: firstView, duration: duration, curve: curve),
      Bake(view: secondView, duration: duration, curve: curve),
      Bake(view: thirdView, duration: duration, curve: curve),
      Bake(view: fourthView, duration: duration, curve: curve)]

    animations(Bakery.bakes[0], Bakery.bakes[1], Bakery.bakes[2], Bakery.bakes[3])

    Bakery.animate()

    return Bakery.bakery
}

public class Bakery: NSObject {

  static let bakery = Bakery()
  private static var bakes: [Bake] = []

  public func chain(duration: NSTimeInterval = 0.5,
    curve: Animation.Curve = .Linear, animations: (Bake) -> ()) -> Bakery {

      animations(Bakery.bakes[0])

      return Bakery.bakery
  }

  public func chain(duration: NSTimeInterval = 0.5,
    curve: Animation.Curve = .Linear, animations: (Bake, Bake) -> ()) -> Bakery {
      guard Bakery.bakes.count == 2 else { fatalError("Out of range")  }

      animations(Bakery.bakes[0], Bakery.bakes[1])

      return Bakery.bakery
  }

  public func chain(duration: NSTimeInterval = 0.5,
    curve: Animation.Curve = .Linear, animations: (Bake, Bake, Bake) -> ()) -> Bakery {
      guard Bakery.bakes.count == 3 else { fatalError("Out of range")  }

      animations(Bakery.bakes[0], Bakery.bakes[1], Bakery.bakes[2])

      return Bakery.bakery
  }

  public func chain(duration: NSTimeInterval = 0.5,
    curve: Animation.Curve = .Linear, animations: (Bake, Bake, Bake, Bake) -> ()) -> Bakery {
      guard Bakery.bakes.count == 4 else { fatalError("Out of range") }

      animations(Bakery.bakes[0], Bakery.bakes[1], Bakery.bakes[2], Bakery.bakes[3])

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
    guard let bake = Bakery.bakes.first,
      let view = bake.views.first,
      presentedLayer = view.layer.presentationLayer() as? CALayer,
      animation = bake.animations.first,
      property = bake.properties.first else { return }

    animation.values?.insert(Animation.propertyValue(property, layer: presentedLayer), atIndex: 0)

    view.layer.addAnimation(animation, forKey: "animation")
  }

  // MARK: - Finish animation

  public override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
    guard let bake = Bakery.bakes.first,
      view = bake.views.first,
      layer = view.layer.presentationLayer() as? CALayer else { return }

    bake.view.layer.position = layer.position
    bake.view.layer.removeAnimationForKey("animation")

    bake.animations.removeFirst()
    bake.properties.removeFirst()
    bake.views.removeFirst()

    if bake.animations.isEmpty {
      Bakery.bakes.removeFirst()
    }

    Bakery.animate()
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
  var animations: [CAKeyframeAnimation] = []
  var properties: [Animation.Property] = []
  var views: [UIView] = []

  init(view: UIView, duration: NSTimeInterval, curve: Animation.Curve) {
    self.view = view
    self.duration = duration
    self.curve = curve
  }

  private func animate(property: Animation.Property, _ value: NSValue) {
    let bezierPoints = Animation.bezierPoints(curve)
    let animation = Baker.configureBezierAnimation(property, bezierPoints: bezierPoints, duration: duration)
    animation.values = [value]

    animations.append(animation)
    properties.append(property)
    views.append(view)
  }
}
