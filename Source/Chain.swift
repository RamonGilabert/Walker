import UIKit

extension Bakery {

  // MARK: - Bezier chains

  /**
  Chain gets executed when the first animate blocks of animations are done.

  - Parameter delay: The delay that this chain should wait to be triggered.
  - Parameter duration: The duration of the animation.
  - Parameter curve: The animation curve.

  - Returns: A series of bakes that you can configure with all the animatable properties.
  */
  public func chain(delay delay: NSTimeInterval = 0, duration: NSTimeInterval = 0.5,
    curve: Animation.Curve = .Linear, animations: Bake -> Void) -> Bakery {
      animations(bezier(1, delay, duration, curve)[0])

      return self
  }

  /**
   Chain gets executed when the first animate blocks of animations are done.

   - Parameter delay: The delay that this chain should wait to be triggered.
   - Parameter duration: The duration of the animation.
   - Parameter curve: The animation curve.

   - Returns: A series of bakes that you can configure with all the animatable properties.
   */
  public func chain(delay: NSTimeInterval = 0, duration: NSTimeInterval = 0.5,
    curve: Animation.Curve = .Linear, animations: (Bake, Bake) -> Void) -> Bakery {
      let bakes = bezier(2, delay, duration, curve)
      animations(bakes[0], bakes[1])

      return self
  }

  /**
   Chain gets executed when the first animate blocks of animations are done.

   - Parameter delay: The delay that this chain should wait to be triggered.
   - Parameter duration: The duration of the animation.
   - Parameter curve: The animation curve.

   - Returns: A series of bakes that you can configure with all the animatable properties.
   */
  public func chain(delay: NSTimeInterval = 0, duration: NSTimeInterval = 0.5,
    curve: Animation.Curve = .Linear, animations: (Bake, Bake, Bake) -> Void) -> Bakery {
      let bakes = bezier(3, delay, duration, curve)
      animations(bakes[0], bakes[1], bakes[2])

      return self
  }

  /**
   Chain gets executed when the first animate blocks of animations are done.

   - Parameter delay: The delay that this chain should wait to be triggered.
   - Parameter duration: The duration of the animation.
   - Parameter curve: The animation curve.

   - Returns: A series of bakes that you can configure with all the animatable properties.
   */
  public func chain(delay: NSTimeInterval = 0, duration: NSTimeInterval = 0.5,
    curve: Animation.Curve = .Linear, animations: (Bake, Bake, Bake, Bake) -> Void) -> Bakery {
      let bakes = bezier(4, delay, duration, curve)
      animations(bakes[0], bakes[1], bakes[2], bakes[3])

      return self
  }

  // MARK: - Spring chains

  /**
  Chain gets executed when the first animate blocks of animations are done.

  - Parameter delay: The delay that this chain should wait to be triggered.
  - Parameter spring: The value of the spring in the animation.
  - Parameter friction: The value of the friction that the layer will present.
  - Parameter mass: The value of the mass of the layer.
  - Parameter tolerance: The tolerance that will default to 0.0001.

  - Returns: A series of bakes that you can configure with all the animatable properties.
  */
  public func chain(delay delay: NSTimeInterval = 0, spring: CGFloat, friction: CGFloat,
    mass: CGFloat, tolerance: CGFloat = 0.0001, animations: Bake -> Void) -> Bakery {
      animations(constructor(1, delay: delay, spring, friction, mass: mass, tolerance: tolerance)[0])

      if !shouldProceed {
        delays.removeLast()
        bakes.removeLast()
        closures.removeLast()
      }

      return self
  }

  /**
   Chain gets executed when the first animate blocks of animations are done.

   - Parameter delay: The delay that this chain should wait to be triggered.
   - Parameter spring: The value of the spring in the animation.
   - Parameter friction: The value of the friction that the layer will present.
   - Parameter mass: The value of the mass of the layer.
   - Parameter tolerance: The tolerance that will default to 0.0001.

   - Returns: A series of bakes that you can configure with all the animatable properties.
   */
  public func chain(delay delay: NSTimeInterval = 0, spring: CGFloat, friction: CGFloat,
    mass: CGFloat, tolerance: CGFloat = 0.0001, animations: (Bake, Bake) -> Void) -> Bakery {
      let bakes = constructor(2, delay: delay, spring, friction, mass: mass, tolerance: tolerance)
      animations(bakes[0], bakes[1])

      return self
  }

  /**
   Chain gets executed when the first animate blocks of animations are done.

   - Parameter delay: The delay that this chain should wait to be triggered.
   - Parameter spring: The value of the spring in the animation.
   - Parameter friction: The value of the friction that the layer will present.
   - Parameter mass: The value of the mass of the layer.
   - Parameter tolerance: The tolerance that will default to 0.0001.

   - Returns: A series of bakes that you can configure with all the animatable properties.
   */
  public func chain(delay delay: NSTimeInterval = 0, spring: CGFloat, friction: CGFloat,
    mass: CGFloat, tolerance: CGFloat = 0.0001, animations: (Bake, Bake, Bake) -> Void) -> Bakery {
      let bakes = constructor(3, delay: delay, spring, friction, mass: mass, tolerance: tolerance)
      animations(bakes[0], bakes[1], bakes[2])

      return self
  }

  // MARK: - Private constructors

  private func bezier(value: Int, _ delay: NSTimeInterval,
    _ duration: NSTimeInterval, _ curve: Animation.Curve) -> [Bake] {

      var animationBakes: [Bake] = []
      for index in 0..<value {
        let bake = Bake(bakery: self, view: self.bakes[0][index].view, duration: duration, curve: curve)
        animationBakes.append(bake)
      }

      delays.append(delay)
      bakes.append(animationBakes)

      closures.append(nil)

      return animationBakes
  }

  private func constructor(value: Int, delay: NSTimeInterval, _ spring: CGFloat,
    _ friction: CGFloat, mass: CGFloat, tolerance: CGFloat) -> [Bake] {

      var animationBakes: [Bake] = []
      for index in 0..<value {
        let bake = Bake(bakery: self, view: self.bakes[0][index].view,
          spring: spring, friction: friction, mass: mass, tolerance: tolerance)
        animationBakes.append(bake)
      }

      delays.append(delay)
      bakes.append(animationBakes)
      closures.append(nil)
      
      return animationBakes
  }
}
