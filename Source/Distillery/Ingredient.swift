import UIKit

open class Ingredient: Equatable {

  internal enum Kind {
    case bezier, spring
  }

  /**
   Changes the opacity of the layer.
   */
  open var alpha: CGFloat {
    didSet { alpha(alpha) }
  }

  /**
   Changes the x position in the anchor point (0, 0).
   */
  open var x: CGFloat {
    didSet { x(x) }
  }

  /**
   Changes the y position in the anchor point (0, 0).
   */
  open var y: CGFloat {
    didSet { y(y) }
  }

  /**
   Changes the width of the layer.
   */
  open var width: CGFloat {
    didSet { width(width) }
  }

  /**
   Changes the height of the layer.
   */
  open var height: CGFloat {
    didSet { height(height) }
  }

  /**
   Changes the origin of the view in the anchor point (0, 0)
   */
  open var origin: CGPoint {
    didSet { origin(origin.x, origin.y) }
  }

  /**
   Changes the size of the view.
   */
  open var size: CGSize {
    didSet { size(size.width, size.height) }
  }

  /**
   Changes the frame of the view.
   */
  open var frame: CGRect {
    didSet { frame(frame.origin.x, frame.origin.y, frame.width, frame.height) }
  }

  /**
   Changes the cornerRadius of the layer.
   */
  open var radius: CGFloat {
    didSet { radius(radius) }
  }

  /**
   Apply a transform value, can be any `CGAffineTransform`.
   */
  open var transform: CGAffineTransform {
    didSet { transform(transform) }
  }

  /**
   Apply a transform value, can be any `CATransform3D`.
   */
  open var transform3D: CATransform3D {
    didSet { transform3D(transform3D) }
  }

  /**
   Changes the opacity of the layer.
   */
  open func alpha(_ value: CGFloat) {
    animate(.Opacity, value as NSValue)
  }

  /**
   Changes the x position in the anchor point (0, 0).
   */
  open func x(_ value: CGFloat) {
    animate(.PositionX, value + view.frame.width / 2 as NSValue)
  }

  /**
   Changes the y position in the anchor point (0, 0).
   */
  open func y(_ value: CGFloat) {
    animate(.PositionY, value + view.frame.height / 2 as NSValue)
  }

  /**
   Changes the width of the layer.
   */
  open func width(_ value: CGFloat) {
    animate(.Width, value as NSValue)
    animate(.PositionX, view.frame.origin.x + value / 2 as NSValue)
  }

  /**
   Changes the height of the layer.
   */
  open func height(_ value: CGFloat) {
    animate(.Height, value as NSValue)
    animate(.PositionY, view.frame.origin.y + value / 2 as NSValue)
  }

  /**
   Changes the origin of the view in the anchor point (0, 0)
   */
  open func origin(_ x: CGFloat, _ y: CGFloat) {
    animate(.Origin, NSValue(cgPoint: CGPoint(x: x + view.frame.width / 2, y: y + view.frame.height / 2)))
  }

  /**
   Changes the size of the view.
   */
  open func size(_ width: CGFloat, _ height: CGFloat) {
    animate(.Size, NSValue(cgSize: CGSize(width: width, height: height)))
    animate(.Origin, NSValue(cgPoint: CGPoint(x: view.frame.origin.x + width / 2, y: view.frame.origin.y + height / 2)))
  }

  /**
   Changes the frame of the view.
   */
  open func frame(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
    animate(.Size, NSValue(cgSize: CGSize(width: width, height: height)))
    animate(.Origin, NSValue(cgPoint: CGPoint(x: x + width / 2, y: y + height / 2)))
  }

  /**
   Changes the cornerRadius of the layer.
   */
  open func radius(_ value: CGFloat) {
    animate(.CornerRadius, value as NSValue)
  }

  /**
   Apply a transform value, can be any `CGAffineTransform`.
   */
  open func transform(_ value: CGAffineTransform) {
    animate(.Transform, NSValue(caTransform3D: CATransform3DMakeAffineTransform(value)))
  }

  /**
   Apply a transform value, can be any `CATransform3D`.
   */
  open func transform3D(_ value: CATransform3D) {
    animate(.Transform, NSValue(caTransform3D: value))
  }

  internal let view: UIView
  internal let duration: TimeInterval
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

  init(distillery: Distillery, view: UIView, duration: TimeInterval,
    curve: Animation.Curve, options: [Animation.Options]) {

      self.distillery = distillery
      self.view = view
      self.duration = duration
      self.curve = curve
      self.kind = .bezier
      self.calculation = .spring
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
      self.curve = .linear
      self.kind = .spring
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

  func animate(_ property: Animation.Property, _ value: NSValue) {
    var animation = CAKeyframeAnimation()

    if kind == .bezier {
      animation = Distill.bezier(property, bezierPoints: Animation.points(curve), duration: duration, options: options)
      animation.values = [value]
      animation.delegate = distillery
    } else {
      animation = Distill.spring(property, type: .spring)
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
