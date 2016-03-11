import UIKit

extension Distillery {

  // MARK: - Bezier chains

  /**
  Chain gets executed when the first animate blocks of animations are done.

  - Parameter delay: The delay that this chain should wait to be triggered.
  - Parameter duration: The duration of the animation.
  - Parameter curve: The animation curve.

  - Returns: A series of bakes that you can configure with all the animatable properties.
  */
  public func chain(delay delay: NSTimeInterval = 0, duration: NSTimeInterval = 0.5,
    curve: Animation.Curve = .Linear, options: [Animation.Options] = [],
    animations: Ingredient -> Void) -> Distillery {

      animations(bezier(1, delay, duration, curve, options)[0])

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
    curve: Animation.Curve = .Linear, options: [Animation.Options] = [],
     animations: (Ingredient, Ingredient) -> Void) -> Distillery {

      let bakes = bezier(2, delay, duration, curve, options)
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
    curve: Animation.Curve = .Linear, options: [Animation.Options] = [],
    animations: (Ingredient, Ingredient, Ingredient) -> Void) -> Distillery {

      let bakes = bezier(3, delay, duration, curve, options)
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
    curve: Animation.Curve = .Linear, options: [Animation.Options] = [],
    animations: (Ingredient, Ingredient, Ingredient, Ingredient) -> Void) -> Distillery {

      let bakes = bezier(4, delay, duration, curve, options)
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
    mass: CGFloat, tolerance: CGFloat = 0.0001, kind: Animation.Spring = .Spring, animations: Ingredient -> Void) -> Distillery {
      animations(constructor(1, delay: delay, spring, friction, mass: mass, tolerance: tolerance, kind)[0])

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
    mass: CGFloat, tolerance: CGFloat = 0.0001, kind: Animation.Spring = .Spring, animations: (Ingredient, Ingredient) -> Void) -> Distillery {
      let bakes = constructor(2, delay: delay, spring, friction, mass: mass, tolerance: tolerance, kind)
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
    mass: CGFloat, tolerance: CGFloat = 0.0001, kind: Animation.Spring = .Spring,
    animations: (Ingredient, Ingredient, Ingredient) -> Void) -> Distillery {

      let bakes = constructor(3, delay: delay, spring, friction, mass: mass, tolerance: tolerance, kind)
      animations(bakes[0], bakes[1], bakes[2])

      return self
  }

  // MARK: - Private constructors

  private func bezier(value: Int, _ delay: NSTimeInterval,
    _ duration: NSTimeInterval, _ curve: Animation.Curve, _ options: [Animation.Options]) -> [Ingredient] {

      var animationBakes: [Ingredient] = []
      for index in 0..<value {
        let bake = Ingredient(distillery: self, view: self.bakes[0][index].view, duration: duration, curve: curve, options: options)
        animationBakes.append(bake)
      }

      if shouldProceed {
        delays.append(delay)
        bakes.append(animationBakes)
        closures.append(nil)
      }

      return animationBakes
  }

  private func constructor(value: Int, delay: NSTimeInterval, _ spring: CGFloat,
    _ friction: CGFloat, mass: CGFloat, tolerance: CGFloat, _ calculation: Animation.Spring) -> [Ingredient] {

      var animationBakes: [Ingredient] = []
      for index in 0..<value {
        let bake = Ingredient(distillery: self, view: self.bakes[0][index].view,
          spring: spring, friction: friction, mass: mass, tolerance: tolerance, calculation: calculation)
        animationBakes.append(bake)
      }

      if shouldProceed {
        delays.append(delay)
        bakes.append(animationBakes)
        closures.append(nil)
      }
      
      return animationBakes
  }
}
