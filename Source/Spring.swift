import UIKit

/**
 Spring starts a series of blocks of spring animations, it can have multiple parameters.

 - Parameter delay: The delay that this chain should wait to be triggered.
 - Parameter spring: The value of the spring in the animation.
 - Parameter friction: The value of the friction that the layer will present.
 - Parameter mass: The value of the mass of the layer.
 - Parameter tolerance: The tolerance that will default to 0.0001.

 - Returns: A series of bakes that you can configure with all the animatable properties.
 */
public func spring(view: UIView, delay: NSTimeInterval = 0, spring: CGFloat, friction: CGFloat,
  mass: CGFloat, tolerance: CGFloat = 0.0001, animations: Bake -> Void) -> Bakery {

    let builder = constructor([view], delay, spring, friction, mass, tolerance)
    animations(builder.bakes[0])

    builder.bakery.animate()

    return builder.bakery
}

/**
 Spring starts a series of blocks of spring animations, it can have multiple parameters.

 - Parameter delay: The delay that this chain should wait to be triggered.
 - Parameter spring: The value of the spring in the animation.
 - Parameter friction: The value of the friction that the layer will present.
 - Parameter mass: The value of the mass of the layer.
 - Parameter tolerance: The tolerance that will default to 0.0001.

 - Returns: A series of bakes that you can configure with all the animatable properties.
 */
public func spring(firstView: UIView, _ secondView: UIView,
  delay: NSTimeInterval = 0, spring: CGFloat, friction: CGFloat,
  mass: CGFloat, tolerance: CGFloat = 0.0001, animations: (Bake, Bake) -> Void) -> Bakery {

    let builder = constructor([firstView, secondView], delay, spring, friction, mass, tolerance)
    animations(builder.bakes[0], builder.bakes[1])

    builder.bakery.animate()

    return builder.bakery
}

/**
 Spring starts a series of blocks of spring animations, it can have multiple parameters.

 - Parameter delay: The delay that this chain should wait to be triggered.
 - Parameter spring: The value of the spring in the animation.
 - Parameter friction: The value of the friction that the layer will present.
 - Parameter mass: The value of the mass of the layer.
 - Parameter tolerance: The tolerance that will default to 0.0001.

 - Returns: A series of bakes that you can configure with all the animatable properties.
 */
public func spring(firstView: UIView, _ secondView: UIView, _ thirdView: UIView,
  delay: NSTimeInterval = 0, spring: CGFloat, friction: CGFloat,
  mass: CGFloat, tolerance: CGFloat = 0.0001, animations: (Bake, Bake, Bake) -> Void) -> Bakery {

    let builder = constructor([firstView, secondView, thirdView], delay, spring, friction, mass, tolerance)
    animations(builder.bakes[0], builder.bakes[1], builder.bakes[2])

    builder.bakery.animate()

    return builder.bakery
}

private func constructor(views: [UIView], _ delay: NSTimeInterval, _ spring: CGFloat,
  _ friction: CGFloat, _ mass: CGFloat, _ tolerance: CGFloat) -> (bakes: [Bake], bakery: Bakery) {
    let bakery = Bakery()
    var bakes: [Bake] = []

    views.forEach {
      bakes.append(Bake(bakery: bakery, view: $0, spring: spring,
        friction: friction, mass: mass, tolerance: tolerance))
    }

    bakery.delays.append(delay)
    bakery.bakes = [bakes]
    bakeries.append(bakery)

    return (bakes: bakes, bakery: bakery)
}
