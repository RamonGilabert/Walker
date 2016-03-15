import UIKit

var distilleries: [Distillery] = []

public func closeDistilleries() {

  distilleries.forEach { $0.ingredients.forEach { $0.forEach { $0.view.layer.removeAllAnimations() } } }
  distilleries.removeAll()
}

public class Distillery: NSObject {

  var ingredients: [[Ingredient]] = [[]]
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
      guard let ingredient = self.ingredients.first else { return }

      for (_, ingredient) in ingredient.enumerate() {
        guard let presentedLayer = ingredient.view.layer.presentationLayer() as? CALayer else { return }

        for (index, animation) in ingredient.animations.enumerate() {
          let property = ingredient.properties[index]

          if ingredient.kind == .Bezier {
            animation.values?.insert(Animation.propertyValue(property, layer: presentedLayer), atIndex: 0)
          } else if let value = ingredient.finalValues.first, spring = ingredient.springs.first {
            let distill = Distill()
            
            animation.values = distill.calculateSpring(property, finalValue: value,
              layer: presentedLayer, type: ingredient.calculation, spring: spring)
            animation.duration = distill.springTiming

            ingredient.springs.removeFirst()
          }

          if !ingredient.finalValues.isEmpty { ingredient.finalValues.removeFirst() }
          ingredient.view.layer.addAnimation(animation, forKey: "animation-\(index)-\(self.description)")
        }
      }
    }
  }

  // MARK: - Finish animation

  public override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
    guard var group = ingredients.first, let animation = anim as? CAKeyframeAnimation else { return }

    var index = 0
    var animationIndex = 0
    for (position, ingredient) in group.enumerate() {
      for (animationPosition, _) in ingredient.animations.enumerate()
        where ingredient.view.layer.animationForKey("animation-\(animationPosition)-\(self.description)") == animation {

        index = position
        animationIndex = animationPosition
      }
    }

    let ingredient = group[index]

    guard let layer = ingredient.view.layer.presentationLayer() as? CALayer else { return }

    if ingredient.properties.contains(.Transform) {
      ingredient.view.layer.transform = layer.transform
    }

    if ingredient.properties.contains(.PositionX)
      || ingredient.properties.contains(.PositionY)
      || ingredient.properties.contains(.Origin)
      || ingredient.properties.contains(.Width)
      || ingredient.properties.contains(.Height)
      || ingredient.properties.contains(.Size)
      || ingredient.properties.contains(.Frame) {

        ingredient.view.layer.position = layer.position
        ingredient.view.layer.frame.size = layer.frame.size
    }

    ingredient.view.layer.cornerRadius = layer.cornerRadius
    ingredient.view.layer.opacity = layer.opacity

    ingredient.view.layer.removeAnimationForKey("animation-\(animationIndex)-\(self.description)")
    ingredient.animations.removeAtIndex(animationIndex)
    ingredient.properties.removeAtIndex(animationIndex)

    if ingredient.animations.isEmpty {
      group.removeAtIndex(index)

      ingredients[0] = group
    }

    if group.isEmpty {
      ingredients.removeFirst()
      delays.removeFirst()
      animate()

      if let firstClosure = closures.first, closure = firstClosure {
        closure()
        closures.removeFirst()
      } else if !closures.isEmpty {
        closures.removeFirst()
      }
    }

    if let final = final where ingredients.isEmpty {
      final()
    }

    if let index = distilleries.indexOf(self) where ingredients.isEmpty {
      distilleries.removeAtIndex(index)
    }
  }
}
