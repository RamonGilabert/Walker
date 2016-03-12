import UIKit

public class Ingredient: Equatable {

  internal enum Kind {
    case Bezier, Spring
  }

  /**
   Changes the opacity of the layer.
   */
  public var alpha: CGFloat {
    didSet { alpha(alpha) }
  }

  /**
   Changes the x position in the anchor point (0, 0).
   */
  public var x: CGFloat {
    didSet { x(x) }
  }

  /**
   Changes the y position in the anchor point (0, 0).
   */
  public var y: CGFloat {
    didSet { y(y) }
  }

  /**
   Changes the width of the layer.
   */
  public var width: CGFloat {
    didSet { width(width) }
  }

  /**
   Changes the height of the layer.
   */
  public var height: CGFloat {
    didSet { height(height) }
  }

  /**
   Changes the origin of the view in the anchor point (0, 0)
   */
  public var origin: CGPoint {
    didSet { origin(origin.x, origin.y) }
  }

  /**
   Changes the size of the view.
   */
  public var size: CGSize {
    didSet { size(size.width, size.height) }
  }

  /**
   Changes the frame of the view.
   */
  public var frame: CGRect {
    didSet { frame(frame.origin.x, frame.origin.y, frame.width, frame.height) }
  }

  /**
   Changes the cornerRadius of the layer.
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
   Apply a transform value, can be any `CATransform3D`.
   */
  public var transform3D: CATransform3D {
    didSet { transform3D(transform3D) }
  }

  /**
   Changes the opacity of the layer.
   */
  public func alpha(value: CGFloat) {
    animate(.Opacity, value)
  }

  /**
   Changes the x position in the anchor point (0, 0).
   */
  public func x(value: CGFloat) {
    animate(.PositionX, value + view.frame.width / 2)
  }

  /**
   Changes the y position in the anchor point (0, 0).
   */
  public func y(value: CGFloat) {
    animate(.PositionY, value + view.frame.height / 2)
  }

  /**
   Changes the width of the layer.
   */
  public func width(value: CGFloat) {
    animate(.Width, value)
    animate(.PositionX, view.frame.origin.x + value / 2)
  }

  /**
   Changes the height of the layer.
   */
  public func height(value: CGFloat) {
    animate(.Height, value)
    animate(.PositionY, view.frame.origin.y + value / 2)
  }

  /**
   Changes the origin of the view in the anchor point (0, 0)
   */
  public func origin(x: CGFloat, _ y: CGFloat) {
    animate(.Origin, NSValue(CGPoint: CGPoint(x: x + view.frame.width / 2, y: y + view.frame.height / 2)))
  }

  /**
   Changes the size of the view.
   */
  public func size(width: CGFloat, _ height: CGFloat) {
    animate(.Size, NSValue(CGSize: CGSize(width: width, height: height)))
    animate(.Origin, NSValue(CGPoint: CGPoint(x: view.frame.origin.x + width / 2, y: view.frame.origin.y + height / 2)))
  }

  /**
   Changes the frame of the view.
   */
  public func frame(x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
    animate(.Size, NSValue(CGSize: CGSize(width: width, height: height)))
    animate(.Origin, NSValue(CGPoint: CGPoint(x: x + width / 2, y: y + height / 2)))
  }

  /**
   Changes the cornerRadius of the layer.
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

  /**
   Apply a transform value, can be any `CATransform3D`.
   */
  public func transform3D(value: CATransform3D) {
    animate(.Transform, NSValue(CATransform3D: value))
  }

  internal let view: UIView
  internal let duration: NSTimeInterval
  internal let curve: Animation.Curve
  internal let kind: Kind
  internal let calculation: Animation.Spring
  internal let spring: (spring: CGFloat, friction: CGFloat, mass: CGFloat, tolerance: CGFloat)
  internal let options: [Animation.Options]
  var animations: [CAKeyframeAnimation] = []
  var properties: [Animation.Property] = []
  var finalValues: [NSValue] = []
  var springs: [(spring: CGFloat, friction: CGFloat, mass: CGFloat, tolerance: CGFloat)] = []
  var distillery: Distillery

  init(distillery: Distillery, view: UIView, duration: NSTimeInterval,
    curve: Animation.Curve, options: [Animation.Options]) {

      self.distillery = distillery
      self.view = view
      self.duration = duration
      self.curve = curve
      self.kind = .Bezier
      self.calculation = .Spring
      self.options = options
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
      self.transform3D = view.layer.transform
  }

  init(distillery: Distillery, view: UIView, spring: CGFloat, friction: CGFloat, mass: CGFloat,
    tolerance: CGFloat, calculation: Animation.Spring, options: [Animation.Options] = []) {

      self.distillery = distillery
      self.view = view
      self.duration = 0
      self.curve = .Linear
      self.kind = .Spring
      self.calculation = calculation
      self.options = options
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
      self.transform3D = view.layer.transform
  }

  func animate(property: Animation.Property, _ value: NSValue) {
    var animation = CAKeyframeAnimation()

    if kind == .Bezier {
      animation = Distill.bezier(property, bezierPoints: Animation.points(curve), duration: duration, options: options)
      animation.values = [value]
      animation.delegate = distillery
    } else {
      animation = Distill.spring(property, type: .Spring)
      animation.delegate = distillery
    }

    animations.append(animation)
    properties.append(property)
    finalValues.append(value)
    springs.append(spring)
  }
}

public func ==(lhs: Ingredient, rhs: Ingredient) -> Bool {
  return lhs.view == rhs.view && lhs.properties == rhs.properties && lhs.finalValues == rhs.finalValues
}
