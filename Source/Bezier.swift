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
    animations(constructor([view], delay, duration, curve)[0])

    Bakery.animate()

    return Bakery.bakery
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
    let bake = constructor([firstView, secondView], delay, duration, curve)
    animations(bake[0], bake[1])

    Bakery.animate()

    return Bakery.bakery
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
    let bake = constructor([firstView, secondView, thirdView], delay, duration, curve)
    animations(bake[0], bake[1], bake[2])

    Bakery.animate()

    return Bakery.bakery
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
  delay: NSTimeInterval = 0, curve: Animation.Curve = .Linear, animations: (Bake, Bake, Bake, Bake) -> Void) -> Bakery {
    let bake = constructor([firstView, secondView, thirdView, fourthView], delay, duration, curve)
    animations(bake[0], bake[1], bake[2], bake[3])

    Bakery.animate()

    return Bakery.bakery
}

private func constructor(views: [UIView], _ delay: NSTimeInterval,
  _ duration: NSTimeInterval, _ curve: Animation.Curve) -> [Bake] {
    var bakes: [Bake] = []
    views.forEach {
      bakes.append(Bake(view: $0, duration: duration, curve: curve))
    }

    Bakery.delays.append(delay)
    Bakery.bakes = [bakes]
    
    return bakes
}