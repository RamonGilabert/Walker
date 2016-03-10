import UIKit

public func spring(view: UIView, spring: CGFloat, friction: CGFloat,
  mass: CGFloat, tolerance: CGFloat = 0.0001, animations: Bake -> Void) -> Bakery {

    animations(Bake(view: view, spring: spring, friction: friction, mass: mass, tolerance: tolerance))

    return Bakery.bakery
}
