import UIKit

/**
 Animation starts a series of blocks of animations, it can have multiple parameters.

 - Parameter delay: The delay that this chain should wait to be triggered.
 - Parameter duration: The duration of the animation block.
 - Parameter curve: A curve from the Animation.Curve series, it defaults to .Linear.

 - Returns: A series of bakes that you can configure with all the animatable properties.
 */
public func animate(view: UIView, delay: NSTimeInterval = 0, duration: NSTimeInterval = 0.35,
  curve: Animation.Curve = .Linear, animations: Bake -> Void) -> Bakery {
    let builder = constructor([view], delay, duration, curve)
    animations(builder.bake[0])

    validate(builder.bakery)

    return builder.bakery
}

/**
 Animation starts a series of blocks of animations, it can have multiple parameters.

 - Parameter delay: The delay that this chain should wait to be triggered.
 - Parameter duration: The duration of the animation block.
 - Parameter curve: A curve from the Animation.Curve series, it defaults to .Linear.

 - Returns: A series of bakes that you can configure with all the animatable properties.
 */
public func animate(firstView: UIView, _ secondView: UIView,
  delay: NSTimeInterval = 0, duration: NSTimeInterval = 0.35, curve: Animation.Curve = .Linear,
  animations: (Bake, Bake) -> Void) -> Bakery {

    let builder = constructor([firstView, secondView], delay, duration, curve)
    animations(builder.bake[0], builder.bake[1])

    validate(builder.bakery)

    return builder.bakery
}

/**
 Animation starts a series of blocks of animations, it can have multiple parameters.

 - Parameter delay: The delay that this chain should wait to be triggered.
 - Parameter duration: The duration of the animation block.
 - Parameter curve: A curve from the Animation.Curve series, it defaults to .Linear.

 - Returns: A series of bakes that you can configure with all the animatable properties.
 */
public func animate(firstView: UIView, _ secondView: UIView, _ thirdView: UIView,
  delay: NSTimeInterval = 0, duration: NSTimeInterval = 0.35, curve: Animation.Curve = .Linear,
  animations: (Bake, Bake, Bake) -> Void) -> Bakery {

    let builder = constructor([firstView, secondView, thirdView], delay, duration, curve)
    animations(builder.bake[0], builder.bake[1], builder.bake[2])

    validate(builder.bakery)

    return builder.bakery
}

/**
 Animation starts a series of blocks of animations, it can have multiple parameters.

 - Parameter delay: The delay that this chain should wait to be triggered.
 - Parameter duration: The duration of the animation block.
 - Parameter curve: A curve from the Animation.Curve series, it defaults to .Linear.

 - Returns: A series of bakes that you can configure with all the animatable properties.
 */
public func animate(firstView: UIView, _ secondView: UIView, _ thirdView: UIView,
  _ fourthView: UIView, duration: NSTimeInterval = 0.35,
  delay: NSTimeInterval = 0, curve: Animation.Curve = .Linear,
  animations: (Bake, Bake, Bake, Bake) -> Void) -> Bakery {

    let builder = constructor([firstView, secondView, thirdView, fourthView], delay, duration, curve)
    animations(builder.bake[0], builder.bake[1], builder.bake[2], builder.bake[3])

    validate(builder.bakery)

    return builder.bakery
}

// MARK: - Private helpers

private func constructor(views: [UIView], _ delay: NSTimeInterval,
  _ duration: NSTimeInterval, _ curve: Animation.Curve) -> (bake: [Bake], bakery: Bakery) {

    let bakery = Bakery()
    var bakes: [Bake] = []

    views.forEach {
      bakes.append(Bake(bakery: bakery, view: $0, duration: duration, curve: curve))
    }

    bakery.delays.append(delay)
    bakery.bakes = [bakes]
    
    return (bake: bakes, bakery: bakery)
}

private func validate(bakery: Bakery) {

  var shouldProceed = true
  bakeries.forEach {
    if let bakes = $0.bakes.first, bake = bakes.first where bake.finalValues.isEmpty {
      shouldProceed = false
      return
    }
  }

  bakery.shouldProceed = shouldProceed

  if shouldProceed {
    bakeries.append(bakery)
    bakery.animate()
  }
}