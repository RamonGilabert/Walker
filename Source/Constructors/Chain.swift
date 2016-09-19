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
  @discardableResult public func chain(delay: TimeInterval = 0, duration: TimeInterval = 0.5,
    curve: Animation.Curve = .linear, options: [Animation.Options] = [],
    animations: (Ingredient) -> Void) -> Distillery {

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
  @discardableResult public func chains(delay: TimeInterval = 0, duration: TimeInterval = 0.5,
    curve: Animation.Curve = .linear, options: [Animation.Options] = [],
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
  @discardableResult public func chainTwo(delay: TimeInterval = 0, duration: TimeInterval = 0.5,
    curve: Animation.Curve = .linear, options: [Animation.Options] = [],
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
  @discardableResult public func chainsTwo(delay: TimeInterval = 0, duration: TimeInterval = 0.5,
    curve: Animation.Curve = .linear, options: [Animation.Options] = [],
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
  @discardableResult public func chain(delay: TimeInterval = 0,
    spring: CGFloat, friction: CGFloat, mass: CGFloat, tolerance: CGFloat = 0.0001,
    kind: Animation.Spring = .spring, animations: (Ingredient) -> Void) -> Distillery {

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
  @discardableResult public func chains(delay: TimeInterval = 0, spring: CGFloat,
    friction: CGFloat, mass: CGFloat, tolerance: CGFloat = 0.0001,
    kind: Animation.Spring = .spring, animations: (Ingredient, Ingredient) -> Void) -> Distillery {

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
  @discardableResult public func chainTwo(delay: TimeInterval = 0, spring: CGFloat, friction: CGFloat,
    mass: CGFloat, tolerance: CGFloat = 0.0001, kind: Animation.Spring = .spring,
    animations: (Ingredient, Ingredient, Ingredient) -> Void) -> Distillery {

      let ingredients = constructor(3, delay: delay, spring, friction, mass: mass, tolerance: tolerance, kind)
      animations(ingredients[0], ingredients[1], ingredients[2])

      return self
  }

  // MARK: - Private constructors

  fileprivate func bezier(_ value: Int, _ delay: TimeInterval,
    _ duration: TimeInterval, _ curve: Animation.Curve, _ options: [Animation.Options]) -> [Ingredient] {

      var animationIngredients: [Ingredient] = []
      for index in 0..<value {
        let ingredient = Ingredient(distillery: self, view: self.ingredients[0][index].view, duration: duration, curve: curve, options: options)
        animationIngredients.append(ingredient)
      }

      if shouldProceed {
        delays.append(delay)
        ingredients.append(animationIngredients)
        closures.append(nil)
      }

      return animationIngredients
  }

  fileprivate func constructor(_ value: Int, delay: TimeInterval, _ spring: CGFloat,
    _ friction: CGFloat, mass: CGFloat, tolerance: CGFloat, _ calculation: Animation.Spring) -> [Ingredient] {

      var animationIngredients: [Ingredient] = []
      for index in 0..<value {
        let ingredient = Ingredient(distillery: self, view: self.ingredients[0][index].view,
          spring: spring, friction: friction, mass: mass, tolerance: tolerance, calculation: calculation)
        animationIngredients.append(ingredient)
      }

      if shouldProceed {
        delays.append(delay)
        ingredients.append(animationIngredients)
        closures.append(nil)
      }
      
      return animationIngredients
  }
}
