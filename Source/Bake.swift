import UIKit

public class Bake: Equatable {

  internal enum Kind {
    case Bezier, Spring
  }

  /**
   Change the opacity of the layer.
   */
  public var alpha: CGFloat {
    didSet { alpha(alpha) }
  }

  /**
   Change the x position in the anchor point (0, 0).
   */
  public var x: CGFloat {
    didSet { x(x) }
  }

  /**
   Change the y position in the anchor point (0, 0).
   */
  public var y: CGFloat {
    didSet { y(y) }
  }

  /**
   Change the width of the layer.
   */
  public var width: CGFloat {
    didSet { width(width) }
  }

  /**
   Change the height of the layer.
   */
  public var height: CGFloat {
    didSet { height(height) }
  }

  /**
   Change the origin of the view in the anchor point (0, 0)
   */
  public var origin: CGPoint {
    didSet { origin(origin.x, origin.y) }
  }

  /**
   Change the size of the view.
   */
  public var size: CGSize {
    didSet { size(size.width, size.height) }
  }

  /**
   Change the frame of the view.
   */
  public var frame: CGRect {
    didSet { frame(frame.origin.x, frame.origin.y, frame.width, frame.height) }
  }

  /**
   Change the cornerRadius of the layer.
   */
  public var radius: CGFloat {
    didSet { radius(radius) }
  }

  /**
   Apply a transform value, can be any `CGAffineTransform`.
   */
  public var transform: CGAffineTransform {
    didSet { transform(transform) }
  }

  /**
   Change the opacity of the layer.
   */
  public func alpha(value: CGFloat) {
    animate(.Opacity, value)
  }

  /**
   Change the x position in the anchor point (0, 0).
   */
  public func x(value: CGFloat) {
    animate(.PositionX, value + view.frame.width / 2)
  }

  /**
   Change the y position in the anchor point (0, 0).
   */
  public func y(value: CGFloat) {
    animate(.PositionY, value + view.frame.height / 2)
  }

  /**
   Change the width of the layer.
   */
  public func width(value: CGFloat) {
    animate(.Width, value)
    animate(.PositionX, view.frame.origin.x + value / 2)
  }

  /**
   Change the height of the layer.
   */
  public func height(value: CGFloat) {
    animate(.Height, value)
    animate(.PositionY, view.frame.origin.y + value / 2)
  }

  /**
   Change the origin of the view in the anchor point (0, 0)
   */
  public func origin(x: CGFloat, _ y: CGFloat) {
    animate(.Origin, NSValue(CGPoint: CGPoint(x: x + view.frame.width / 2, y: y + view.frame.height / 2)))
  }

  /**
   Change the size of the view.
   */
  public func size(width: CGFloat, _ height: CGFloat) {
    animate(.Size, NSValue(CGSize: CGSize(width: width, height: height)))
    animate(.Origin, NSValue(CGPoint: CGPoint(x: view.frame.origin.x + width / 2, y: view.frame.origin.y + height / 2)))
  }

  /**
   Change the frame of the view.
   */
  public func frame(x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
    animate(.Frame, NSValue(CGRect: CGRect(x: x, y: y, width: width, height: height)))
  }

  /**
   Change the cornerRadius of the layer.
   */
  public func radius(value: CGFloat) {
    animate(.CornerRadius, value)
  }

  /**
   Apply a transform value, can be any `CGAffineTransform`.
   */
  public func transform(value: CGAffineTransform) {
    animate(.Transform, NSValue(CATransform3D: CATransform3DMakeAffineTransform(value)))
  }

  internal let view: UIView
  internal let duration: NSTimeInterval
  internal let curve: Animation.Curve
  internal let kind: Kind
  internal let calculation: Animation.Spring
  internal let spring: (spring: CGFloat, friction: CGFloat, mass: CGFloat, tolerance: CGFloat)
  var animations: [CAKeyframeAnimation] = []
  var properties: [Animation.Property] = []
  var finalValues: [NSValue] = []
  var bakery: Bakery

  init(bakery: Bakery, view: UIView, duration: NSTimeInterval, curve: Animation.Curve) {
    self.bakery = bakery
    self.view = view
    self.duration = duration
    self.curve = curve
    self.kind = .Bezier
    self.calculation = .Spring
    self.spring = (0, 0, 0, 0)
    self.alpha = view.alpha
    self.x = view.frame.origin.x
    self.y = view.frame.origin.y
    self.width = view.frame.width
    self.height = view.frame.height
    self.origin = view.frame.origin
    self.size = view.frame.size
    self.frame = view.frame
    self.radius = view.layer.cornerRadius
    self.transform = view.transform
  }

  init(bakery: Bakery, view: UIView, spring: CGFloat, friction: CGFloat, mass: CGFloat, tolerance: CGFloat, calculation: Animation.Spring) {
    self.bakery = bakery
    self.view = view
    self.duration = 0
    self.curve = .Linear
    self.kind = .Spring
    self.calculation = calculation
    self.spring = (spring, friction, mass, tolerance)
    self.alpha = view.alpha
    self.x = view.frame.origin.x
    self.y = view.frame.origin.y
    self.width = view.frame.width
    self.height = view.frame.height
    self.origin = view.frame.origin
    self.size = view.frame.size
    self.frame = view.frame
    self.radius = view.layer.cornerRadius
    self.transform = view.transform
  }

  private func animate(property: Animation.Property, _ value: NSValue) {
    var animation = CAKeyframeAnimation()

    if kind == .Bezier {
      animation = Baker.bezier(property, bezierPoints: Animation.points(curve), duration: duration)
      animation.values = [value]
      animation.delegate = bakery
    } else {
      animation = Baker.spring(property, spring: spring.spring,
        friction: spring.friction, mass: spring.mass, tolerance: spring.tolerance, type: .Spring)
      animation.delegate = bakery
    }

    animations.append(animation)
    properties.append(property)
    finalValues.append(value)
  }
}

public func ==(lhs: Bake, rhs: Bake) -> Bool {
  return lhs.view == rhs.view && lhs.properties == rhs.properties && lhs.finalValues == rhs.finalValues
}
