import UIKit

extension Bakery {

  public func chain(delay delay: NSTimeInterval = 0, duration: NSTimeInterval = 0.5,
    curve: Animation.Curve = .Linear, animations: Bake -> Void) -> Bakery {
      animations(chain(1, delay, duration, curve)[0])

      return Bakery.bakery
  }

  public func chain(delay: NSTimeInterval = 0, duration: NSTimeInterval = 0.5,
    curve: Animation.Curve = .Linear, animations: (Bake, Bake) -> Void) -> Bakery {
      let bakes = chain(2, delay, duration, curve)
      animations(bakes[0], bakes[1])

      return Bakery.bakery
  }

  public func chain(delay: NSTimeInterval = 0, duration: NSTimeInterval = 0.5,
    curve: Animation.Curve = .Linear, animations: (Bake, Bake, Bake) -> Void) -> Bakery {
      let bakes = chain(3, delay, duration, curve)
      animations(bakes[0], bakes[1], bakes[2])

      return Bakery.bakery
  }

  public func chain(delay: NSTimeInterval = 0, duration: NSTimeInterval = 0.5,
    curve: Animation.Curve = .Linear, animations: (Bake, Bake, Bake, Bake) -> Void) -> Bakery {
      let bakes = chain(4, delay, duration, curve)
      animations(bakes[0], bakes[1], bakes[2], bakes[3])

      return Bakery.bakery
  }

  public func chain(delay delay: NSTimeInterval = 0, spring: CGFloat, friction: CGFloat,
    mass: CGFloat, tolerance: CGFloat = 0.0001, animations: Bake -> Void) -> Bakery {
      animations(chain(2, delay: delay, spring, friction, mass: mass, tolerance: tolerance)[0])

      return Bakery.bakery
  }

  public func chain(delay delay: NSTimeInterval = 0, spring: CGFloat, friction: CGFloat,
    mass: CGFloat, tolerance: CGFloat = 0.0001, animations: (Bake, Bake) -> Void) -> Bakery {
      let bakes = chain(2, delay: delay, spring, friction, mass: mass, tolerance: tolerance)
      animations(bakes[0], bakes[1])

      return Bakery.bakery
  }

  public func chain(delay delay: NSTimeInterval = 0, spring: CGFloat, friction: CGFloat,
    mass: CGFloat, tolerance: CGFloat = 0.0001, animations: (Bake, Bake, Bake) -> Void) -> Bakery {
      let bakes = chain(3, delay: delay, spring, friction, mass: mass, tolerance: tolerance)
      animations(bakes[0], bakes[1], bakes[2])

      return Bakery.bakery
  }

  private func chain(value: Int, _ delay: NSTimeInterval, _ duration: NSTimeInterval, _ curve: Animation.Curve) -> [Bake] {
    var bakes: [Bake] = []
    for index in 0..<value {
      let bake = Bake(view: Bakery.bakes[0][index].view, duration: duration, curve: curve)
      bakes.append(bake)
    }

    Bakery.delays.append(delay)
    Bakery.bakes.append(bakes)

    closures.append(nil)

    return bakes
  }

  private func chain(value: Int, delay: NSTimeInterval, _ spring: CGFloat, _ friction: CGFloat, mass: CGFloat, tolerance: CGFloat) -> [Bake] {
    var bakes: [Bake] = []
    for index in 0..<value {
      let bake = Bake(view: Bakery.bakes[0][index].view, spring: spring, friction: friction, mass: mass, tolerance: tolerance)
      bakes.append(bake)
    }

    Bakery.delays.append(delay)
    Bakery.bakes.append(bakes)
    
    closures.append(nil)
    
    return bakes
  }
}
