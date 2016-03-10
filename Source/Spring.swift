import UIKit

public func spring(view: UIView, spring: CGFloat, friction: CGFloat,
  mass: CGFloat, tolerance: CGFloat = 0.0001, animations: Bake -> Void) -> Bakery {

    let bake = Bake(view: view, spring: spring, friction: friction, mass: mass, tolerance: tolerance)
    animations(bake)

    Bakery.delays.append(0)
    Bakery.bakes = [[bake]]
    Bakery.animate()

    return Bakery.bakery
}
