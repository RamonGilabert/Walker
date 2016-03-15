import UIKit

/**
 Spring starts a series of blocks of spring animations, it can have multiple parameters.

 - Parameter delay: The delay that this chain should wait to be triggered.
 - Parameter spring: The value of the spring in the animation.
 - Parameter friction: The value of the friction that the layer will present.
 - Parameter mass: The value of the mass of the layer.
 - Parameter tolerance: The tolerance that will default to 0.0001.

 - Returns: A series of ingredients that you can configure with all the animatable properties.
 */
public func spring(view: UIView, delay: NSTimeInterval = 0, spring: CGFloat, friction: CGFloat,
  mass: CGFloat, tolerance: CGFloat = 0.0001, kind: Animation.Spring = .Spring, animations: Ingredient -> Void) -> Distillery {

    let builder = constructor([view], delay, spring, friction, mass, tolerance, kind)
    animations(builder.ingredients[0])

    validate(builder.distillery)

    return builder.distillery
}

/**
 Spring starts a series of blocks of spring animations, it can have multiple parameters.

 - Parameter delay: The delay that this chain should wait to be triggered.
 - Parameter spring: The value of the spring in the animation.
 - Parameter friction: The value of the friction that the layer will present.
 - Parameter mass: The value of the mass of the layer.
 - Parameter tolerance: The tolerance that will default to 0.0001.

 - Returns: A series of ingredients that you can configure with all the animatable properties.
 */
public func spring(firstView: UIView, _ secondView: UIView,
  delay: NSTimeInterval = 0, spring: CGFloat, friction: CGFloat,
  mass: CGFloat, tolerance: CGFloat = 0.0001, kind: Animation.Spring = .Spring, animations: (Ingredient, Ingredient) -> Void) -> Distillery {

    let builder = constructor([firstView, secondView], delay, spring, friction, mass, tolerance, kind)
    animations(builder.ingredients[0], builder.ingredients[1])

    validate(builder.distillery)

    return builder.distillery
}

/**
 Spring starts a series of blocks of spring animations, it can have multiple parameters.

 - Parameter delay: The delay that this chain should wait to be triggered.
 - Parameter spring: The value of the spring in the animation.
 - Parameter friction: The value of the friction that the layer will present.
 - Parameter mass: The value of the mass of the layer.
 - Parameter tolerance: The tolerance that will default to 0.0001.

 - Returns: A series of ingredients that you can configure with all the animatable properties.
 */
public func spring(firstView: UIView, _ secondView: UIView, _ thirdView: UIView,
  delay: NSTimeInterval = 0, spring: CGFloat, friction: CGFloat,
  mass: CGFloat, tolerance: CGFloat = 0.0001, kind: Animation.Spring = .Spring  , animations: (Ingredient, Ingredient, Ingredient) -> Void) -> Distillery {

    let builder = constructor([firstView, secondView, thirdView], delay, spring, friction, mass, tolerance, kind)
    animations(builder.ingredients[0], builder.ingredients[1], builder.ingredients[2])

    validate(builder.distillery)

    return builder.distillery
}

private func constructor(views: [UIView], _ delay: NSTimeInterval, _ spring: CGFloat,
  _ friction: CGFloat, _ mass: CGFloat, _ tolerance: CGFloat, _ calculation: Animation.Spring) -> (ingredients: [Ingredient], distillery: Distillery) {
    let distillery = Distillery()
    var ingredients: [Ingredient] = []

    views.forEach {
      ingredients.append(Ingredient(distillery: distillery, view: $0, spring: spring,
        friction: friction, mass: mass, tolerance: tolerance, calculation: calculation))
    }

    distillery.delays.append(delay)
    distillery.ingredients = [ingredients]

    return (ingredients: ingredients, distillery: distillery)
}

private func validate(distillery: Distillery) {
  closeDistilleries()

  var shouldProceed = true
  distilleries.forEach {
    if let ingredients = $0.ingredients.first, ingredient = ingredients.first where ingredient.finalValues.isEmpty {
      shouldProceed = false
      return
    }
  }

  distillery.shouldProceed = shouldProceed

  if shouldProceed {
    distilleries.append(distillery)
    distillery.animate()
  }
}
