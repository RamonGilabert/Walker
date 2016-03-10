import UIKit

public func spring(view: UIView, delay: NSTimeInterval = 0, spring: CGFloat, friction: CGFloat,
  mass: CGFloat, tolerance: CGFloat = 0.0001, animations: Bake -> Void) -> Bakery {
    animations(constructor([view], delay, spring, friction, mass, tolerance)[0])

    Bakery.animate()

    return Bakery.bakery
}

public func spring(firstView: UIView, _ secondView: UIView,
  delay: NSTimeInterval = 0, spring: CGFloat, friction: CGFloat,
  mass: CGFloat, tolerance: CGFloat = 0.0001, animations: (Bake, Bake) -> Void) -> Bakery {
    let bakes = constructor([firstView, secondView], delay, spring, friction, mass, tolerance)
    animations(bakes[0], bakes[1])

    Bakery.animate()

    return Bakery.bakery
}

public func spring(firstView: UIView, _ secondView: UIView, _ thirdView: UIView,
  delay: NSTimeInterval = 0, spring: CGFloat, friction: CGFloat,
  mass: CGFloat, tolerance: CGFloat = 0.0001, animations: (Bake, Bake, Bake) -> Void) -> Bakery {
    let bakes = constructor([firstView, secondView, thirdView], delay, spring, friction, mass, tolerance)
    animations(bakes[0], bakes[1], bakes[2])

    Bakery.animate()

    return Bakery.bakery
}

private func constructor(views: [UIView], _ delay: NSTimeInterval, _ spring: CGFloat,
  _ friction: CGFloat, _ mass: CGFloat, _ tolerance: CGFloat) -> [Bake] {
    var bakes: [Bake] = []
    views.forEach {
      bakes.append(Bake(view: $0, spring: spring, friction: friction, mass: mass, tolerance: tolerance))
    }

    Bakery.delays.append(delay)
    Bakery.bakes = [bakes]

    return bakes
}
