import Foundation

extension CALayer {

  func animateSpring(property: Animation.Property, to: NSValue,
    spring: CGFloat, friction: CGFloat, mass: CGFloat, tolerance: CGFloat = 0.0001) {
      //let animation = Baker.configureSpringAnimations(property, to: to, spring: spring,
        //friction: friction, mass: mass, tolerance: tolerance, type: .Spring, layer: self)

      //addAnimation(animation, forKey: nil)
  }

  func animateSpringBounce(property: Animation.Property, to: NSValue,
    spring: CGFloat, friction: CGFloat, mass: CGFloat, tolerance: CGFloat = 0.0001) {
      //let animation = Baker.configureSpringAnimations(property, to: to, spring: spring,
        //friction: friction, mass: mass, tolerance: tolerance, type: .Bounce, layer: self)

      //addAnimation(animation, forKey: nil)
  }
}
