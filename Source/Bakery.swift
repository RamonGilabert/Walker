import UIKit

public func animate(view: UIView, duration: NSTimeInterval = 0.35,
  curve: Animation.Curve = .Linear, animations: Bake -> Void) -> Bakery {

    Bakery.bakes = [[Bake(view: view, duration: duration, curve: curve)]]

    animations(Bakery.bakes[0][0])

    Bakery.animate()

    return Bakery.bakery
}

public func animate(firstView: UIView, _ secondView: UIView,
  duration: NSTimeInterval = 0.35, curve: Animation.Curve = .Linear,
  animations: (Bake, Bake) -> Void) -> Bakery {

    Bakery.bakes = [[Bake(view: firstView, duration: duration, curve: curve),
      Bake(view: secondView, duration: duration, curve: curve)]]

    animations(Bakery.bakes[0][0], Bakery.bakes[0][1])

    Bakery.animate()

    return Bakery.bakery
}

public func animate(firstView: UIView, _ secondView: UIView, _ thirdView: UIView,
  duration: NSTimeInterval = 0.35, curve: Animation.Curve = .Linear,
  animations: (Bake, Bake, Bake) -> Void) -> Bakery {

    Bakery.bakes = [[Bake(view: firstView, duration: duration, curve: curve),
      Bake(view: secondView, duration: duration, curve: curve),
      Bake(view: thirdView, duration: duration, curve: curve)]]

    animations(Bakery.bakes[0][0], Bakery.bakes[0][1], Bakery.bakes[0][2])

    Bakery.animate()

    return Bakery.bakery
}

public func animate(firstView: UIView, _ secondView: UIView, _ thirdView: UIView,
  _ fourthView: UIView, duration: NSTimeInterval = 0.35,
  curve: Animation.Curve = .Linear, animations: (Bake, Bake, Bake, Bake) -> Void) -> Bakery {

    Bakery.bakes.forEach { $0.forEach { $0.view.layer.removeAllAnimations() } }
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
  private var closures: [(() -> Void)?] = []
  private var final: (() -> Void)?

  public func chain(duration duration: NSTimeInterval = 0.35,
    curve: Animation.Curve = .Linear, animations: Bake -> Void) -> Bakery {
      let bake = Bake(view: Bakery.bakes[0][0].view, duration: duration, curve: curve)

      Bakery.bakes.append([bake])

      animations(bake)

      closures.append(nil)

      return Bakery.bakery
  }

  public func chain(duration duration: NSTimeInterval = 0.35,
    curve: Animation.Curve = .Linear, animations: (Bake, Bake) -> Void) -> Bakery {
      let firstBake = Bake(view: Bakery.bakes[0][0].view, duration: duration, curve: curve)
      let secondBake = Bake(view: Bakery.bakes[0][1].view, duration: duration, curve: curve)

      Bakery.bakes.append([firstBake, secondBake])

      animations(firstBake, secondBake)

      closures.append(nil)

      return Bakery.bakery
  }

  public func chain(duration duration: NSTimeInterval = 0.35,
    curve: Animation.Curve = .Linear, animations: (Bake, Bake, Bake) -> Void) -> Bakery {
      let firstBake = Bake(view: Bakery.bakes[0][0].view, duration: duration, curve: curve)
      let secondBake = Bake(view: Bakery.bakes[0][1].view, duration: duration, curve: curve)
      let thirdBake = Bake(view: Bakery.bakes[0][2].view, duration: duration, curve: curve)

      Bakery.bakes.append([firstBake, secondBake, thirdBake])

      animations(firstBake, secondBake, thirdBake)

      closures.append(nil)

      return Bakery.bakery
  }

  public func chain(duration duration: NSTimeInterval = 0.35,
    curve: Animation.Curve = .Linear, animations: (Bake, Bake, Bake, Bake) -> Void) -> Bakery {
      let firstBake = Bake(view: Bakery.bakes[0][0].view, duration: duration, curve: curve)
      let secondBake = Bake(view: Bakery.bakes[0][1].view, duration: duration, curve: curve)
      let thirdBake = Bake(view: Bakery.bakes[0][2].view, duration: duration, curve: curve)
      let fourthBake = Bake(view: Bakery.bakes[0][3].view, duration: duration, curve: curve)

      Bakery.bakes.append([firstBake, secondBake, thirdBake, fourthBake])

      animations(firstBake, secondBake, thirdBake, fourthBake)

      closures.append(nil)

      return Bakery.bakery
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

    guard let layer = group[index].view.layer.presentationLayer() as? CALayer else { return }

    group[index].view.layer.position = layer.position
    group[index].view.layer.transform = layer.transform
    group[index].view.layer.cornerRadius = layer.cornerRadius
    group[index].view.layer.removeAnimationForKey("animation-\(animationIndex)")
    group[index].animations.removeAtIndex(animationIndex)
    group[index].properties.removeAtIndex(animationIndex)

    if group[index].animations.isEmpty {
      group.removeAtIndex(index)

      Bakery.bakes[0] = group
    }

    if group.isEmpty {
      Bakery.bakes.removeFirst()
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
  }

  private func animate(property: Animation.Property, _ value: NSValue) {
    let bezierPoints = Animation.bezierPoints(curve)
    let animation = Baker.configureBezierAnimation(property, bezierPoints: bezierPoints, duration: duration)
    animation.values = [value]

    animations.append(animation)
    properties.append(property)
  }
}
