import UIKit

public func spring(view: UIView, delay: NSTimeInterval = 0, spring: CGFloat, friction: CGFloat,
  mass: CGFloat, tolerance: CGFloat = 0.0001, animations: Bake -> Void) -> Bakery {

    let bake = Bake(view: view, spring: spring, friction: friction, mass: mass, tolerance: tolerance)
    animations(bake)

    Bakery.delays.append(delay)
    Bakery.bakes = [[bake]]
    Bakery.animate()

    return Bakery.bakery
}

public func spring(view: UIView, delay: NSTimeInterval = 0, spring: CGFloat, friction: CGFloat,
  mass: CGFloat, tolerance: CGFloat = 0.0001, animations: (Bake, Bake) -> Void) -> Bakery {

    let bake = Bake(view: view, spring: spring, friction: friction, mass: mass, tolerance: tolerance)
    animations(bake, bake)

    Bakery.delays.append(delay)
    Bakery.bakes = [[bake, bake]]
    Bakery.animate()

    return Bakery.bakery
}

public func spring(view: UIView, delay: NSTimeInterval = 0, spring: CGFloat, friction: CGFloat,
  mass: CGFloat, tolerance: CGFloat = 0.0001, animations: (Bake, Bake, Bake) -> Void) -> Bakery {

    let bake = Bake(view: view, spring: spring, friction: friction, mass: mass, tolerance: tolerance)
    animations(bake, bake, bake)

    Bakery.delays.append(delay)
    Bakery.bakes = [[bake, bake, bake]]
    Bakery.animate()

    return Bakery.bakery
}
