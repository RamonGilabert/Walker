import UIKit

var distilleries: [Distillery] = []

public func closeDistilleries() {

  distilleries.forEach { $0.bakes.forEach { $0.forEach { $0.view.layer.removeAllAnimations() } } }
}

public class Distillery: NSObject {

  var bakes: [[Ingredient]] = [[]]
  var delays: [NSTimeInterval] = []
  var closures: [(() -> Void)?] = []
  var final: (() -> Void)?
  var shouldProceed = true

  /**
   Then gets called when the animation block above has ended.
   */
  public func then(closure: () -> Void) -> Distillery {
    closures.append(closure)

    return self
  }

  /**
   Finally is the last method that gets called when the chain of animations is done.
   */
  public func finally(closure: () -> Void) {
    final = closure
  }

  // MARK: - Animate

  func animate() {
    guard let delay = delays.first else { return }

    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
    dispatch_after(time, dispatch_get_main_queue()) {
      guard let bake = self.bakes.first else { return }

      for (_, bake) in bake.enumerate() {
        guard let presentedLayer = bake.view.layer.presentationLayer() as? CALayer else { return }

        for (index, animation) in bake.animations.enumerate() {
          let property = bake.properties[index]

          if bake.kind == .Bezier {
            animation.values?.insert(Animation.propertyValue(property, layer: presentedLayer), atIndex: 0)
          } else if let value = bake.finalValues.first {
            animation.values = Distill.calculateSpring(property, finalValue: value, layer: presentedLayer, type: bake.calculation)
            animation.duration = Distill.springTiming
          }

          if !bake.finalValues.isEmpty { bake.finalValues.removeFirst() }
          bake.view.layer.addAnimation(animation, forKey: "animation-\(index)-\(self.description)")
        }
      }
    }
  }

  // MARK: - Finish animation

  public override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
    guard var group = bakes.first, let animation = anim as? CAKeyframeAnimation else { return }

    var index = 0
    var animationIndex = 0
    for (position, bake) in group.enumerate() {
      for (animationPosition, _) in bake.animations.enumerate()
        where bake.view.layer.animationForKey("animation-\(animationPosition)-\(self.description)") == animation {

        index = position
        animationIndex = animationPosition
      }
    }

    let bake = group[index]

    guard let layer = bake.view.layer.presentationLayer() as? CALayer else { return }

    bake.view.layer.position = layer.position
    bake.view.layer.frame.size = layer.frame.size
    bake.view.layer.transform = layer.transform
    bake.view.layer.cornerRadius = layer.cornerRadius
    bake.view.layer.removeAnimationForKey("animation-\(animationIndex)-\(self.description)")
    bake.animations.removeAtIndex(animationIndex)
    bake.properties.removeAtIndex(animationIndex)

    if bake.animations.isEmpty {
      group.removeAtIndex(index)

      bakes[0] = group
    }

    if group.isEmpty {
      bakes.removeFirst()
      delays.removeFirst()
      animate()

      if let firstClosure = closures.first, closure = firstClosure {
        closure()
        closures.removeFirst()
      } else if !closures.isEmpty {
        closures.removeFirst()
      }
    }

    if let final = final where bakes.isEmpty {
      final()
    }

    if let index = distilleries.indexOf(self) where bakes.isEmpty {
      distilleries.removeAtIndex(index)
    }
  }
}
