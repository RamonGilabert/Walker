import UIKit

extension Distillery {

  // MARK: - Bezier chains

  /**
  Chain gets executed when the first animate blocks of animations are done.

  - Parameter delay: The delay that this chain should wait to be triggered.
  - Parameter duration: The duration of the animation.
  - Parameter curve: The animation curve.
  - Parameter options: A set of options, for now .Reverse or .Repeat.

  - Returns: A series of ingredients that you can configure with all the animatable properties.
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
   - Parameter options: A set of options, for now .Reverse or .Repeat.

   - Returns: A series of ingredients that you can configure with all the animatable properties.
   */
  public func chains(delay delay: NSTimeInterval = 0, duration: NSTimeInterval = 0.5,
    curve: Animation.Curve = .Linear, options: [Animation.Options] = [],
     animations: (Ingredient, Ingredient) -> Void) -> Distillery {

      let ingredients = bezier(2, delay, duration, curve, options)
      animations(ingredients[0], ingredients[1])

      return self
  }

  /**
   Chain gets executed when the first animate blocks of animations are done.

   - Parameter delay: The delay that this chain should wait to be triggered.
   - Parameter duration: The duration of the animation.
   - Parameter curve: The animation curve.
   - Parameter options: A set of options, for now .Reverse or .Repeat.

   - Returns: A series of ingredients that you can configure with all the animatable properties.
   */
  public func chainTwo(delay delay: NSTimeInterval = 0, duration: NSTimeInterval = 0.5,
    curve: Animation.Curve = .Linear, options: [Animation.Options] = [],
    animations: (Ingredient, Ingredient, Ingredient) -> Void) -> Distillery {

      let ingredients = bezier(3, delay, duration, curve, options)
      animations(ingredients[0], ingredients[1], ingredients[2])

      return self
  }

  /**
   Chain gets executed when the first animate blocks of animations are done.

   - Parameter delay: The delay that this chain should wait to be triggered.
   - Parameter duration: The duration of the animation.
   - Parameter curve: The animation curve.
   - Parameter options: A set of options, for now .Reverse or .Repeat.

   - Returns: A series of ingredients that you can configure with all the animatable properties.
   */
  public func chainsTwo(delay delay: NSTimeInterval = 0, duration: NSTimeInterval = 0.5,
    curve: Animation.Curve = .Linear, options: [Animation.Options] = [],
    animations: (Ingredient, Ingredient, Ingredient, Ingredient) -> Void) -> Distillery {

      let ingredients = bezier(4, delay, duration, curve, options)
      animations(ingredients[0], ingredients[1], ingredients[2], ingredients[3])

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

  - Returns: A series of ingredients that you can configure with all the animatable properties.
  */
  public func chain(delay delay: NSTimeInterval = 0,
    spring: CGFloat, friction: CGFloat, mass: CGFloat, tolerance: CGFloat = 0.0001,
    kind: Animation.Spring = .Spring, animations: Ingredient -> Void) -> Distillery {

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

   - Returns: A series of ingredients that you can configure with all the animatable properties.
   */
  public func chains(delay delay: NSTimeInterval = 0, spring: CGFloat,
    friction: CGFloat, mass: CGFloat, tolerance: CGFloat = 0.0001,
    kind: Animation.Spring = .Spring, animations: (Ingredient, Ingredient) -> Void) -> Distillery {

      let ingredients = constructor(2, delay: delay, spring, friction, mass: mass, tolerance: tolerance, kind)
      animations(ingredients[0], ingredients[1])

      return self
  }

  /**
   Chain gets executed when the first animate blocks of animations are done.

   - Parameter delay: The delay that this chain should wait to be triggered.
   - Parameter spring: The value of the spring in the animation.
   - Parameter friction: The value of the friction that the layer will present.
   - Parameter mass: The value of the mass of the layer.
   - Parameter tolerance: The tolerance that will default to 0.0001.

   - Returns: A series of ingredients that you can configure with all the animatable properties.
   */
  public func chainTwo(delay delay: NSTimeInterval = 0, spring: CGFloat, friction: CGFloat,
    mass: CGFloat, tolerance: CGFloat = 0.0001, kind: Animation.Spring = .Spring,
    animations: (Ingredient, Ingredient, Ingredient) -> Void) -> Distillery {

      let ingredients = constructor(3, delay: delay, spring, friction, mass: mass, tolerance: tolerance, kind)
      animations(ingredients[0], ingredients[1], ingredients[2])

      return self
  }

  // MARK: - Private constructors

  private func bezier(value: Int, _ delay: NSTimeInterval,
    _ duration: NSTimeInterval, _ curve: Animation.Curve, _ options: [Animation.Options]) -> [Ingredient] {

      var animationIngredients: [Ingredient] = []
      for index in 0..<value {
        let ingredient = Ingredient(distillery: self, view: self.ingredients[0][index].view, duration: duration, curve: curve, options: options)
        animationIngredients.append(ingredient)
      }

      closeDistilleries()

      if shouldProceed {
        delays.append(delay)
        ingredients.append(animationIngredients)
        closures.append(nil)
      }

      return animationIngredients
  }

  private func constructor(value: Int, delay: NSTimeInterval, _ spring: CGFloat,
    _ friction: CGFloat, mass: CGFloat, tolerance: CGFloat, _ calculation: Animation.Spring) -> [Ingredient] {

      var animationIngredients: [Ingredient] = []
      for index in 0..<value {
        let ingredient = Ingredient(distillery: self, view: self.ingredients[0][index].view,
          spring: spring, friction: friction, mass: mass, tolerance: tolerance, calculation: calculation)
        animationIngredients.append(ingredient)
      }

      closeDistilleries()

      if shouldProceed {
        delays.append(delay)
        ingredients.append(animationIngredients)
        closures.append(nil)
      }
      
      return animationIngredients
  }
}
