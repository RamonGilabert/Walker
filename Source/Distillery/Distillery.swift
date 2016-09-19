import UIKit

var distilleries: [Distillery] = []

public func closeDistilleries() {

  distilleries.forEach { $0.ingredients.forEach { $0.forEach { $0.view.layer.removeAllAnimations() } } }
  distilleries.removeAll()
}

open class Distillery: NSObject {

  var ingredients: [[Ingredient]] = [[]]
  var delays: [TimeInterval] = []
  var closures: [(() -> Void)?] = []
  var final: (() -> Void)?
  var shouldProceed = true

  /**
   Then gets called when the animation block above has ended.
   */
  open func then(_ closure: @escaping () -> Void) -> Distillery {
    closures.append(closure)

    return self
  }

  /**
   Finally is the last method that gets called when the chain of animations is done.
   */
  open func finally(_ closure: @escaping () -> Void) {
    final = closure
  }

  // MARK: - Animate

  func animate() {
    guard let delay = delays.first else { return }

    let time = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: time) {
      guard let ingredient = self.ingredients.first else { return }

      for (_, ingredient) in ingredient.enumerated() {
        guard let presentedLayer = ingredient.view.layer.presentation() else { return }

        for (index, animation) in ingredient.animations.enumerated() {
          let property = ingredient.properties[index]

          if ingredient.kind == .bezier {
            animation.values?.insert(Animation.propertyValue(property, layer: presentedLayer), at: 0)
          } else if let value = ingredient.finalValues.first, let spring = ingredient.springs.first {
            let distill = Distill()
            
            animation.values = distill.calculateSpring(property, finalValue: value,
              layer: presentedLayer, type: ingredient.calculation, spring: spring)
            animation.duration = distill.springTiming

            ingredient.springs.removeFirst()
          }

          if !ingredient.finalValues.isEmpty { ingredient.finalValues.removeFirst() }
          ingredient.view.layer.add(animation, forKey: "animation-\(index)-\(self.description)")
        }
      }
    }
  }
}

extension Distillery: CAAnimationDelegate {

  // MARK: - Finish animation

  open func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    guard var group = ingredients.first, let animation = anim as? CAKeyframeAnimation else { return }

    var index = 0
    var animationIndex = 0
    for (position, ingredient) in group.enumerated() {
      for (animationPosition, _) in ingredient.animations.enumerated()
        where ingredient.view.layer.animation(forKey: "animation-\(animationPosition)-\(self.description)") == animation {

          index = position
          animationIndex = animationPosition
      }
    }

    let ingredient = group[index]

    guard let layer = ingredient.view.layer.presentation() else { return }

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

    ingredient.view.layer.removeAnimation(forKey: "animation-\(animationIndex)-\(self.description)")
    ingredient.animations.remove(at: animationIndex)
    ingredient.properties.remove(at: animationIndex)

    if ingredient.animations.isEmpty {
      group.remove(at: index)

      ingredients[0] = group
    }

    if group.isEmpty {
      ingredients.removeFirst()
      delays.removeFirst()
      animate()

      if let firstClosure = closures.first, let closure = firstClosure {
        closure()
        closures.removeFirst()
      } else if !closures.isEmpty {
        closures.removeFirst()
      }
    }

    if let final = final , ingredients.isEmpty {
      final()
    }

    if let index = distilleries.index(of: self) , ingredients.isEmpty {
      distilleries.remove(at: index)
    }
  }
}
