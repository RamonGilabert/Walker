import UIKit

public class Bake {

  public var alpha: CGFloat {
    didSet { alpha(alpha) }
  }

  public var x: CGFloat {
    didSet { x(x) }
  }

  public var y: CGFloat {
    didSet { y(y) }
  }

  public var width: CGFloat {
    didSet { width(width) }
  }

  public var height: CGFloat {
    didSet { height(height) }
  }

  public var origin: CGPoint {
    didSet { origin(origin.x, origin.y) }
  }

  public var size: CGSize {
    didSet { size(size.width, size.height) }
  }

  public var frame: CGRect {
    didSet { frame(frame.origin.x, frame.origin.y, frame.width, frame.height) }
  }

  public var radius: CGFloat {
    didSet { radius(radius) }
  }

  public var transform: CGAffineTransform {
    didSet { transform(transform) }
  }

  public func alpha(value: CGFloat) {
    animate(.Opacity, value)
  }

  public func x(value: CGFloat) {
    animate(.PositionX, value + view.frame.width / 2)
  }

  public func y(value: CGFloat) {
    animate(.PositionY, value + view.frame.height / 2)
  }

  public func width(value: CGFloat) {
    animate(.Width, value)
  }

  public func height(value: CGFloat) {
    animate(.Height, value)
  }

  public func origin(x: CGFloat, _ y: CGFloat) {
    animate(.Origin, NSValue(CGPoint: CGPoint(x: x + view.frame.width / 2, y: y + view.frame.height / 2)))
  }

  public func size(width: CGFloat, _ height: CGFloat) {
    animate(.Size, NSValue(CGSize: CGSize(width: width, height: height)))
  }

  public func frame(x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
    animate(.Frame, NSValue(CGRect: CGRect(x: x, y: y, width: width, height: height)))
  }

  public func radius(value: CGFloat) {
    animate(.CornerRadius, value)
  }

  public func transform(value: CGAffineTransform) {
    animate(.Transform, NSValue(CATransform3D: CATransform3DMakeAffineTransform(value)))
  }

  internal let view: UIView
  internal let duration: NSTimeInterval
  internal let curve: Animation.Curve
  var animations: [CAKeyframeAnimation] = []
  var properties: [Animation.Property] = []

  init(view: UIView, duration: NSTimeInterval, curve: Animation.Curve) {
    self.view = view
    self.duration = duration
    self.curve = curve
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
    let animation = Baker.bezier(property, bezierPoints: Animation.points(curve), duration: duration)
    animation.values = [value]

    animations.append(animation)
    properties.append(property)
  }
}