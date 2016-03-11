import UIKit

/**
 Animation starts a series of blocks of animations, it can have multiple parameters.

 - Parameter delay: The delay that this chain should wait to be triggered.
 - Parameter duration: The duration of the animation block.
 - Parameter curve: A curve from the Animation.Curve series, it defaults to .Linear.
 - Parameter options: A set of options, for now .Reverse or .Repeat.

 - Returns: A series of bakes that you can configure with all the animatable properties.
 */
public func animate(view: UIView, delay: NSTimeInterval = 0, duration: NSTimeInterval = 0.35,
  curve: Animation.Curve = .Linear,
  options: [Animation.Options] = [],
  animations: Ingredient -> Void) -> Distillery {

    let builder = constructor([view], delay, duration, curve, options)
    animations(builder.bake[0])

    validate(builder.distillery)

    return builder.distillery
}

/**
 Animation starts a series of blocks of animations, it can have multiple parameters.

 - Parameter delay: The delay that this chain should wait to be triggered.
 - Parameter duration: The duration of the animation block.
 - Parameter curve: A curve from the Animation.Curve series, it defaults to .Linear.
 - Parameter options: A set of options, for now .Reverse or .Repeat.

 - Returns: A series of bakes that you can configure with all the animatable properties.
 */
public func animate(firstView: UIView, _ secondView: UIView,
  delay: NSTimeInterval = 0, duration: NSTimeInterval = 0.35,
  curve: Animation.Curve = .Linear, options: [Animation.Options] = [],
  animations: (Ingredient, Ingredient) -> Void) -> Distillery {

    let builder = constructor([firstView, secondView], delay, duration, curve, options)
    animations(builder.bake[0], builder.bake[1])

    validate(builder.distillery)

    return builder.distillery
}

/**
 Animation starts a series of blocks of animations, it can have multiple parameters.

 - Parameter delay: The delay that this chain should wait to be triggered.
 - Parameter duration: The duration of the animation block.
 - Parameter curve: A curve from the Animation.Curve series, it defaults to .Linear.
 - Parameter options: A set of options, for now .Reverse or .Repeat.

 - Returns: A series of bakes that you can configure with all the animatable properties.
 */
public func animate(firstView: UIView, _ secondView: UIView, _ thirdView: UIView,
  delay: NSTimeInterval = 0, duration: NSTimeInterval = 0.35,
  curve: Animation.Curve = .Linear, options: [Animation.Options] = [],
  animations: (Ingredient, Ingredient, Ingredient) -> Void) -> Distillery {

    let builder = constructor([firstView, secondView, thirdView], delay, duration, curve, options)
    animations(builder.bake[0], builder.bake[1], builder.bake[2])

    validate(builder.distillery)

    return builder.distillery
}

/**
 Animation starts a series of blocks of animations, it can have multiple parameters.

 - Parameter delay: The delay that this chain should wait to be triggered.
 - Parameter duration: The duration of the animation block.
 - Parameter curve: A curve from the Animation.Curve series, it defaults to .Linear.
 - Parameter options: A set of options, for now .Reverse or .Repeat.

 - Returns: A series of bakes that you can configure with all the animatable properties.
 */
public func animate(firstView: UIView, _ secondView: UIView, _ thirdView: UIView,
  _ fourthView: UIView, duration: NSTimeInterval = 0.35,
  delay: NSTimeInterval = 0, curve: Animation.Curve = .Linear, options: [Animation.Options] = [],
  animations: (Ingredient, Ingredient, Ingredient, Ingredient) -> Void) -> Distillery {

    let builder = constructor([firstView, secondView, thirdView, fourthView], delay, duration, curve, options)
    animations(builder.bake[0], builder.bake[1], builder.bake[2], builder.bake[3])

    validate(builder.distillery)

    return builder.distillery
}

// MARK: - Private helpers

private func constructor(views: [UIView], _ delay: NSTimeInterval,
  _ duration: NSTimeInterval, _ curve: Animation.Curve, _ options: [Animation.Options]) -> (bake: [Ingredient], distillery: Distillery) {

    let distillery = Distillery()
    var bakes: [Ingredient] = []

    views.forEach {
      bakes.append(Ingredient(distillery: distillery, view: $0, duration: duration, curve: curve, options: options))
    }

    distillery.delays.append(delay)
    distillery.bakes = [bakes]
    
    return (bake: bakes, distillery: distillery)
}

private func validate(distillery: Distillery) {

  var shouldProceed = true
  distilleries.forEach {
    if let bakes = $0.bakes.first, bake = bakes.first where bake.finalValues.isEmpty {
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