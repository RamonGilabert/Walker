import UIKit

/**
 Animation starts a series of blocks of animations, it can have multiple parameters.

 - Parameter delay: The delay that this chain should wait to be triggered.
 - Parameter duration: The duration of the animation block.
 - Parameter curve: A curve from the Animation.Curve series, it defaults to .Linear.
 - Parameter options: A set of options, for now .Reverse or .Repeat.

 - Returns: A series of ingredients that you can configure with all the animatable properties.
 */
@discardableResult public func animate(_ view: UIView, delay: TimeInterval = 0, duration: TimeInterval = 0.35,
  curve: Animation.Curve = .linear,
  options: [Animation.Options] = [],
  animations: (Ingredient) -> Void) -> Distillery {

    let builder = constructor([view], delay, duration, curve, options)
    animations(builder.ingredient[0])

    validate(builder.distillery)

    return builder.distillery
}

/**
 Animation starts a series of blocks of animations, it can have multiple parameters.

 - Parameter delay: The delay that this chain should wait to be triggered.
 - Parameter duration: The duration of the animation block.
 - Parameter curve: A curve from the Animation.Curve series, it defaults to .Linear.
 - Parameter options: A set of options, for now .Reverse or .Repeat.

 - Returns: A series of ingredients that you can configure with all the animatable properties.
 */
@discardableResult public func animate(_ firstView: UIView, _ secondView: UIView,
  delay: TimeInterval = 0, duration: TimeInterval = 0.35,
  curve: Animation.Curve = .linear, options: [Animation.Options] = [],
  animations: (Ingredient, Ingredient) -> Void) -> Distillery {

    let builder = constructor([firstView, secondView], delay, duration, curve, options)
    animations(builder.ingredient[0], builder.ingredient[1])

    validate(builder.distillery)

    return builder.distillery
}

/**
 Animation starts a series of blocks of animations, it can have multiple parameters.

 - Parameter delay: The delay that this chain should wait to be triggered.
 - Parameter duration: The duration of the animation block.
 - Parameter curve: A curve from the Animation.Curve series, it defaults to .Linear.
 - Parameter options: A set of options, for now .Reverse or .Repeat.

 - Returns: A series of ingredients that you can configure with all the animatable properties.
 */
@discardableResult public func animate(_ firstView: UIView, _ secondView: UIView, _ thirdView: UIView,
  delay: TimeInterval = 0, duration: TimeInterval = 0.35,
  curve: Animation.Curve = .linear, options: [Animation.Options] = [],
  animations: (Ingredient, Ingredient, Ingredient) -> Void) -> Distillery {

    let builder = constructor([firstView, secondView, thirdView], delay, duration, curve, options)
    animations(builder.ingredient[0], builder.ingredient[1], builder.ingredient[2])

    validate(builder.distillery)

    return builder.distillery
}

/**
 Animation starts a series of blocks of animations, it can have multiple parameters.

 - Parameter delay: The delay that this chain should wait to be triggered.
 - Parameter duration: The duration of the animation block.
 - Parameter curve: A curve from the Animation.Curve series, it defaults to .Linear.
 - Parameter options: A set of options, for now .Reverse or .Repeat.

 - Returns: A series of ingredients that you can configure with all the animatable properties.
 */
@discardableResult public func animate(_ firstView: UIView, _ secondView: UIView, _ thirdView: UIView,
  _ fourthView: UIView, duration: TimeInterval = 0.35,
  delay: TimeInterval = 0, curve: Animation.Curve = .linear, options: [Animation.Options] = [],
  animations: (Ingredient, Ingredient, Ingredient, Ingredient) -> Void) -> Distillery {

    let builder = constructor([firstView, secondView, thirdView, fourthView], delay, duration, curve, options)
    animations(builder.ingredient[0], builder.ingredient[1], builder.ingredient[2], builder.ingredient[3])

    validate(builder.distillery)

    return builder.distillery
}

// MARK: - Private helpers

private func constructor(_ views: [UIView], _ delay: TimeInterval,
  _ duration: TimeInterval, _ curve: Animation.Curve, _ options: [Animation.Options]) -> (ingredient: [Ingredient], distillery: Distillery) {

    let distillery = Distillery()
    var ingredients: [Ingredient] = []

    views.forEach {
      ingredients.append(Ingredient(distillery: distillery, view: $0, duration: duration, curve: curve, options: options))
    }

    distillery.delays.append(delay)
    distillery.ingredients = [ingredients]
    
    return (ingredient: ingredients, distillery: distillery)
}

private func validate(_ distillery: Distillery) {
  var shouldProceed = true
  distilleries.forEach {
    if let ingredients = $0.ingredients.first, let ingredient = ingredients.first , ingredient.finalValues.isEmpty {
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
